# Prompt Archive

This folder stores copies of prompts used to generate scripts, tools, and automation workflows. The goal is to preserve a working record of past requests so they can be reused, compared, and benchmarked against future models.

## Purpose

- Keep a copy of prompts that have already produced useful outputs.
- Reproduce previous work without needing to rediscover the original instructions.
- Compare models over time to see which ones produce better code quality and better completion rates.
- Measure whether a model can satisfy all goals in a single pass, without multiple rounds of correction.

## What belongs here

- Prompt text used for agent-driven builds
- Brief notes on the intended output
- The model and version used
- Any constraints, requirements, or acceptance criteria
- Related scripts or generated artifacts when useful

## Intended workflow

1. Save the original prompt used to create a script or tool.
2. Add notes on success criteria, environment, and constraints.
3. Keep the generated artifact alongside the prompt when relevant.
4. Re-run later with newer models to compare quality, reliability, and speed.

## Benchmarking idea

Each prompt can be treated as a reproducible test case. Over time, you can compare:

- Did the model meet all requirements in one attempt?
- How much iteration was needed?
- Did the output match the requested quality and structure?
- Was the result correct, usable, and safe to run?

This gives you a lightweight benchmark for measuring model improvement and output consistency.

## Suggested file naming

Use clear, descriptive names such as:

- `build-website-scraper.md`
- `generate-macos-automation.md`
- `create-reporting-script.md`

## Notes

- Keep prompts honest and complete; they should reflect the actual instructions used.
- Do not overwrite prior versions unless you are intentionally replacing a failed attempt.
- Prefer preserving original context so future testing remains comparable.

## Example structure

```text
scripts/
  create-reporting-script.md
  create-reporting-script.sh
  build-website-scraper.md
  build-website-scraper.py
```

Use this folder as a prompt library and benchmarking archive for future agent performance comparisons.