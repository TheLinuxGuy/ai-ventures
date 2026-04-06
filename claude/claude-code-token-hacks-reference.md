# Claude Code Token Hacks Reference

Source video: https://www.youtube.com/watch?v=49V-5Ock8LU

## Purpose

Convert the 18-minute token-management video into a practical reference you can use while actively working in Claude Code.

This guide is optimized for execution:
- What each chapter teaches
- Prerequisites before applying it
- When to use each tactic
- A concrete example for immediate use

## Video metadata

- Title: 18 Claude Code Token Hacks in 18 Minutes
- Creator: Nate Herk | AI Automation
- Duration: 18:57
- Published: 2026-04-02
- Chapters detected: 8

## Global prerequisites

- Active Claude Code workflow (CLI or editor integration)
- Ability to run slash commands inside Claude Code sessions
- Basic understanding of project instructions in `CLAUDE.md`
- Awareness of your session usage dashboard and reset window

## Official docs to keep open

- Claude Code docs: https://docs.anthropic.com/en/docs/claude-code
- Slash commands: https://docs.anthropic.com/en/docs/claude-code/slash-commands
- Settings: https://docs.anthropic.com/en/docs/claude-code/settings
- Memory and context behavior: https://docs.anthropic.com/en/docs/claude-code/common-workflows
- MCP overview: https://docs.anthropic.com/en/docs/mcp

## Overlap with existing notes

Primary overlap targets:
- `claude/README.md` (tactical workflow tips)
- `claude/claude-code-beginner-tutorial-reference.md` (setup and baseline commands)
- `claude/claude-code-advanced-course-reference.md` (strategic orchestration patterns)

Overlap and differentiation:

| Topic | This file | Existing docs |
|---|---|---|
| `/clear`, `/compact`, `/context`, `/cost` | Token-economy playbook and timing rules | Mentioned as commands in beginner/README notes |
| MCP usage | Minimize connected servers for context hygiene | Existing docs explain MCP setup and use-cases |
| CLAUDE.md design | Keep lean, index-style, decision-focused | Existing docs explain creation and governance |
| Sub-agents | Use selectively due token overhead | Advanced guide covers architecture and role design |
| Session timing | Peak/off-peak scheduling and pacing | Not covered deeply in other files |

How to use together:
1. Use this file for cost control and session hygiene.
2. Use the beginner reference for setup and command discovery.
3. Use the advanced reference for team/process architecture.

## Chapter-by-chapter reference

### 0:00 The Token Problem

- Concept:
  - Session limits feel tighter because token spend compounds across a long thread.
  - A single chat can become expensive even with short prompts.
- Prerequisites:
  - Access to your Claude usage dashboard.
  - Willingness to change session habits (not just upgrade plan tiers).
- When to use:
  - When you keep hitting limits earlier than expected.
- Example:
  - Before continuing a long thread, decide whether the task is unrelated and should move to a fresh session.

### 0:48 How Tokens Actually Work

- Concept:
  - Claude re-reads prior conversation context when generating new replies, so costs compound over time.
  - System context also contributes: instructions, tools, skills, and connected integrations.
- Prerequisites:
  - Basic mental model of prompt + response loops.
- When to use:
  - At the start of any optimization effort; this chapter explains the root mechanism.
- Example:
  - Treat prompt quality and session boundaries as a token budget problem, not just a coding problem.

### 3:04 Tier 1 Hacks (High impact, easy)

The video frames nine quick wins:

1. Start fresh conversations with `/clear` between unrelated tasks.
2. Disconnect unused MCP servers; prefer CLI paths when practical.
3. Batch multi-step asks into one well-scoped prompt when possible.
4. Use plan mode before execution to reduce wrong-path rework.
5. Run `/context` and `/cost` to make hidden overhead visible.
6. Enable a terminal status line to track model and context usage continuously.
7. Keep dashboard visibility open so usage surprises are reduced.
8. Paste only the smallest relevant code/document slice.
9. Watch long-running agent behavior and stop drift early.

Per-hack practical framing:

- Concept:
  - Reduce avoidable context growth and avoid low-value generations.
- Prerequisites:
  - Basic command fluency: `/clear`, `/context`, `/cost`.
- When to use:
  - Daily, on every active coding session.
