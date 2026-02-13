# Implementation Plan - add-formula

## Phase 1: Command Scaffold & Metadata Fetching [checkpoint: 2dbb55f]
- [x] Task: Create the `.gemini/commands/add-formula.toml` file with basic metadata and prompt.
- [x] Task: Implement GitHub API integration to fetch repository details (description, homepage, license).
- [x] Task: Implement CamelCase class name generation from repository names (e.g., `my-tool` -> `MyTool`).
- [x] Task: Conductor - User Manual Verification 'Phase 1: Command Scaffold & Metadata Fetching' (Protocol in workflow.md)

## Phase 2: Asset Analysis & Checksums
- [ ] Task: Implement logic to fetch the latest release assets and map them to supported platforms/architectures.
- [ ] Task: Implement multi-platform SHA256 calculation by downloading and hashing release assets.
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Asset Analysis & Checksums' (Protocol in workflow.md)

## Phase 3: Formula Generation
- [ ] Task: Create a Jinja-like or f-string template for the Homebrew formula `.rb` file.
- [ ] Task: Implement the logic to populate the template with metadata, versions, and platform-specific `url`/`sha256` blocks.
- [ ] Task: Implement logic to update `Taskfile.yml` with the new audit task and include it in the unified `audit` task.
- [ ] Task: Add error handling for missing releases, private repositories, or API rate limits.
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Formula Generation' (Protocol in workflow.md)

## Phase 4: Integration & Verification
- [ ] Task: Verify the full end-to-end loop: `gemini add-formula <repo_name>`.
- [ ] Task: Ensure the generated formula passes `brew audit` and `brew test`.
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Integration & Polish' (Protocol in workflow.md)
