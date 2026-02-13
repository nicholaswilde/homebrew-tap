# Specification - Track: add-formula

## Overview
This track involves creating a new Gemini CLI command, `add-formula`, to automate the creation of new Homebrew formulas in this tap. The command will live in `.gemini/commands/add-formula.toml` and will use the GitHub API to fetch repository metadata, calculate initial checksums for all supported platforms, and automatically update the `Taskfile.yml`.

## Functional Requirements
- **Command Invocation:** `gemini add-formula <repo_name> [owner]`
- **Parameter Handling:**
    - `repo_name`: The name of the GitHub repository (required).
    - `owner`: The GitHub owner. Defaults to `nicholaswilde` if not provided.
- **Metadata Discovery:**
    - Use the GitHub API to fetch the repository's description, homepage, and license.
    - Fetch the latest release version and list all assets.
- **Formula Generation:**
    - Create a new `<repo_name>.rb` file in the `Formula/` directory.
    - Generate a standard Homebrew formula class (CamelCased name).
    - Populate the `desc`, `homepage`, `version`, and `license` fields.
    - Generate `on_macos` and `on_linux` blocks with correct architecture checks (`ARM64`, `x86_64`, and `ARMv6` for Linux).
    - Download release assets for each platform, calculate SHA256 checksums, and populate the corresponding `url` and `sha256` fields.
- **Taskfile Integration:**
    - Automatically add a new `audit:<formula_name>` task to `Taskfile.yml`.
    - Automatically append the new task to the `cmds` list of the unified `audit` task in `Taskfile.yml`.
- **Resilience:**
    - Handle cases where the repository or release does not exist.
    - Gracefully handle missing metadata (e.g., if a repo has no description or license).

## Acceptance Criteria
- [ ] The command correctly identifies the target GitHub repository (using defaults if owner is missing).
- [ ] A valid `.rb` formula file is created in the `Formula/` directory with correct class name, description, homepage, and license.
- [ ] The formula includes functional `url` and `sha256` blocks for all supported platforms (macOS/Linux, ARM/Intel).
- [ ] The command gracefully handles repositories with no releases or inaccessible APIs.
- [ ] The newly created formula passes `brew audit` without major errors.

## Out of Scope
- Support for non-GitHub repositories.
- Custom installation logic beyond simple binary installation (standard `bin.install`).