- Example:
  - Replace a three-message chain (summarize, find issues, propose fix) with one structured prompt that requests all three outputs together.

### 8:48 Tier 2 Hacks (Process and hygiene)

The video frames five intermediate tactics:

1. Keep `CLAUDE.md` lean (index-style, stable essentials only).
2. Be surgical with file references (`@file` and named functions/paths).
3. Compact manually around ~60% context (not only near auto-compaction).
4. Account for cache timeout behavior before/after breaks.
5. Prevent command-output bloat from flooding context.

- Concept:
  - Process discipline preserves quality and lowers hidden token burn.
- Prerequisites:
  - A maintained project instruction file and predictable folder structure.
- When to use:
  - As soon as projects become multi-file and iterative.
- Example:
  - Ask: "Check `verifyUser` in `auth.js` for null handling" instead of "scan the repo for auth bugs".

### 12:15 Is Hitting Your Limit Actually Bad?

- Concept:
  - Hitting limits is not automatically failure; it can indicate high productive usage.
  - The key distinction is wasteful burn versus deliberate, value-producing consumption.
- Prerequisites:
  - A baseline for what "good usage" means in your workflow.
- When to use:
  - When limit anxiety causes poor decisions (over-compression, under-specifying prompts, skipping planning).
- Example:
  - If you hit limits after sustained high-output sessions with controlled context hygiene, treat it as a scheduling/input issue, not only a budget issue.

### 13:17 Tier 3 Hacks (Advanced optimization)

The video frames four advanced tactics plus one "3.5" timing tactic:

1. Route tasks to the right model (default, lightweight, or deep-thinking model paths).
2. Use sub-agents selectively because they can carry meaningful setup overhead.
3. Schedule heavy sessions around lower-demand windows when possible.
3.5. Pace usage around reset timing (push when near reset with budget left, pause when near cap with long reset wait).
4. Treat `CLAUDE.md` as a durable system constitution (store decisions, not full conversation history).

- Concept:
  - Advanced gains come from orchestration and timing, not prompt tricks alone.
- Prerequisites:
  - Comfort with model switching and sub-agent workflows.
- When to use:
  - High-throughput workdays, large refactors, or multi-session planning cycles.
- Example:
  - Run broad research in a lower-cost path, return condensed findings, and reserve expensive deep-analysis runs for critical decisions only.

### 17:32 What To Do Right Now

- Concept:
  - Convert ideas into immediate, measurable operational steps.
- Prerequisites:
  - One active project/session to tune.
- When to use:
  - Immediately after reading this reference.
- Example:
  - In your next session: run `/context`, run `/cost`, disconnect unused MCP servers, and compact around 60% context before quality degrades.

### 18:12 Final Thoughts

- Concept:
  - Balance quality and cost; many "limit problems" are context hygiene problems.
- Prerequisites:
  - Willingness to maintain habits consistently.
- When to use:
  - During retrospectives on why a session became expensive.
- Example:
  - Track one week of behavior changes and compare: fewer follow-up corrections, fewer runaway sessions, and more predictable reset timing.

## Practical implementation checklist

- [ ] Use `/clear` between unrelated tasks.
- [ ] Keep only required MCP servers connected per session.
- [ ] Start medium/large work in plan mode before code changes.
- [ ] Enable and monitor status line plus usage dashboard.
- [ ] Run `/context` and `/cost` at least once per major task.
- [ ] Compact around ~60% context when quality is still stable.
- [ ] Keep `CLAUDE.md` under active trim with index-style pointers.
- [ ] Reduce command output noise (avoid huge unfiltered outputs).
- [ ] Time heavy sessions for lower-demand windows when feasible.

## Companion files

- Tactical setup and workflow notes: [claude/README.md](README.md)
- Beginner orientation and plugin setup: [claude/claude-code-beginner-tutorial-reference.md](claude-code-beginner-tutorial-reference.md)
- Strategic orchestration patterns: [claude/claude-code-advanced-course-reference.md](claude-code-advanced-course-reference.md)

## Notes and caveats

- This guide paraphrases video content and does not copy long transcript passages.
- Token behavior, model pricing, and platform limits may change over time.
- Re-check command behavior and quotas against current official docs.
- If a task is high-risk or production-critical, optimize for correctness first, then token efficiency.