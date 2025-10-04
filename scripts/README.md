# AI Script Recipes

This folder stores “recipes” (prompts) used to generate small utility scripts for the homelab. Each recipe lives in its own Markdown file alongside minimal metadata so results can be reproduced later.

## Why this exists
- AI output varies by model, version, and settings.
- Keeping the original prompt, model info, and constraints improves repeatability and review.
- Scripts can be regenerated or revised from the same source recipe.

## Folder usage
- One Markdown file per script recipe.
- Keep generated code next to the recipe (e.g., same folder) or in a `/generated` subfolder.
- Commit both the recipe and the resulting script with a short note on what changed.

## Naming convention
- Use: `short-topic.md` (kebab-case; concise and descriptive)
	- Example: `zfs-health-check.md`

## Suggested workflow
1. Create a new recipe using the template below.
2. Run the prompt with the noted model/settings.
3. Save the generated script as `<name>.sh`/`.py` and add a brief test note.
4. If you iterate, add a new entry to the Changelog/History section instead of overwriting past prompts.

## Reproducibility notes
- Record model, version, temperature, and any tools/dependencies.
- Expect differences across models and time; re-validate before production use.

## Safety
- Review code before running (permissions, paths, destructive actions).
- Prefer dry-run modes and backups where possible.

## Template (copy into a new file)
```markdown
# <Script Title>

- Goal: <single-sentence purpose>
- Date: <YYYY-MM-DD>
- Model: <e.g., gpt-4o mini>  | Version: <if known>
- Env/OS: macOS
- Inputs/Context: <links, constraints, existing files>

## Prompt
<prompt>
<Full prompt you used with the model>
</prompt>

## Acceptance Criteria
- [ ] <criterion 1>
- [ ] <criterion 2>

## Expected Artifacts
- <script path and name>
- <config files, if any>

## Changelog / History
- <YYYY-MM-DD> — v<version or increment> — <short summary of change>
	- Model: <name> | Version: <if known> | Temperature: <if used>
	- Changes: <what changed in the prompt/context>
	- Impact/Notes: <behavior differences, validation notes, risks>
```