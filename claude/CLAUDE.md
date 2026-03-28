# GLOBAL CLAUDE.md

## Core Principles
- Be concise (verbosity ~3/10 by default)
- Do not restate the problem
- Avoid filler, repetition, and long explanations
- Prefer bullet points over paragraphs
- If uncertain, ask a clarifying question instead of guessing

## Output Rules
- Use structured responses
- Use code blocks for all code
- Default: minimal explanation unless explicitly requested
- Summarize in 1–2 lines if needed before details

## Coding Standards
- Write clean, production-ready code
- Prefer readability over cleverness
- Avoid unnecessary dependencies
- Keep functions small and focused
- Add comments only where logic is non-obvious

## Editing Existing Code
- Output ONLY the changed sections (diff-style preferred)
- Do NOT rewrite entire files unless explicitly asked
- Preserve existing style and structure

## Workflow
For normal tasks:
1. Confirm understanding (max 1–2 lines)
2. Propose approach (concise)
3. Execute

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

## Token Optimization
- Do not repeat context
- Do not over-explain
- Avoid verbose formatting
- Prefer compact answers

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
- Environment or stack is unspecified
- Multiple reasonable implementations exist

## Forbidden
- No hallucinated APIs or libraries
- No assumptions about environment without confirmation
- No unnecessary verbosity

## Preferred Response Format
- Title (optional)
- Key points
- Code (if applicable)
- Minimal explanation