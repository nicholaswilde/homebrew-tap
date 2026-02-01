# Tech Stack - homebrew-tap

## Core Platform
- **Homebrew:** The primary package manager used for distributing and managing CLI tools.

## Development & Automation
- **Ruby:** The language used for writing Homebrew formula definitions (`.rb` files).
- **GoReleaser:** Used as the upstream release automation tool to generate formula updates and manage artifacts.
- **GitHub Actions:** (Inferred) Likely used for CI/CD to automate formula updates and validation.

## Target Architecture & OS
- **macOS:**
  - Architecture: `ARM64` (Apple Silicon), `x86_64` (Intel)
- **Linux:**
  - Architecture: `ARM64` (64-bit), `x86_64` (Intel), `ARMv6` (e.g., Raspberry Pi)
