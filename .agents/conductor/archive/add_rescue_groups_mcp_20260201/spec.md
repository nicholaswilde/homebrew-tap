# Specification - Add rescue-groups-mcp formula

## Overview
Add a new Homebrew formula for `rescue-groups-mcp`, an MCP server to interface with Rescue Groups written in Rust.

## Requirements
- Create `Formula/rescue-groups-mcp.rb`.
- Support macOS (ARM and Intel) and Linux (ARM and Intel).
- Include a `test do` block to verify installation.
- Adhere to the project's product guidelines.

## Success Criteria
- Formula is created with correct metadata and SHAs.
- `brew audit` passes for the new formula.
- `brew test` passes for the new formula.
