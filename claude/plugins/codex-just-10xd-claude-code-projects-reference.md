# Codex Plugin Video Reference 2

Source video: https://www.youtube.com/watch?v=B2Kh_ZoLVTM

## Purpose

Practical chapter-by-chapter reference for Nate Herk's Codex plugin workflow analysis, including benchmark framing and implementation patterns.

## Video metadata

- Title: Codex Just 10x’d Claude Code Projects
- Creator: Nate Herk | AI Automation
- Duration: 13:11
- Published: 2026-03-31

## Global prerequisites

- Claude Code baseline workflow already in place
- Codex plugin installed and authenticated
- Ability to run branch and working-tree review loops
- Basic understanding of model-cost tradeoffs

## Official docs

- Plugin repository: https://github.com/openai/codex-plugin-cc
- Codex documentation: https://developers.openai.com/codex
- Codex app server integration details: https://developers.openai.com/codex/app-server

## Overlap with existing notes

| Topic | This file | Existing coverage |
|---|---|---|
| Setup commands | How installation fits into workflow | [codex-chatgpt.md](codex-chatgpt.md) full command list |
| Review vs adversarial review | Demo-driven comparison and outcomes | [codex-chatgpt.md](codex-chatgpt.md) command semantics |
| Multi-model strategy | Tactical "use both" guidance | [../claude-code-advanced-course-reference.md](../claude-code-advanced-course-reference.md) strategic orchestration |

Use this file when deciding how to combine Codex and Claude in production workflows.

## Chapter-by-chapter reference

### 0:00 What Is the Codex Plugin

- Concept:
  - Official plugin simplifies Codex + Claude collaboration inside a single session flow.
- Prerequisites:
  - Active Claude Code setup with plugin capability.
- When to use:
  - When you want built-in review/delegation without switching tools manually.
- Example:
  - Keep implementation in Claude and route validation passes to Codex commands.

### 1:09 Opus 4.6 vs GPT 5.4 Benchmarks

- Concept:
  - Benchmark snapshots suggest strengths vary across test suites; no single model dominates all tasks.
- Prerequisites:
  - Comfort interpreting benchmark data as directional, not absolute.
- When to use:
  - During model-routing and budget decisions.
- Example:
  - Use benchmark context to choose which reviewer model runs first for a given task type.

### 2:09 Strengths & Weaknesses of Each

- Concept:
  - Model behavior differs by domain (reasoning style, review sharpness, UI/code tendencies).
- Prerequisites:
  - A feedback loop that records where each model helped or failed.
- When to use:
  - Team-level standards for model selection.
- Example:
  - Assign one model for feature implementation and the other for adversarial safety checks.

### 3:18 Using Both Tools Together

- Concept:
  - Composite workflow (build in one model, review in another) outperforms single-model reliance.
- Prerequisites:
  - Consistent handoff format for issues and fixes.
- When to use:
  - Medium/large changes with multiple files.
- Example:
  - Ask Codex for prioritized findings, then ask Opus to implement only high/critical items first.

### 3:37 How to Set It Up

- Concept:
  - Setup is straightforward: marketplace add, plugin install, setup check.
- Prerequisites:
  - Plugin permissions and auth flow readiness.
- When to use:
  - New environment bootstrap or first project enablement.
- Example:
  - Install at user scope once, then enable project-by-project as needed.

### 4:35 Live Adversarial Review Demo

- Concept:
  - Adversarial review behaves like a pressure-test pass and returns structured priorities.
- Prerequisites:
  - A target code state with non-trivial architecture decisions.
- When to use:
  - Pre-merge checks where design assumptions need challenge.
- Example:
  - Run adversarial review in background for large diffs, then consume result with status/result commands.

### 6:56 Head-to-Head Game Build

- Concept:
  - Side-by-side outputs reveal practical differences in speed, correctness, and UX quality.
- Prerequisites:
  - Same prompt baseline and comparable scope.
- When to use:
  - Evaluating model fit for your specific product type.
- Example:
  - Compare generated implementations and keep a rubric (bugs, UX quality, maintainability).

### 9:53 Why Not Just Use Codex?

- Concept:
  - The best operational answer is usually not single-tool exclusivity.
- Prerequisites:
  - Willingness to use model-specific strengths rather than one universal default.
- When to use:
  - Stack policy decisions and cost optimization.
- Example:
  - Continue using Claude for broader repo orchestration while using Codex for targeted audits.

### 10:39 Feeding Codex Review Back to Opus

- Concept:
  - Closed-loop improvement: findings from Codex become implementation tickets for Claude.
- Prerequisites:
  - A triage process for severity and business impact.
- When to use:
  - Continuous improvement cycles after review passes.
- Example:
  - Ask Opus to implement Codex high-priority findings, then re-run Codex review to verify closure.

### 12:48 Final Thoughts

- Concept:
  - Plugin value is workflow leverage and second-opinion reliability.
- Prerequisites:
  - Discipline in review loops and result triage.
- When to use:
  - Retrospectives and process upgrades.
- Example:
  - Add Codex review as a standard pre-PR check for complex changes.

## Practical implementation checklist

- [ ] Install and verify plugin in one active project
- [ ] Define a two-pass workflow: implementation then independent review
- [ ] Standardize severity triage and handoff format
- [ ] Track model-specific wins/failures in project notes
- [ ] Re-run adversarial review before final merge on high-risk changes

## Companion files

- Canonical plugin reference: [codex-chatgpt.md](codex-chatgpt.md)
- Video reference 1: [codex-plugin-claude-code-ai-god-reference.md](codex-plugin-claude-code-ai-god-reference.md)
- Claude overview docs: [../README.md](../README.md)

## Notes and caveats

- This reference captures actionable patterns from a walkthrough and benchmark discussion.
- Benchmarks are useful directional signals, not guarantees for your codebase.
- Keep official plugin docs as source of truth for command behavior.