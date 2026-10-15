# Product Guidelines - homebrew-tap

## Documentation & Prose Style
- **Tone:** Professional, direct, and technical.
- **Style:** Concise descriptions that focus on the tool's core utility. Avoid marketing jargon or overly conversational language.
- **Standard:** Use technical terminology correctly and prioritize accuracy over flow.

## Formula Maintenance & Updates
- **Strategy:** Hybrid approach.
- **Automation:** Prioritize automated update pipelines (e.g., GoReleaser, GitHub Actions) for core tools to ensure consistency and speed.
- **Manual Flexibility:** Allow for manual formula updates when automation is not feasible or for simpler tools that don't change frequently.
- **Verification:** Every update, whether manual or automated, should be verified against Homebrew's standards.

## Organization & Naming
- **Naming Convention:** Formula names MUST align exactly with the name of the upstream repository or the primary executable to minimize user confusion.
- **Structure:** Maintain the standard Homebrew `Formula/` directory structure for all tool definitions.

## Metadata Standards
- **Description:** Every formula must have a concise `desc` that accurately reflects the tool's purpose.
- **Homepage:** A valid `homepage` URL must be provided for every formula.
- **Licensing:** An explicit and valid SPDX license identifier must be included in every formula definition.

## Quality Assurance & Verification
- **Testing Requirement:** Every formula MUST include a `test do` block that performs a basic functional check (e.g., checking the tool's version).
- **Automated Validation:** Leverage CI/CD to run `brew test` and `brew audit` on all formulas to catch errors before they are merged.
