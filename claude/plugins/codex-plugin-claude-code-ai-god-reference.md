# Codex Plugin Video Reference 1

Source video: https://www.youtube.com/watch?v=L7NPhaUBpZE

## Purpose

Practical chapter-by-chapter reference for Chase AI's first-look walkthrough of the OpenAI Codex plugin inside Claude Code.

## Video metadata

- Title: Claude Code + Codex = AI GOD
- Creator: Chase AI
- Duration: 9:43
- Published: 2026-03-31

## Global prerequisites

- Claude Code installed and working
- Plugin support enabled in your Claude environment
- ChatGPT/Codex access for authentication
- A project where you can run review or rescue workflows

## Official docs

- Plugin repo and install guide: https://github.com/openai/codex-plugin-cc
- Codex docs hub: https://developers.openai.com/codex
- Codex pricing/usage context: https://developers.openai.com/codex/pricing

## Overlap with existing notes

| Topic | This file | Existing coverage |
|---|---|---|
| Plugin install sequence | Video walkthrough with practical setup flow | [codex-chatgpt.md](codex-chatgpt.md) canonical command reference |
| Adversarial review behavior | Detailed demo observations and findings format | [codex-chatgpt.md](codex-chatgpt.md) command purpose and flags |
| Opus + Codex pairing | Tactical model-combination examples | [../claude-code-advanced-course-reference.md](../claude-code-advanced-course-reference.md) strategic multi-agent patterns |

Use this file for implementation-oriented interpretation of the first video demo.

## Chapter-by-chapter reference

### 0:00 Intro

- Concept:
  - Codex is positioned as a practical complement to Claude Opus workflows, not a strict replacement.
- Prerequisites:
  - Familiarity with Claude Code and model-switching tradeoffs.
- When to use:
  - When you want a second coding model integrated into existing Claude workflows.
- Example:
  - Build a feature in Claude, then run a separate Codex review pass before merge.

### 0:46 Install & Features

- Concept:
  - Quick plugin setup plus core features: review, adversarial review, rescue, and job status flows.
- Prerequisites:
  - Plugin marketplace access, ChatGPT/Codex login path.
- When to use:
  - Initial enablement in your user scope or project scope.
- Example:
  - Install plugin, reload plugins, run setup, authenticate Codex, then test with a background review.

### 3:27 Adversarial Review

- Concept:
  - Adversarial review targets hidden risks and design weaknesses, not only syntax/logic defects.
- Prerequisites:
  - Working codebase with meaningful architecture decisions to pressure-test.
- When to use:
  - Before shipping or when a subsystem has reliability/security risk.
- Example:
  - Run adversarial review on a multi-file service that includes auth, retries, and queue behavior.

### 6:52 Opus vs Codex

- Concept:
  - Different reviewers identify different issues; combining outputs improves coverage.
- Prerequisites:
  - Ability to compare and triage two independent review reports.
- When to use:
  - High-stakes changes where missed edge cases are expensive.
- Example:
  - Request Codex adversarial findings, then ask Opus to critique those findings and add missing risks.

### 9:11 Final Thoughts

- Concept:
  - The practical win is workflow composition and cost-aware routing.
- Prerequisites:
  - Baseline understanding of usage limits and task cost.
- When to use:
  - During process tuning for day-to-day coding productivity.
- Example:
  - Use Opus for planning/context-heavy coding and Codex for independent verification passes.

## Practical implementation checklist

- [ ] Install and verify Codex plugin with `/codex:setup`
- [ ] Run one normal review and one adversarial review on a real branch
- [ ] Compare severity findings between Claude and Codex reviewers
- [ ] Adopt a repeatable "build then pressure-test" pre-merge loop
- [ ] Track where each model is strongest in your stack

## Companion files

- Canonical plugin command guide: [codex-chatgpt.md](codex-chatgpt.md)
- Video reference 2: [codex-just-10xd-claude-code-projects-reference.md](codex-just-10xd-claude-code-projects-reference.md)
- Claude setup and navigation: [../README.md](../README.md)

## Notes and caveats

- This is a paraphrased operational reference, not a transcript copy.
- Observed quality/performance tradeoffs depend on task type and repo structure.
- Validate plugin flags against official docs after each plugin release.