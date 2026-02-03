# Gemini CLI - Homebrew Tap Context

This file provides instructions and context for the Gemini CLI when working on this repository.

## Project Structure
- `Formula/`: Contains Homebrew formula Ruby files (.rb).
- `conductor/`: Contains project management and tracking documents.

## Guidelines for Formula Updates
When updating formulas:
1.  **Maintain Style**: Adhere to the existing Ruby coding style and structure in the .rb files.
2.  **Version Consistency**: Ensure the `version` field matches the tag/release version exactly.
3.  **URL Mapping**: Verify that the download URLs are correctly constructed for each platform and architecture (e.g., macOS arm64 vs. Linux x86_64).
4.  **Checksums**: Always recalculate SHA256 checksums by downloading the assets. Do not guess or use old checksums.
5.  **Multi-Platform Support**: Most formulas in this tap support both macOS and Linux across multiple architectures. Ensure all relevant `on_macos` and `on_linux` blocks are updated.

## Automated Update Workflow
You are an automated Homebrew formula updater. Your goal is to keep formulas in the 'Formula/' directory up-to-date with their upstream GitHub releases.

1.  **Scan and Parse**: Identify the target formula(s). Read the `.rb` file(s) and identify the upstream GitHub repository from the `homepage` or `url` field.
2.  **Check for Updates**: For each formula, use the GitHub CLI (`gh release view --json tagName,assets`) or the GitHub API to find the latest stable release.
3.  **Compare Versions**: Compare the latest `tagName` (removing any 'v' prefix) with the `version` field in the formula. Proceed only if a newer version is available.
4.  **Update Assets**:
    a.  Identify the required assets for each platform and architecture (macOS/Linux, ARM/Intel).
    b.  Download these assets and calculate their SHA256 checksums using `sha256sum`.
    c.  Update the `version` string at the top of the formula class.
    d.  Update the `url` and `sha256` strings within the `on_macos` and `on_linux` blocks, ensuring they match the correct hardware architecture (ARM vs Intel).
    e.  If the installation path includes the version number (e.g., `bin.install "proxmox-mcp-rs-0.3.29-..."`), ensure those strings are also updated to the new version.
5.  **Maintain Integrity**: Ensure the Ruby syntax remains perfectly valid. Mimic the existing indentation and quote style.
6.  **Verify**: If possible, run `brew audit --strict <formula>` locally to ensure the updated formula is valid.

## Tool Usage
You have access to the shell. Use standard tools like `curl`, `sha256sum`, and `gh` (GitHub CLI) to perform your tasks.
