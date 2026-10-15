# Specification - Add adguardhome-mcp-rs formula

## Overview
Add a new Homebrew formula for `adguardhome-mcp-rs`, a Rust implementation of an AdGuard Home MCP server.

## Requirements
- Create `Formula/adguardhome-mcp-rs.rb`.
- Support macOS (ARM and Intel) and Linux (ARM and Intel).
- Include a `test do` block to verify installation.
- Adhere to the project's product guidelines (standardized metadata, explicit licensing).

## Success Criteria
- Formula is created with correct metadata and SHAs.
- `brew audit` passes for the new formula.
- `brew test` passes for the new formula.
