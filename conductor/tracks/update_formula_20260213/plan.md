# Implementation Plan - update-formula

## Phase 1: Command Scaffold & Discovery [checkpoint: 4c14ab1]
- [x] Task: Create the `.gemini/commands/update-formula.toml` file with basic metadata.
- [x] Task: Implement the "best guess" formula discovery logic.
- [x] Task: Implement a command-line interface that accepts a formula name and a `--dry-run` flag.
- [x] Task: Conductor - User Manual Verification 'Phase 1: Command Scaffold & Discovery' (Protocol in workflow.md)

## Phase 2: Upstream Analysis [checkpoint: bebbc69]
- [x] Task: Write tests for extracting GitHub URLs from `.rb` files.
- [x] Task: Implement logic to extract the upstream repository URL from a formula's `.rb` file.
- [x] Task: Write tests for fetching the latest version and checksum from GitHub.
- [x] Task: Implement GitHub API integration to fetch the latest release version and calculate the new SHA256 checksum.
- [x] Task: Conductor - User Manual Verification 'Phase 2: Upstream Analysis' (Protocol in workflow.md)

## Phase 3: File Modification Logic [checkpoint: d10fb32]
- [x] Task: Write tests for the `.rb` file update logic (including dry-run).
- [x] Task: Implement the logic to replace the `version` and `sha256` fields in the `.rb` file.
- [x] Task: Implement the `--dry-run` behavior to print the diff instead of writing to disk.
- [x] Task: Add error handling for network issues and invalid formulas.
- [x] Task: Conductor - User Manual Verification 'Phase 3: File Modification Logic' (Protocol in workflow.md)

## Phase 4: Integration & Polish [checkpoint: c0f25cb]
- [x] Task: Verify the full end-to-end loop: `gemini update-formula <partial_name>`.
- [x] Task: Ensure all tests pass and coverage meets the >80% requirement.
- [x] Task: Conductor - User Manual Verification 'Phase 4: Integration & Polish' (Protocol in workflow.md)
