# Specification - Track: update-formula

## Overview
This track involves creating a new Gemini CLI command, `update-formula`, to automate the process of updating Homebrew formulas in this tap. The command will live in `.gemini/commands/update-formula.toml`.

## Functional Requirements
- **Command Invocation:** `gemini update-formula [formula_name]`
- **Parameter Handling:** 
    - `formula_name`: The name of the formula to update. If missing or ambiguous, the agent should use "best guess" logic based on available formulas in the `Formula/` directory.
- **Upstream Detection:**
    - Extract the upstream repository URL (likely from the `homepage` or `url` field) directly from the formula's `.rb` file.
    - Use the GitHub API to identify the latest release/tag version and download the corresponding artifact to calculate the SHA256 checksum.
- **Update Logic:**
    - Update the `version` and `sha256` fields in the corresponding `.rb` file in the `Formula/` directory.
    - If the formula is already at the latest version, the command should report this and exit gracefully.
- **Dry Run Support:**
    - Include a `--dry-run` flag to preview the changes (version/checksum) without modifying the `.rb` file.

## Non-Functional Requirements
- **Resilience:** Provide clear error messages for network failures, invalid GitHub URLs, or missing formulas.
- **Accuracy:** The "best guess" logic should be robust enough to handle partial or slightly misspelled formula names.

## Acceptance Criteria
- [ ] The command successfully updates a formula's version and checksum when a valid formula name is provided.
- [ ] The command gracefully handles cases where no update is available.
- [ ] The `--dry-run` flag correctly previews changes without writing to the `.rb` file.
- [ ] The command provides clear error messages for invalid names or network failures.
- [ ] The "best guess" logic correctly identifies the target formula for partial names.

## Out of Scope
- Automatic committing of changes (this will be handled by the developer or other workflows).
- Support for non-GitHub upstream repositories.
