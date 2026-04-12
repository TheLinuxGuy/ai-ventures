# Claude Code Context Audit Reference

Source video: https://www.youtube.com/watch?v=9ToOfgZ4qqQ

## Purpose

Convert this 11-minute workflow video into a practical, chapter-complete playbook for reducing Claude Code usage burn by shrinking invisible starting context and enforcing day-to-day hygiene habits.

This guide focuses on:
- Auditing hidden context overhead before writing code
- Applying high-leverage fixes in MCP usage, `CLAUDE.md`, skills, and settings
- Turning one-time cleanup into a recurring maintenance routine

## Video metadata

- Title: I Stopped Hitting Claude Code Usage Limits (Here's How)
- Creator: Brad | AI & Automation
- Duration: 11:00
- Published: 2026-04-10
- Chapters detected: 10

## Global prerequisites

- Active Claude Code workflow (CLI/editor integration)
- Ability to run slash commands such as `/context`, `/mcp`, and `/clear`
- Write access to repository `CLAUDE.md`, skills folder, and `settings.json`
- Basic familiarity with model choice (Haiku/Sonnet/Opus)

## Official docs

- Claude Code overview: https://docs.anthropic.com/en/docs/claude-code
- Common workflows: https://docs.anthropic.com/en/docs/claude-code/common-workflows
- Slash commands: https://docs.anthropic.com/en/docs/claude-code/slash-commands
- Settings: https://docs.anthropic.com/en/docs/claude-code/settings
- Hooks: https://docs.anthropic.com/en/docs/claude-code/hooks
- Models: https://docs.anthropic.com/en/docs/about-claude/models
- MCP overview: https://docs.anthropic.com/en/docs/mcp

## Overlap with existing notes

Primary overlap targets:
- `claude/claude-code-token-hacks-reference.md`
- `claude/claude-code-limits-optimization-reference.md`
- `claude/README.md`

How this reference differs:

| Topic | This file (audit-first workflow) | Existing notes |
|---|---|---|
| Starting context audit | Prioritizes a baseline `/context` reading before any optimization | Existing references discuss context cost but are less audit-sequence driven |
| MCP-to-CLI replacement | Frames replacement as architectural default when CLI parity exists | Existing references mention reducing MCPs, but not as strongly as a migration pattern |
| `CLAUDE.md` pruning rubric | Adds explicit five-question filter + progressive disclosure pattern | Existing notes recommend lean instructions, but not this specific rubric |
| Skill bloat management | Emphasizes skill metadata/token overhead and short-skill preference | Existing notes cover skill discipline broadly |
| Settings tuning | Highlights early compaction, output limits, and deny rules in one pass | Existing notes cover settings impact with less chapter-coupled sequencing |

Recommended combined usage:
1. Use this file first when context overhead is unclear and you need a measurable baseline-to-fix workflow.
2. Use `claude/claude-code-token-hacks-reference.md` for wider day-to-day token habits and pacing strategies.
3. Use `claude/claude-code-limits-optimization-reference.md` when troubleshooting limit windows and session architecture decisions.

## Chapter-by-chapter reference

### 0:00 Intro

- Concept:
  - Limits are often a context hygiene issue, not only a plan/tier issue.
  - Hidden context overhead can silently consume budget before meaningful work begins.
- Prerequisites:
  - A recent example where sessions hit limits earlier than expected.
- When to use:
  - At the start of a usage-optimization reset so you target root causes.
- Example:
  - Before changing plan tier, run one audit cycle on your current setup and compare baseline context before/after cleanup.

### 1:19 Audit your starting context

- Concept:
  - Conversation replay cost compounds with each turn, and preloaded context (instructions, skills, MCP tools) raises the floor for every message.
  - `/context` in a fresh session gives the most actionable baseline.
- Prerequisites:
  - Ability to open a fresh session and inspect context metrics.
- When to use:
  - Before making config changes, and again after each major cleanup step.
- Example:
  - Capture baseline tokens from `/context`, apply one change (for example disabling unused MCPs), then re-run `/context` to validate savings.

### 2:03 MCP servers

- Concept:
  - Connected MCP servers inject tool definitions into context continuously, not only when a tool is called.
  - Unused servers become persistent token overhead.
- Prerequisites:
  - `claude mcp list` or `/mcp` familiarity and confidence disconnecting unused servers per session.
- When to use:
  - At session start and whenever task scope changes.
- Example:
  - Keep only browser automation MCP connected while testing UI; disconnect data/cloud MCPs until needed.

### 2:29 Replacing MCPs with CLIs

- Concept:
  - CLI workflows usually incur token cost only when invoked, while MCP definitions add standing overhead.
  - For mature tools with strong CLI support, CLI-first often improves token efficiency.
- Prerequisites:
  - Equivalent CLI command path available for the MCP-backed workflow.
- When to use:
  - When an MCP is mostly a convenience wrapper around commands you can safely run directly.
- Example:
  - Replace a browsing or deployment MCP path with explicit terminal commands in tasks so idle turns carry less context load.

### 3:12 Optimising your CLAUDE.md

- Concept:
  - `CLAUDE.md` is paid for every session turn, so instruction quality and brevity matter.
  - Use a pruning rubric:
    - Remove contradictions.
    - Remove instructions Claude already handles well by default.
    - Remove duplicates and stale one-off band-aids.
    - Remove vague guidance that cannot be evaluated consistently.
  - Use progressive disclosure: keep core rules in `CLAUDE.md`, point to focused reference docs for details.
- Prerequisites:
  - Ability to edit project instructions and split guidance into companion docs.
- When to use:
  - During instruction-file growth or inconsistent output behavior.
- Example:
  - Keep 1-2 lines in `CLAUDE.md` for API conventions and move full convention details to a dedicated standards doc loaded only when needed.

### 5:17 Cutting skill bloat

- Concept:
  - Installed skill metadata contributes to starting context; verbose skills can cost far more than their value.
  - Concise, high-signal skills outperform long instruction dumps in real sessions.
- Prerequisites:
  - Ability to review installed skills and remove low-value entries.
- When to use:
  - When many downloaded/community skills are present or skill auto-invocations feel noisy.
- Example:
  - Trim marketplace skills that are broad and repetitive; keep only domain-specific, frequently used skills with tight instructions.

### 6:02 Settings.json tweaks that matter

- Concept:
  - Several configuration defaults can increase avoidable rework and context waste if left un-tuned.
  - High-impact settings category in this chapter:
    - Trigger compaction earlier to avoid quality drop near high context saturation.
    - Increase shell output allowance to reduce retry loops caused by truncation.
    - Add deny rules for irrelevant directories/artifacts so the assistant avoids noisy files.
- Prerequisites:
  - Access to user/project settings and ability to test changes safely.
- When to use:
  - After session and instruction cleanup, or if command/output loops are still expensive.
- Example:
  - Exclude build artifacts and dependency folders from assistant file access when they are irrelevant to current tasks.

### 7:27 Installing the Context Audit skill

- Concept:
  - A repeatable audit skill can standardize checks and produce a concrete fix list instead of ad-hoc optimization.
  - Installation source trust matters for third-party skills.
- Prerequisites:
  - A vetted source for the skill and a review process before installation.
- When to use:
  - When you want recurring, low-friction health checks rather than one-off cleanup.
- Example:
  - Run the audit skill, review findings, then ask Claude to apply only the approved subset of changes.

### 8:40 Daily habits that save tokens

- Concept:
  - Ongoing habits preserve savings:
    - Use fresh sessions between unrelated tasks (`/clear`).
    - Use plan-first flow for non-trivial work to avoid wrong-path rewrites.
    - Prefer replacing wrong outputs instead of stacking long correction chains.
    - Choose model depth by task complexity.
  - Setup drift is continuous, so audits should recur.
- Prerequisites:
  - Willingness to enforce session boundaries and planning discipline.
- When to use:
  - Every coding day, especially during multi-task workflows.
- Example:
  - Finish research task, run `/clear`, run a short plan prompt for implementation, then execute only after alignment.

### 10:24 Outro

- Concept:
  - Context hygiene is an operational practice, not a one-time optimization.
  - Sustained gains come from periodic audits plus small daily habits.
- Prerequisites:
  - A recurring review cadence (weekly or biweekly).
- When to use:
  - During retrospectives on session quality, cost, and limit frequency.
- Example:
  - Add a recurring calendar reminder to run `/context` baseline checks and prune drifted settings/instructions.

## Practical implementation checklist

- [ ] Capture a fresh-session `/context` baseline and keep it as a benchmark.
- [ ] Disconnect MCP servers not needed for the current task.
- [ ] Replace at least one frequently used MCP workflow with a CLI path where practical.
- [ ] Run the five-question pruning pass on `CLAUDE.md` and remove low-value rules.
- [ ] Split bulky instructions into companion reference docs with one-line pointers.
- [ ] Remove or rewrite verbose, low-signal skills.
- [ ] Tune compaction behavior and output-size handling in `settings.json`.
- [ ] Add deny rules for irrelevant folders/files that should not enter working context.
- [ ] Use `/clear` between unrelated tasks and plan-first prompts for non-trivial work.
- [ ] Re-run an audit on a fixed cadence to prevent setup drift.

## Companion files

- General setup and Claude workflow notes: [claude/README.md](README.md)
- Broader token tactics: [claude/claude-code-token-hacks-reference.md](claude-code-token-hacks-reference.md)
- Limits model and session architecture tactics: [claude/claude-code-limits-optimization-reference.md](claude-code-limits-optimization-reference.md)
- Beginner setup baseline: [claude/claude-code-beginner-tutorial-reference.md](claude-code-beginner-tutorial-reference.md)

## Notes and caveats

- This reference paraphrases video content and avoids long transcript excerpts.
- Reported token savings are scenario-dependent; measure with your own baseline and workload.
- Verify current behavior against official Anthropic docs before automating policy-level defaults.
- For production-critical work, prioritize correctness and safety over token optimization.
