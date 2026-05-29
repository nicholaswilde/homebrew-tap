# /update-formula <formula_name> [dry_run]

Update a Homebrew formula to its latest version.

## Description
This Antigravity skill updates a specific Homebrew formula in this tap to its latest version by extracting the upstream repository URL, querying the GitHub API for the latest release/tag, downloading the updated assets, calculating SHA256 checksums, and updating the formula's `version` and `sha256` values (or showing them in a dry-run mode).

## Protocol

### Step 1: Formula Discovery
1. If `formula_name` is provided, find the matching `.rb` file in the `Formula/` directory.
2. If `formula_name` is missing or ambiguous, search the `Formula/` directory for a "best guess" match based on the provided input.
3. Read the content of the identified formula file.

### Step 2: Upstream Analysis
1. Extract the upstream repository URL (likely from the `homepage` or `url` field) from the `.rb` file.
2. Use the GitHub API (if the URL is a GitHub repo) to find the latest release version or tag.
3. Identify all target assets for all supported platforms and architectures. Specifically check if separate assets exist for both `armv6` and `armv7` architectures (e.g., `arm-unknown-linux-gnueabihf` for armv6 and `armv7-unknown-linux-musleabihf` for armv7).
4. Download the latest artifacts for each supported architecture and calculate their SHA256 checksums.

### Step 3: Update Logic
1. Compare the latest version with the current version in the `.rb` file.
2. If an update is available:
    - If `dry_run` is "true", display the proposed changes (version, URLs, and sha256 hashes).
    - If `dry_run` is "false" or not provided, update the `version` and architecture-specific `url`/`sha256` fields in the `.rb` file.
    - If both `armv6` and `armv7` release assets exist, update the 32-bit ARM Linux block (`Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?`) to conditionally check `Utils.safe_popen_read("uname", "-m").include?("armv6")` and set the appropriate URL and SHA256 hash for each.
3. If no update is available, report that the formula is already up to date.

### Step 4: Final Report
1. Summarize the actions taken or the updates found.
