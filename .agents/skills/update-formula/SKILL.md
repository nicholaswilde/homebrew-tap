---
name: update-formula
description: >
  Update an existing Homebrew formula in this tap to its latest upstream release.
  Scans upstream GitHub releases, compares versions, downloads assets, recalculates
  SHA256 checksums across macOS/Linux architectures (including ARMv6/ARMv7),
  updates Formula/<name>.rb, and runs audit checks.
  Trigger: /update-formula, "update formula", "bump formula", "upgrade formula".
---

# Update Formula Skill

Automate updating an existing Homebrew formula in `Formula/` to its latest upstream release version, updating URLs, recalculating SHA256 checksums across architectures, updating installation path version strings, and verifying with `brew audit`.

## Invocation

```text
/update-formula [formula_name] [dry_run]
```
- `[formula_name]`: Name of formula in `Formula/` (fuzzy match supported by helper script).
- `[dry_run]`: Pass `--dry-run` or `dry_run=true` to preview changes without modifying files.

## Protocol

### Step 1: Formula Discovery
1. Identify target formula file `Formula/<formula_name>.rb`.
2. If `formula_name` is omitted or partial, use `scripts/find_formula.py` to identify the best match:
   ```bash
   uv run python scripts/find_formula.py <query>
   ```
3. Read the formula to determine the current `version` and upstream GitHub repository from `homepage` or `url`.

### Step 2: Upstream Release Check
1. Fetch the latest stable release from the upstream repository.
   - When using `gh`, always pipe to `cat` to prevent interactive pager hang:
     ```bash
     gh release view --repo <owner>/<repo> --json tagName,assets | cat
     ```
2. Compare upstream release tag (stripping leading `v`) against current `version` in formula.
3. If already at latest version, report that formula is up to date and exit early.

### Step 3: Asset Recalculation & Formula Update
1. Automated update via script:
   - For preview / dry-run:
     ```bash
     uv run scripts/update_formula.py <formula_name> --dry-run
     ```
   - For applying update:
     ```bash
     uv run scripts/update_formula.py <formula_name>
     ```
   - For specific version override:
     ```bash
     uv run scripts/update_formula.py <formula_name> --version-override <version>
     ```
2. **ARMv6 vs ARMv7 Architecture Handling**:
   - Verify if separate 32-bit Linux release assets exist for `armv6` (e.g., `arm-unknown-linux-gnueabihf`) and `armv7` (e.g., `armv7-unknown-linux-musleabihf`).
   - If both exist, ensure the 32-bit ARM Linux block retains the conditional check and updates both hashes:
     ```ruby
     if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
       if Utils.safe_popen_read("uname", "-m").include?("armv6")
         url "<url_to_armv6_asset>"
         sha256 "<armv6_sha256>"
       else
         url "<url_to_armv7_asset>"
         sha256 "<armv7_sha256>"
       end
     end
     ```
3. **Installation Path Version Strings**:
   - If the formula's `def install` block contains version-specific strings (e.g., `bin.install "proxmox-mcp-rs-0.3.29-..."`), update those strings to match the new version.
4. Maintain existing indentation, quotation style, and Ruby syntax integrity.
5. Never commit `.env` or files containing secret tokens or credentials.

### Step 4: Verification
1. Run audit check for the updated formula:
   ```bash
   task audit:<formula_name>
   ```
   (or `brew audit --strict nicholaswilde/tap/<formula_name>`).
2. Run script tests if helper scripts were modified:
   ```bash
   uv run python -m unittest discover -s scripts
   ```
3. Summarize version bump (old version -> new version) and updated architectures.
