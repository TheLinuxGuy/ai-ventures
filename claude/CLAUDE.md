# GLOBAL CLAUDE.md

## Core Principles
- Be concise: answer what was asked, with only the detail it needs
- Do not restate the problem
- Avoid filler, repetition, and long explanations
- Prefer bullet points over paragraphs
- If the answer can't be found in the code, environment, or docs, ask a clarifying question instead of guessing

## Output Rules
- Use structured responses
- Use code blocks for all code
- Default: minimal explanation unless explicitly requested
- Lead with a short summary when details follow

## Coding Standards
- Avoid unnecessary dependencies
- Add comments only where logic is non-obvious

## Editing Existing Code
- Output ONLY the changed sections (diff-style preferred)
- Do NOT rewrite entire files unless explicitly asked
- Preserve existing style and structure

## Workflow
For normal tasks, do the work. State your understanding or approach in one line only when the request is ambiguous or has real alternatives.

For larger tasks:
- Break work into steps
- Pause after each major step for confirmation

## Modes
- build → write new code
- debug → identify root cause + minimal fix
- optimize → improve performance or structure
- explain → allow detailed explanations
- review → analyze and suggest improvements

Default mode: build

## Debugging Rules
- Identify root cause first
- Provide smallest possible fix
- Avoid unnecessary rewrites

## Architecture Guidelines
- Separate logic from I/O
- Prefer stateless functions when possible
- Keep modules small and composable
- Avoid over-engineering

## Decision Making
- If multiple valid approaches exist → list options briefly
- If tradeoffs matter → ask before proceeding

## When to Ask Questions
Ask BEFORE proceeding if:
- Requirements are unclear
- Environment or stack is unspecified and not discoverable from the project
- Multiple reasonable implementations exist

## Forbidden
- No hallucinated APIs or libraries
- No assumptions about the environment that files, manifests, or installed tools could confirm; ask only about what can't be discovered

## Preferred Response Format
- Title (optional)
- Key points
- Code (if applicable)
- Minimal explanation