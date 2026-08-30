# Claude Code Beginner Tutorial Reference

Source: https://www.youtube.com/watch?v=qYqIhX9hTQk

## Purpose

Practical chapter-by-chapter reference for the Tech With Tim beginner tutorial. 4 tips for making Claude Code 10x better.

## Video metadata

- Title: FULL Claude Code Tutorial for Beginners in 2026! (Step-By-Step)
- Creator: Tech With Tim (@TechWithTim)
- Duration: 15:09
- Published: 2026-03-29

## Global prerequisites

- Claude Code installed (`npm install -g @anthropic-ai/claude-code`)
- Claude Pro or Max subscription
- Claude desktop app (recommended for plugin management)
- GitHub account (for Tip 4)

## Overlap with existing notes

| Topic | This file | Existing coverage |
|---|---|---|
| CLAUDE.md setup | Full walkthrough | [README.md](README.md) §CLAUDE.md behavior |
| `/model` command | Model switching | [README.md](README.md) tip 1 |
| `/compact` command | Context compaction | [README.md](README.md) tip 4 |
| MCP servers | GitHub MCP setup | [README.md](README.md) tip 5 |
| Sub-agents | Via Superpowers plugin | [claude-code-advanced-course-reference.md](claude-code-advanced-course-reference.md) |

Use **this file** for setup orientation and plugin installation. Use the advanced reference for orchestration, pipelines, and security patterns.

---

## Chapter-by-chapter reference

### [00:00:00] Intro — Use Claude Code inside an editor

- **Concept:** Run Claude Code from inside VS Code / Cursor / Windsurf via the extension instead of a bare terminal.
- **Why:** You can see the file tree, diffs, and generated output side-by-side. Much easier to review what Claude is actually doing.
- **How:**
  1. Open the Extensions pane in Cursor/VS Code
  2. Search "claude" → install the Claude Code extension
  3. Click "Claude Code" → "New Session"
- **When to use:** Always — this is the recommended default interface.

---

### [00:02:00] Tip 1 — CLAUDE.md for long-term memory

- **Concept:** A `CLAUDE.md` file in the project root is loaded automatically at the start of every session. Claude has no memory between sessions by default — this file is the fix.
- **Prerequisites:** Any project you use Claude Code with regularly.
- **When to use:** Create on day 1 of any project.
- **What to include:**
  - Tech stack and key dependencies
  - Dev commands (`npm test`, `pytest`, etc.)
  - Code conventions (naming, patterns to avoid)
  - Project structure notes
  - API references or domain facts
- **Key habit:** Tell Claude to update `CLAUDE.md` with important information as the project evolves. It grows richer over time.
- **Example:**
  ```markdown
  # Stack: Next.js 14, TypeScript, Postgres
  # Test: npm test
  # Conventions: no default exports, use named functions
  ```

---

### [00:04:30] Tip 2 — Plugins & connectors (MCP)

Install via **Claude Desktop app → Code → Customize → Browse Plugins**.

You can install plugins at project level (one project only) or global/user level (all sessions). Don't bloat Claude with tools it won't need — scope appropriately.

#### Plugin 1: Playwright

- **What:** Browser automation and testing.
- **When to use:** Web app projects where you want Claude to run end-to-end tests, sign in, click through flows, and create reusable automation scripts.
- **Scope:** Project-level (only relevant to web projects).

#### Plugin 2: Superpowers

- **What:** Adds skills to Claude — brainstorming, parallel sub-agent dispatch, systematic debugging, code review agent, session-start hooks.
- **When to use:** Any session where you want structured workflows (brainstorming before feature work, parallel tasks, debugging chains).
- **Example:** Prompt "can you do some brainstorming for X" → Claude automatically invokes the brainstorming skill from Superpowers.
- **Scope:** Global (useful in all projects).

#### Plugin 3: Context7

- **What:** Fetches up-to-date library documentation on demand. Prevents Claude from suggesting deprecated APIs or old patterns.
- **When to use:** Any project using fast-moving dependencies (React, Next.js, LangChain, etc.).
- **Scope:** Global.

---

### [00:10:00] Tip 3 — GitHub MCP server

- **Concept:** Connect Claude Code to GitHub so it can create repos, push code, open PRs — without you touching git manually.
- **Why:** The built-in GitHub plugin is unreliable; manual setup via CLI is more dependable.
- **Prerequisites:** GitHub account + personal access token.

**Step-by-step:**

1. Get a GitHub personal access token:
   - GitHub → Settings → Developer settings → Personal access tokens → Classic
   - Scopes: select **repo** (minimum)
   - Copy the token

2. Run the install command (from your terminal, not inside Claude Code):
   ```bash
   claude mcp add github --token YOUR_TOKEN_HERE --scope user
   ```
   - `--scope user` = available in all Claude Code sessions (recommended for GitHub)
   - `--scope project` = only in the current project dir
   - `--scope local` = default, current project only, not shared

3. Verify inside a Claude Code session:
   ```
   /mcp
   ```
   Should show `github` as connected.

4. Test:
   ```
   Make a new remote GitHub repository and push the current code to it. Call it demo-project.
   ```

**Other useful MCP servers to explore:**
- **DB Hub** — direct Postgres access; Claude can query tables, inspect schema, and write data-aware code
- **Frontend Design** — better UI/component output
- **Code Review** — structured review workflows

---

### [00:15:00] Useful commands

| Command | What it does |
|---|---|
| `/model` | Switch between Sonnet, Opus, Opus (1M context), Haiku |
| `/compact` | Summarize accumulated context into a smaller block; runs automatically near context limit |
| `/insights` | Generate a shareable HTML report of your Claude Code usage — sessions, messages, files changed, suggestions for improvement |
| `/mcp` | List connected MCP servers and their status |

**Model selection guide:**
- **Sonnet** — default for most tasks (~80% of work)
- **Opus** — complex architecture, large refactors
- **Opus 1M** — when you need to load a very large codebase or long context
- **Haiku** — fast, cheap tasks (no frontier capability needed)

---

## Practical implementation checklist

- [ ] Install Claude Code extension in Cursor/VS Code
- [ ] Create `CLAUDE.md` in root of every project
- [ ] Install Playwright plugin (web projects only)
- [ ] Install Superpowers plugin (global)
- [ ] Install Context7 plugin (global)
- [ ] Add GitHub MCP server with `--scope user`
- [ ] Verify with `/mcp` inside a session
- [ ] Run `/insights` to baseline your usage patterns
- [ ] Tell Claude to update `CLAUDE.md` regularly

## Companion files

- Daily tactics: [claude/README.md](README.md)
- Advanced patterns (orchestration, agents, pipelines): [claude/claude-code-advanced-course-reference.md](claude-code-advanced-course-reference.md)
- Settings: [claude/settings.json](settings.json)
