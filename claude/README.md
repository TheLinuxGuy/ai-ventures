# Claude setup and notes

This folder stores Claude-related setup, customizations, and usage notes so I can keep multiple devices in sync.

## What is included

- `settings.json`: canonical Claude CLI settings to reuse across devices.
- `CLAUDE.md`: repository-managed source for global Claude instructions.
- Plugins index: [`claude/plugins/README.md`](claude/plugins/README.md)
- Skills index: [`claude/skills/README.md`](claude/skills/README.md)
- Rules index: [`claude/rules/README.md`](claude/rules/README.md)
- Notes for software in my Claude Pro setup:
  - Claude CLI
  - Claude macOS app
  - Claude Chrome extension

## Install and reference links

- Claude Code (CLI) docs and install: https://docs.anthropic.com/en/docs/claude-code/quickstart
- Claude desktop app download: https://claude.ai/download
- Claude in browser: https://claude.ai
- Chrome Web Store Claude search (for extension listing): https://chromewebstore.google.com/search/Claude%20Anthropic

## New machine setup

There are two setup paths depending on whether Synology Drive is available. Choose one.

---

### Path A — Synology Drive machine (preferred)

**Do this before running Claude Code for the first time.** If Claude Code has already run and created `~/.claude`, delete or back it up first (`rm -rf ~/.claude`).

1. Sign in to Claude Pro on web and desktop app.
2. Install Synology Drive Client and confirm the drive is mounted at `~/Library/CloudStorage/SynologyDrive-home/` (or your equivalent path).
3. Install Claude CLI using the official quickstart guide.
4. Install the Claude extension from the Chrome Web Store.
5. Symlink `~/.claude` to the Synology-synced copy:

```bash
ln -s ~/Library/CloudStorage/SynologyDrive-home/.claude ~/.claude
```

6. Verify the symlink:

```bash
ls -la ~/.claude
# Should show -> .../SynologyDrive-home/.claude
```

