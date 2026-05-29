# /add-formula <repo_name> [owner]

Add a new Homebrew formula to this tap by fetching details from a GitHub repository.

## Description
This Antigravity skill automates the process of adding a new Homebrew formula to this tap. It fetches the repository metadata and latest release assets from GitHub, downloads and computes checksums for the macOS and Linux assets (across ARM and Intel architectures), generates the Ruby formula file, adds audit tasks to `Taskfile.yml`, and integrates the formula into the `README.md`.

## Protocol

### Step 1: Metadata Discovery
1. Fetch repository details (description, homepage, license) from the GitHub API.
2. Fetch the latest release version and its assets.

### Step 2: Asset Analysis & Checksums
1. Identify assets for macOS (ARM64, x86_64) and Linux (ARM64, x86_64, ARMv6, ARMv7). Specifically check if separate Linux assets exist for both `armv6` and `armv7` architectures (e.g., `arm-unknown-linux-gnueabihf` for armv6 and `armv7-unknown-linux-musleabihf` for armv7).
2. Download these assets and calculate their SHA256 checksums.

### Step 3: Formula Generation
1. Generate a new formula `.rb` file in the `Formula/` directory.
2. The class name should be a CamelCase version of the repository name.
3. Populate the formula with the discovered metadata, version, and platform-specific URLs and checksums.
4. If both `armv6` and `armv7` release assets exist, populate the 32-bit ARM Linux block (`Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?`) to conditionally check `Utils.safe_popen_read("uname", "-m").include?("armv6")` and set the appropriate URL and SHA256 hash for each architecture.

### Step 4: Taskfile Integration
1. Add an individual audit task for the new formula to `Taskfile.yml`.
2. Update the unified `audit` task in `Taskfile.yml` to include the new formula's audit task.

### Step 5: README.md Integration
1. Add the new formula to the `Available Formulas` list in `README.md` in alphabetical order.
2. Ensure the entry includes a short description and emoji if applicable.

### Step 6: Final Report
1. Summarize the created formula and the updates made to `Taskfile.yml` and `README.md`.
