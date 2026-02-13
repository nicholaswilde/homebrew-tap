import os
import sys
import argparse
import re
import json
import hashlib
from urllib.request import urlopen, Request

def get_repo_details(repo):
    url = f"https://api.github.com/repos/{repo}"
    req = Request(url)
    req.add_header('User-Agent', 'Gemini-CLI-Homebrew-Updater')
    
    with urlopen(req) as response:
        data = json.loads(response.read().decode())
        return {
            "description": data.get("description", ""),
            "homepage": data.get("homepage", data.get("html_url", "")),
            "license": data.get("license", {}).get("spdx_id", "Apache-2.0") if data.get("license") else "Apache-2.0"
        }

def get_latest_release(repo):
    url = f"https://api.github.com/repos/{repo}/releases/latest"
    req = Request(url)
    req.add_header('User-Agent', 'Gemini-CLI-Homebrew-Updater')
    
    with urlopen(req) as response:
        data = json.loads(response.read().decode())
        return data['tag_name'].lstrip('v'), data['assets']

def calculate_sha256(url):
    sha256_hash = hashlib.sha256()
    with urlopen(url) as response:
        for byte_block in iter(lambda: response.read(4096), b""):
            sha256_hash.update(byte_block)
    return sha256_hash.hexdigest()

def to_camel_case(text):
    return ''.join(word.capitalize() for word in re.split(r'[-_]', text))

def map_assets(assets):
    mapping = {
        "macos_arm64": [r"Darwin_arm64", r"aarch64-apple-darwin"],
        "macos_x86_64": [r"Darwin_x86_64", r"x86_64-apple-darwin"],
        "linux_arm64": [r"Linux_arm64", r"aarch64-unknown-linux-musl"],
        "linux_x86_64": [r"Linux_x86_64", r"x86_64-unknown-linux-musl"],
        "linux_armv6": [r"Linux_armv6", r"arm-unknown-linux-gnueabihf", r"armv7-unknown-linux-musleabihf"]
    }
    
    result = {}
    for platform, patterns in mapping.items():
        for asset in assets:
            if any(re.search(p, asset['name'], re.IGNORECASE) for p in patterns) and asset['name'].endswith(".tar.gz"):
                result[platform] = {
                    "url": asset['browser_download_url'],
                    "filename": asset['name']
                }
                break
    return result

def generate_formula(class_name, details, version, mapped_assets):
    template = f"""# typed: false
# frozen_string_literal: true

class {class_name} < Formula
  desc "{details['description']}"
  homepage "{details['homepage']}"
  version "{version}"
  license "{details['license']}"

  on_macos do
"""
    if "macos_arm64" in mapped_assets:
        info = mapped_assets["macos_arm64"]
        template += f"""    if Hardware::CPU.arm?
      url "{info['url']}"
      sha256 "{info['sha256']}"
    end
"""
    if "macos_x86_64" in mapped_assets:
        info = mapped_assets["macos_x86_64"]
        template += f"""    if Hardware::CPU.intel?
      url "{info['url']}"
      sha256 "{info['sha256']}"
    end
"""
    template += """  end

  on_linux do
"""
    if "linux_arm64" in mapped_assets:
        info = mapped_assets["linux_arm64"]
        template += f"""    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "{info['url']}"
      sha256 "{info['sha256']}"
    end
"""
    if "linux_x86_64" in mapped_assets:
        info = mapped_assets["linux_x86_64"]
        template += f"""    if Hardware::CPU.intel?
      url "{info['url']}"
      sha256 "{info['sha256']}"
    end
"""
    if "linux_armv6" in mapped_assets:
        info = mapped_assets["linux_armv6"]
        template += f"""    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "{info['url']}"
      sha256 "{info['sha256']}"
    end
"""
    template += f"""  end

  def install
    bin.install Dir["**/{details['repo_name']}"].first
  end

  test do
    system "#{{bin}}/{details['repo_name']}", "--help"
  end
end
"""
    return template

def update_taskfile(formula_name):
    taskfile_path = "Taskfile.yml"
    with open(taskfile_path, "r") as f:
        lines = f.readlines()

    # Find the unified audit task's cmds list
    new_lines = []
    in_audit_task = False
    in_audit_cmds = False
    added_to_unified = False

    for i, line in enumerate(lines):
        new_lines.append(line)
        if line.strip() == "audit:":
            in_audit_task = True
        elif in_audit_task and line.strip() == "cmds:":
            in_audit_cmds = True
        elif in_audit_cmds and line.strip().startswith("- task: audit:") and not added_to_unified:
            # Check if it's already there
            if f"- task: audit:{formula_name}" in line:
                added_to_unified = True
            
            # If we are at the end of the list or the next line is not an audit task
            if i + 1 < len(lines) and not lines[i+1].strip().startswith("- task: audit:"):
                 new_lines.append(f"      - task: audit:{formula_name}\n")
                 added_to_unified = True

    # Add the individual task at the end of the file or before the next main section
    if not any(f"audit:{formula_name}:" in line for line in lines):
        new_lines.append(f"\n  audit:{formula_name}:\n")
        new_lines.append(f"    desc: Audit {formula_name} formula\n")
        new_lines.append(f"    cmds:\n")
        new_lines.append(f"      - brew audit --tap nicholaswilde/homebrew-tap Formula/{formula_name}.rb\n")

    with open(taskfile_path, "w") as f:
        f.writelines(new_lines)

def main():
    parser = argparse.ArgumentParser(description="Add a new Homebrew formula")
    parser.add_argument("formula_name", help="Name of the formula to create")
    parser.add_argument("owner", nargs="?", default="nicholaswilde", help="GitHub owner (default: nicholaswilde)")
    parser.add_argument("--repo", help="GitHub repository name (defaults to formula_name)")
    parser.add_argument("--dry-run", action="store_true", help="Preview changes without applying them")
    args = parser.parse_args()

    repo_name = args.repo if args.repo else args.formula_name
    repo = f"{args.owner}/{repo_name}"
    print(f"Adding formula {args.formula_name} for repository: {repo}")

    try:
        details = get_repo_details(repo)
        details['repo_name'] = repo_name
        print(f"Fetched details: {details}")
        
        version, assets = get_latest_release(repo)
        print(f"Latest version: {version}")
        
        class_name = to_camel_case(args.formula_name)
        print(f"Generated class name: {class_name}")

        mapped_assets = map_assets(assets)
        print(f"Mapped assets: {list(mapped_assets.keys())}")
        
        for platform, info in mapped_assets.items():
            print(f"Calculating checksum for {platform}...")
            info["sha256"] = calculate_sha256(info["url"])
            print(f"Checksum: {info['sha256']}")

        formula_content = generate_formula(class_name, details, version, mapped_assets)
        formula_path = f"Formula/{args.formula_name}.rb"

        if args.dry_run:
            print(f"--- DRY RUN: Proposed Formula {formula_path} ---")
            print(formula_content)
            print("--- DRY RUN: Taskfile updates would be applied ---")
        else:
            with open(formula_path, "w") as f:
                f.write(formula_content)
            print(f"Successfully created {formula_path}")
            
            update_taskfile(args.formula_name)
            print(f"Successfully updated Taskfile.yml")

    except Exception as e:

        print(f"Error fetching repository details: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
