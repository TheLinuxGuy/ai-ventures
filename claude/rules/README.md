# Claude Rules

Rules are markdown files placed in `~/.claude/rules/` that Claude Code loads automatically at the start of every session. They extend or specialize Claude's behavior globally, without being part of any specific project's `CLAUDE.md`.

## How rules work

- Stored in `~/.claude/rules/*.md` (user-scoped, apply to all sessions)
- Loaded alongside `~/.claude/CLAUDE.md` and any project-level `CLAUDE.md`
- Each file should focus on one behavior or integration
- Rules can be installed by tools (e.g. `npx ctx7 setup`) or written manually

## When to use a rule vs. CLAUDE.md

| Use a rule (`~/.claude/rules/`) | Use `CLAUDE.md` |
|---|---|
| Global behavior across all projects | Project-specific conventions |
| Installed by a tool or plugin | Manually maintained per project |
| Single-purpose (one integration) | Broad project context (stack, commands, conventions) |

## Syncing rules to other machines

Rules live in `~/.claude/rules/` which on Synology Drive machines is covered by the `~/.claude` symlink — no extra steps needed.

On non-Synology machines, re-run the tool that installed the rule (e.g. `npx ctx7 setup`) or manually copy files from this folder into `~/.claude/rules/`.

## Available rules

### [context7.md](context7.md)

- **Installed by:** `npx ctx7 setup`
- **Local path:** `~/.claude/rules/context7.md`
- **Purpose:** Tells Claude to use the `ctx7` CLI to fetch current library documentation instead of relying on training data. Activates automatically when the user asks about any library, framework, SDK, API, or CLI tool.
- **Companion skill:** [`../skills/find-docs/SKILL.md`](../skills/find-docs/SKILL.md)
- **CLI reference:** https://context7.com/docs/clients/cli#query-library-documentation
