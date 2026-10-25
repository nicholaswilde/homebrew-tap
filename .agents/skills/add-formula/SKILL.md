---
name: add-formula
description: >
  Add a new Homebrew formula to this tap from an upstream GitHub repository.
  Fetches repository metadata and latest release assets, calculates SHA256 checksums
  across macOS and Linux architectures (including ARMv6/ARMv7 distinction), generates
  Formula/<name>.rb, adds audit tasks to Taskfile.yml, and updates README.md.
  Trigger: /add-formula, "add formula", "create formula", "new formula", "add homebrew formula".
---

# Add Formula Skill

Automate the addition of a new Homebrew formula to this tap by querying the upstream GitHub repository, downloading multi-platform release assets, computing SHA256 checksums, generating the Ruby formula file, and integrating it with `Taskfile.yml` and `README.md`.

## Invocation

```text
/add-formula <repo_name> [owner] [--dry-run]
```
- `<repo_name>`: Upstream GitHub repository name (or formula name).
- `[owner]`: GitHub organization or username (defaults to `nicholaswilde`).
- `[--dry-run]`: Preview generated formula and modifications without writing changes.

## Protocol

### Step 1: Upstream Discovery & Metadata
1. Resolve repository coordinates:
   - Default owner: `nicholaswilde` unless explicitly provided.
   - Target repo: `<owner>/<repo_name>`.
2. Discover repository details and latest release:
   - Query repository metadata (description, homepage, license) and latest release assets.
   - When using `gh`, always pipe to `cat` to prevent interactive pager hang:
     ```bash
     gh release view --repo <owner>/<repo_name> --json tagName,assets | cat
     ```
   - Alternatively, preview via `uv run scripts/add_formula.py <repo_name> [owner] --dry-run`.
   - Never commit `.env` or files containing secret tokens or credentials.

### Step 2: Multi-Platform Asset Mapping & Checksums
1. Locate release assets for all supported platforms and architectures:
   - **macOS ARM64**: `*Darwin_arm64*`, `*aarch64-apple-darwin*.tar.gz`
   - **macOS Intel (x86_64)**: `*Darwin_x86_64*`, `*x86_64-apple-darwin*.tar.gz`
   - **Linux ARM64**: `*Linux_arm64*`, `*aarch64-unknown-linux-musl*.tar.gz`
   - **Linux Intel (x86_64)**: `*Linux_x86_64*`, `*x86_64-unknown-linux-musl*.tar.gz`
   - **Linux 32-bit ARM (ARMv6 / ARMv7)**: Check if separate assets exist for both `armv6` (e.g., `*arm-unknown-linux-gnueabihf*.tar.gz`) and `armv7` (e.g., `*armv7-unknown-linux-musleabihf*.tar.gz`).
2. Download all platform artifacts and compute exact SHA256 checksums (`sha256sum`). Do not guess or reuse old hashes.

### Step 3: Formula Generation
1. Formula class name: UpperCamelCase representation of formula name (e.g., `recipes-mcp-rs` -> `RecipesMcpRs`).
2. Target file: `Formula/<formula_name>.rb`.
3. Script execution:
   ```bash
   uv run scripts/add_formula.py <formula_name> [owner]
   ```
4. **Conditional ARMv6 vs ARMv7 Architecture Handling**:
   If both `armv6` and `armv7` release assets exist, update the 32-bit ARM Linux block (`Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?`) to conditionally check:
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
5. Ensure installation method matches the binary structure (e.g., `bin.install Dir["**/<binary_name>"].first`).

### Step 4: Taskfile.yml Integration
1. Add an individual audit task to `Taskfile.yml`:
   ```yaml
     audit:<formula_name>:
       desc: Audit <formula_name> formula
       cmds:
         - brew audit nicholaswilde/tap/<formula_name>
   ```
2. Append `- task: audit:<formula_name>` to the unified `audit` task in `Taskfile.yml`.
   *(Note: `scripts/add_formula.py` automates this step if executed directly).*

### Step 5: README.md Integration
1. Add the new formula to the `📦 Available Formulas` list in `README.md` in alphabetical order.
2. Include short description and matching emoji:
   ```markdown
   - `<formula_name>`: <description>
   ```

### Step 6: Verification
1. Verify Ruby syntax and formula formatting.
2. Run audit task if local Homebrew is available:
   ```bash
   task audit:<formula_name>
   ```
3. Run python test suite if scripts were updated:
   ```bash
   uv run python -m unittest discover -s scripts
   ```
4. Output concise summary with formula path, version, and platform coverage.
