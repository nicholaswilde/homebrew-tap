import os
import sys
import argparse
import re
import json
import hashlib
from urllib.request import urlopen, Request
from find_formula import find_formula

def extract_github_repo(content):
    # Regex to find GitHub URLs in the 'url' field
    match = re.search(r'url\s+"https://github\.com/([^/]+)/([^/]+)/', content)
    if match:
        return f"{match.group(1)}/{match.group(2)}"
    return None

def get_latest_release(repo):
    url = f"https://api.github.com/repos/{repo}/releases/latest"
    req = Request(url)
    # Add User-Agent as required by GitHub API
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

def update_formula_content(content, new_version, new_sha256=None):
    # Update version
    old_version_match = re.search(r'version "([^"]+)"', content)
    if old_version_match:
        old_version = old_version_match.group(1)
        new_content = re.sub(r'version "([^"]+)"', f'version "{new_version}"', content)
    else:
        # Fallback: extract from URL
        url_match = re.search(r'url\s+"https://github\.com/[^/]+/[^/]+/releases/download/v?([^/]+)/', content)
        old_version = url_match.group(1) if url_match else "unknown"
        # If no version field, we might want to add one or just rely on URL replacement in future
        new_content = content
    
    if new_sha256:
        # Simplification: replace ALL sha256 for now. 
        new_content = re.sub(r'sha256 "([^"]+)"', f'sha256 "{new_sha256}"', new_content)
    
    # Always update versions in URLs as well
    new_content = re.sub(r'/download/v?[^/]+/', f'/download/v{new_version}/', new_content)
    new_content = re.sub(r'-[0-9]+\.[0-9]+\.[0-9]+', f'-{new_version}', new_content)
    
    return new_content, old_version

def main():
    parser = argparse.ArgumentParser(description="Update Homebrew formula")
    parser.add_argument("formula_name", nargs="?", help="Name of the formula to update")
    parser.add_argument("--dry-run", action="store_true", help="Preview changes without applying them")
    parser.add_argument("--version-override", help="Force update to a specific version")
    args = parser.parse_args()

    match, all_formulas = find_formula(args.formula_name)

    if not match:
        if args.formula_name:
            print(f"Error: Could not find formula matching '{args.formula_name}'")
        else:
            print("Error: No formula name provided.")
        print("Available formulas:", ", ".join(all_formulas))
        sys.exit(1)

    print(f"Selected formula: {match}")
    
    formula_path = f"Formula/{match}.rb"
    with open(formula_path, "r") as f:
        content = f.read()

    repo = extract_github_repo(content)
    if not repo:
        print(f"Error: Could not find GitHub repository URL in {formula_path}")
        sys.exit(1)

    print(f"Upstream repository: {repo}")

    if args.version_override:
        latest_version = args.version_override
        print(f"Using version override: {latest_version}")
    else:
        try:
            latest_version, assets = get_latest_release(repo)
            print(f"Latest version: {latest_version}")
        except Exception as e:
            print(f"Error fetching latest release from GitHub: {e}")
            sys.exit(1)

    new_content, old_version = update_formula_content(content, latest_version)

    if old_version == latest_version:
        print(f"Formula is already at the latest version ({latest_version}).")
        return

    print(f"Updating {match} from {old_version} to {latest_version}")

    if args.dry_run:
        print("--- DRY RUN: Proposed Changes ---")
        # Print a simple diff-like view
        for line in new_content.splitlines():
            if 'version "' in line and latest_version in line:
                print(f"+ {line}")
            elif 'version "' in line:
                # This won't show the old version because we already replaced it in new_content
                pass
        print("---------------------------------")
    else:
        with open(formula_path, "w") as f:
            f.write(new_content)
        print(f"Successfully updated {formula_path}")

if __name__ == "__main__":
    main()
