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

def main():
    parser = argparse.ArgumentParser(description="Add a new Homebrew formula")
    parser.add_argument("repo_name", help="Name of the GitHub repository")
    parser.add_argument("owner", nargs="?", default="nicholaswilde", help="GitHub owner (default: nicholaswilde)")
    args = parser.parse_args()

    repo = f"{args.owner}/{args.repo_name}"
    print(f"Adding formula for repository: {repo}")

    try:
        details = get_repo_details(repo)
        print(f"Fetched details: {details}")
        
        version, assets = get_latest_release(repo)
        print(f"Latest version: {version}")
        
        class_name = to_camel_case(args.repo_name)
        print(f"Generated class name: {class_name}")

        mapped_assets = map_assets(assets)
        print(f"Mapped assets: {list(mapped_assets.keys())}")
        
        for platform, info in mapped_assets.items():
            print(f"Calculating checksum for {platform}...")
            info["sha256"] = calculate_sha256(info["url"])
            print(f"Checksum: {info['sha256']}")

    except Exception as e:
        print(f"Error fetching repository details: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