7. Run Claude Code. Settings, skills, memories, and `CLAUDE.md` are now synced automatically across all Synology Drive machines.
8. Install MCP servers — these are stored in `~/.claude.json` (personal, not synced) and must be re-run on each machine:
   ```bash
   npx ctx7 setup
   ```
   When prompted: CLI + Skills → log in → Claude Code. See [Plugins and MCP servers](#plugins-and-mcp-servers) for the full list.

> `sync-skills.sh` is **not needed** on Synology Drive machines — the symlink keeps everything current.

---

### Path B — Non-Synology machine (manual sync fallback)

1. Sign in to Claude Pro on web and desktop app.
2. Install Claude CLI using the official quickstart guide.
3. Install the Claude extension from the Chrome Web Store.
4. Clone this repository.
5. Sync repository-managed Claude assets (global `CLAUDE.md`, skills, settings) into `~/.claude`:

```bash
cp claude/settings.json ~/.claude/settings.json
./claude/sync-skills.sh "$HOME/.claude"
```

6. Verify:

```bash
cat ~/.claude/CLAUDE.md
ls -la ~/.claude/skills
```

7. Install MCP servers — these are stored in `~/.claude.json` (personal, not synced) and must be re-run on each machine:
   ```bash
   npx ctx7 setup
   ```
   When prompted: CLI + Skills → log in → Claude Code. See [Plugins and MCP servers](#plugins-and-mcp-servers) for the full list.
8. Re-run `sync-skills.sh` whenever skills or `CLAUDE.md` change in the repo:

```bash
./claude/sync-skills.sh "$HOME/.claude"
```

> Note: memories (stored in `~/.claude/projects/*/memory/`) are **not synced** on this path. Only skills and `CLAUDE.md` are kept current.

## Plugins and MCP servers

### Context7 (global — always install)

Context7 fetches up-to-date library documentation on demand. Without it, Claude often suggests deprecated APIs or patterns from older library versions.

**Install:**
```bash
npx ctx7 setup
```

When prompted:
- Access method → **CLI + Skills**
- Log in via browser when it opens
- Agent → **Claude Code**

This installs two things into `~/.claude/`:
- `skills/find-docs/` — skill that triggers doc lookups → [claude/skills/find-docs](skills/find-docs/SKILL.md)
- `rules/context7.md` — rule that tells Claude when and how to use it → [claude/rules/context7.md](rules/context7.md)

See [claude/rules/README.md](rules/README.md) for an explanation of what rules are and how they differ from `CLAUDE.md`.

Verify:
```bash
claude mcp list
# Should show: context7: ... ✓ Connected
```

> **Why not just copy `~/.claude.json`?** MCP server config is stored in `~/.claude.json` alongside personal data (account UUIDs, email, session metrics). That file must never be committed. Always re-run `npx ctx7 setup` on each new machine instead.

**When it activates:** Automatically when Claude needs to reference library docs. You can also prompt it explicitly: *"use context7 to check the latest Next.js 15 routing API"*.

**Scope:** Global — install once, available in all projects.

> See also: [Beginner tutorial reference §Context7](claude-code-beginner-tutorial-reference.md), [skills/find-docs](skills/find-docs/SKILL.md), and [Context7 CLI reference](https://context7.com/docs/clients/cli#query-library-documentation).

---

### Other recommended plugins

See [Beginner tutorial reference §Tip 2 — Plugins](claude-code-beginner-tutorial-reference.md) for Playwright and Superpowers setup.

Codex plugin guide and command reference:
- [claude/plugins/codex-chatgpt.md](plugins/codex-chatgpt.md)
- [claude/plugins/README.md](plugins/README.md)

---

## Global vs project CLAUDE.md behavior

Claude can load user and project instructions together.

- User/global scope (personal): `~/.claude/CLAUDE.md`
- Project scope (shared): `./CLAUDE.md` or `./.claude/CLAUDE.md`

Load behavior (practical):
- Global and project instructions are both loaded when present.
- More specific/project instructions should be treated as higher priority for project behavior.
- CLAUDE.md files in parent directories can also be loaded by directory walk logic.
- Subdirectory CLAUDE.md and path-scoped rules can load when files in those paths are accessed.

Useful verification commands inside Claude Code:
- `/memory` to see loaded instruction files
- `/status` to inspect active settings sources

## Set up CLAUDE.md on new projects

1. In a new project, create either `CLAUDE.md` or `.claude/CLAUDE.md`.
2. Keep project-specific standards there (build/test commands, architecture constraints, naming conventions).
3. Optionally run `/init` in Claude Code to generate a starter file, then refine it.
4. For larger projects, split instructions into `.claude/rules/*.md` and use path-scoped rules when useful.

## Exclude global CLAUDE.md for one specific project

If a specific project should not inherit your global/user instructions, use local excludes in that project.

1. Create `.claude/settings.local.json` in the project root.
2. Add a `claudeMdExcludes` entry targeting your global file path.

Example:

```json
{
  "claudeMdExcludes": [
    "**/.claude/CLAUDE.md",
    "/Users/<your-user>/.claude/CLAUDE.md"
  ]
}
```

3. Re-open the project session and verify via `/memory` that the global file is excluded.

Note:
- Managed policy CLAUDE.md files cannot be excluded by user/project settings.

## When to use which tool

- Claude CLI:
  - Use for coding tasks, terminal-driven workflows, local file operations, and repeatable scripting.
  - Example: refactor a project, generate a patch, or automate a documentation update from terminal context.
- Claude macOS app:
  - Use for long-form planning, strategy, and general chat away from terminal workflow.
  - Example: draft an architecture approach before implementing in code.
- Claude Chrome extension:
  - Use for page-aware workflows in the browser.
  - Example: summarize documentation pages, extract action items, and then move implementation tasks into CLI.

## Customization notes

- Current local preferences in `settings.json`:
  - Long history retention (`cleanupPeriodDays: 365`)
  - Reduced telemetry/error reporting
  - A pre-tool hook that blocks `pip install` and nudges `uv` usage
  - Voice enabled

## Claude workflow tips (video highlights)

Reference video: https://www.youtube.com/watch?v=XkSBO-CZDFs

Related full-course reference: [claude/claude-code-advanced-course-reference.md](claude/claude-code-advanced-course-reference.md)

Beginner tutorial reference: [claude/claude-code-beginner-tutorial-reference.md](claude/claude-code-beginner-tutorial-reference.md)

Token hacks reference (cost/context optimization): [claude/claude-code-token-hacks-reference.md](claude/claude-code-token-hacks-reference.md)

Limits optimization reference (session/project/config tactics): [claude/claude-code-limits-optimization-reference.md](claude/claude-code-limits-optimization-reference.md)

These notes are based on the video highlights and should be treated as workflow guidance. For command availability and current behavior, verify in Claude Code with `/help`.

How this section is intended to be used:
- Use this section as quick tactical reminders during active work.
- Use the full course reference for deeper system design and workflow architecture.
- Use the token hacks reference when your priority is extending session life and reducing context waste.
- Use the limits optimization reference when your priority is fixing rapid limit drain in active projects.

### 1) Prioritize CLI over MCP when possible

- **Docs:**
  - Claude Code overview: https://docs.anthropic.com/en/docs/claude-code
  - Claude Code workflows: https://docs.anthropic.com/en/docs/claude-code/common-workflows
  - MCP overview: https://docs.anthropic.com/en/docs/mcp

- **What this does:**
  - Keeps work in terminal-native flows, which can reduce context/tool overhead for local coding tasks.
- **How to use it:**
  - Start with direct shell commands and Claude Code terminal workflows.
  - Add MCP only when you need explicit external tool orchestration or structured integrations.
- **Example:**
  - Prefer "search files, edit, run tests" directly in terminal before introducing an MCP server for the same task.

### 2) Use `/btw` for side conversations

- **Docs:**
  - Slash commands: https://docs.anthropic.com/en/docs/claude-code/slash-commands

- **What this does:**
  - Creates a side thread for tangents so your main task context stays cleaner.
- **How to use it:**
  - When a non-blocking thought appears, move it into a `/btw` thread.
  - Return to the main thread after capturing the decision.
- **Example:**
  - Mid-refactor, ask a naming/style question in `/btw` instead of injecting it into the main implementation thread.

### 3) Add task-completion audio with `/hook`

- **Docs:**
  - Hooks: https://docs.anthropic.com/en/docs/claude-code/hooks
  - Slash commands: https://docs.anthropic.com/en/docs/claude-code/slash-commands

- **What this does:**
  - Adds an alert when a task finishes so you can multitask without constantly checking status.
- **How to use it:**
  - Define a completion hook that runs a local notifier.
  - Keep the hook lightweight and non-blocking.
- **Example:**
  - On macOS, trigger a short sound so you know when a long test/debug cycle finishes.

### 4) Use `/clear` frequently

- **Docs:**
  - Slash commands: https://docs.anthropic.com/en/docs/claude-code/slash-commands

- **What this does:**
  - Resets accumulated context to keep responses sharp in long-running sessions.
- **How to use it:**
  - Clear context after major milestones.
  - Immediately restate: current goal, constraints, and next action.
- **Example:**
  - Finish "implement feature", run `/clear`, then start fresh with "now write tests for feature X with Y constraints".

### 5) Enable a custom status line with `/status-line`

- **Docs:**
  - Status line and settings: https://docs.anthropic.com/en/docs/claude-code/settings
  - Slash commands: https://docs.anthropic.com/en/docs/claude-code/slash-commands

- **What this does:**
  - Displays high-signal runtime info continuously (for example cwd, model, context usage).
- **How to use it:**
  - Add only the fields you actively use in decisions.
  - Avoid cluttering the status line with rarely-used metrics.
- **Example:**
  - Show working directory + context percentage so you catch wrong-folder actions and high-context sessions early.

### 6) Use the Skill Creator workflow to build and benchmark skills

- **Docs:**
  - Skills: https://docs.anthropic.com/en/docs/claude-code/skills
  - Common workflows: https://docs.anthropic.com/en/docs/claude-code/common-workflows

- **What this does:**
  - Helps you create repeatable instructions (skills) for recurring tasks and evaluate quality with benchmarks.
- **How to use it:**
  - Identify a repeated workflow (for example: PR review, release notes, migration checklist).
  - Encode the workflow into a skill with scope, constraints, and expected output format.
  - Test with the same prompt set before/after updates to measure consistency and speed.
- **Examples:**
  - PR review skill:
    - Input: changed files and risk focus.
    - Output: ordered findings by severity + missing tests.
  - Changelog skill:
    - Input: commit range.
    - Output: user-facing release notes + breaking changes section.

#### Skills quick reference

- **What skills are:**
  - Reusable task instructions that produce consistent outputs for repeated work.
- **Where skills are configured:**
  - Project-scoped: repository Claude config area (commonly a project `.claude` path).
  - User/global: local Claude home config for cross-project use.
  - Verify exact paths/behavior from docs and `/help`: https://docs.anthropic.com/en/docs/claude-code
- **How to move skills between computers:**
  1. Keep project skills in git.
  2. Sync/export personal skills and copy to target machine.
  3. Run a small validation prompt set and compare output format/quality.
  4. Record migration notes in this repo.
- **When not to use skills:**
  - One-off exploratory work where fixed structure slows thinking.
  - Rapidly changing tasks where the skill becomes stale quickly.
  - Very simple requests where direct prompting is faster.

### 7) Enable agent teams (experimental)

- **Docs:**
  - Sub-agents: https://docs.anthropic.com/en/docs/claude-code/sub-agents
  - Claude Code overview: https://docs.anthropic.com/en/docs/claude-code

- **What this does:**
  - Allows multiple agents/sub-agents to coordinate on larger problems.
- **How to use it:**
  - Split work into independent tracks (for example: research, implementation, test design).
  - Merge outputs with a final synthesis pass.
- **Example:**
  - One agent maps architecture, another drafts code changes, another proposes tests, then you consolidate.

### 8) Ask open-ended plan mode prompts

- **Docs:**
  - Common workflows: https://docs.anthropic.com/en/docs/claude-code/common-workflows
  - Claude Code overview: https://docs.anthropic.com/en/docs/claude-code

- **What this does:**
  - Forces broader reasoning before implementation, often surfacing blind spots.
- **How to use it:**
  - Ask these questions right after the initial plan and before code edits.
  - Convert responses into explicit checks in your implementation plan.
- **Prompts to use during planning:**
  - What am I not thinking about?
  - What would an expert consider here?
- **Example:**
  - Before schema changes, ask for rollout risks, migration failure modes, and monitoring implications.

### 9) Use Obsidian as a second brain

- **Docs:**
  - Obsidian help: https://help.obsidian.md/
  - Claude Code quickstart: https://docs.anthropic.com/en/docs/claude-code/quickstart

- **What this does:**
  - Turns markdown notes into a searchable knowledge base that Claude can help maintain.
- **How to use it:**
  - Keep prompts, decisions, architecture notes, and postmortems in one vault.
  - Use links/tags so related concepts are discoverable in graph view.
- **Example:**
  - Store implementation notes and decision records in a vault, then ask Claude to summarize tradeoffs for the next sprint.

## Ongoing maintenance

- Treat `claude/settings.json` in this repo as source of truth.
- After changing local settings on one device, copy the updated file here and sync to other devices.
- Add dated notes for any new hooks, plugins, or workflow conventions.
