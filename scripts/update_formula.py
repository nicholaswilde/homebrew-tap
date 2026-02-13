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

def main():
    parser = argparse.ArgumentParser(description="Update Homebrew formula")
    parser.add_argument("formula_name", nargs="?", help="Name of the formula to update")
    parser.add_argument("--dry-run", action="store_true", help="Preview changes without applying them")
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

    try:
        latest_version, assets = get_latest_release(repo)
        print(f"Latest version: {latest_version}")
    except Exception as e:
        print(f"Error fetching latest release from GitHub: {e}")
        sys.exit(1)

    if args.dry_run:
        print("Running in DRY RUN mode.")

    # In a real scenario, we'd need to identify which asset to download based on the formula structure.
    # For now, we'll just print the latest version found.
    # The checksum calculation requires matching the asset to the OS/Arch.

if __name__ == "__main__":
    main()
