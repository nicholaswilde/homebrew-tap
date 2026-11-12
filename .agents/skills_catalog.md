# Agent Skills Catalog

Catalog of custom Antigravity agent skills available in `homebrew-tap`.

| Skill | Description | Task / Command |
|---|---|---|
| [`add-formula`](skills/add-formula/SKILL.md) | Add a new Homebrew formula to this tap from an upstream GitHub repository. Fetches repository metadata and latest release assets, calculates SHA256 checksums across macOS and Linux architectures, generates Formula/<name>.rb, adds audit tasks to Taskfile.yml, and updates README.md. | `/add-formula` / `uv run scripts/add_formula.py` |
| [`enable-tap-trigger`](skills/enable-tap-trigger/SKILL.md) | Update an upstream repository to trigger the Homebrew Tap formula update workflow upon release. Searches local workspace, verifies token secret, and adds update-homebrew-tap job to release.yml. | `/enable-tap-trigger` / `/add-tap-trigger` |
| [`update-formula`](skills/update-formula/SKILL.md) | Update an existing Homebrew formula in this tap to its latest upstream release. Scans upstream GitHub releases, compares versions, downloads assets, recalculates SHA256 checksums across macOS/Linux architectures, updates Formula/<name>.rb, and runs audit checks. | `/update-formula` / `uv run scripts/update_formula.py` |
