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

def to_camel_case(text):
    return ''.join(word.capitalize() for word in re.split(r'[-_]', text))

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

    except Exception as e:
        print(f"Error fetching repository details: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
