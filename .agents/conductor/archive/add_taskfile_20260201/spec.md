# Specification - Add Taskfile.yml for project automation

## Overview
Implement a `Taskfile.yml` to automate common project tasks such as auditing and testing Homebrew formulas.

## Requirements
- Define tasks for `brew audit` on all formulas.
- Define tasks for `brew test` on all formulas.
- Provide a `default` task that lists available tasks or runs a full check.

## Success Criteria
- `Taskfile.yml` is created and functional.
- `task audit` successfully runs audit on all formulas.
- `task test` successfully runs tests on all formulas.
