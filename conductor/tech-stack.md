# Tech Stack - homebrew-tap

## Core Platform
- **Homebrew:** The primary package manager used for distributing and managing CLI tools.

## Development & Automation
- **Ruby:** The language used for writing Homebrew formula definitions (`.rb` files).
- **GoReleaser:** Used as the upstream release automation tool to generate formula updates and manage artifacts.
- **GitHub Actions:** The primary CI/CD platform for automating formula auditing, testing, and updates.
- **Gemini CLI:** Used within GitHub Actions to autonomously scan upstream repositories and update formula versions and checksums via custom commands (e.g., `update-formula`).
- **Python:** Used for internal automation scripts and custom Gemini CLI commands.

## Target Architecture & OS
- **macOS:**
  - Architecture: `ARM64` (Apple Silicon), `x86_64` (Intel)
- **Linux:**
  - Architecture: `ARM64` (64-bit), `x86_64` (Intel), `ARMv6` (e.g., Raspberry Pi)
