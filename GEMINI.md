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

## Tool Usage
You have access to the shell. Use standard tools like `curl`, `sha256sum`, and `gh` (GitHub CLI) to perform your tasks.
