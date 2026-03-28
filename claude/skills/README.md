# Claude Skills Index

This folder contains reusable Claude-focused skills for repeatable workflows.

## Available skills

- [claude-youtube-summarize](claude-youtube-summarize/SKILL.md)
  - Purpose: Convert full YouTube videos/courses into structured markdown references.
  - Includes: chapter coverage, prerequisites, when-to-use guidance, examples, overlap merge checks.
  - Template: [course-reference-template.md](claude-youtube-summarize/course-reference-template.md)

## Folder convention

- Put one skill per folder.
- Keep a `SKILL.md` file in each skill folder.
- Add supporting templates/assets next to `SKILL.md` when needed.

## Portability note

Skill discovery paths are tool-specific. This repository keeps skills under `claude/skills/` for organization, but other tools may use different default folders or file formats. Always verify each tool's expected path and manifest format before reusing skills.

## Portability matrix

| Tool / ecosystem | Typical discovery path(s) | Typical file format | Auto-discovery expectation | Portability action |
|---|---|---|---|---|
| Claude Code (project-scoped skills) | `.claude/skills/<skill-name>/` | `SKILL.md` with YAML frontmatter | Usually expects Claude-specific skill structure in the configured skills directory | Mirror/copy repo skill into `.claude/skills/` when you want runtime discovery |
| Claude Code (repo notes organization) | `claude/skills/<skill-name>/` | `SKILL.md` + optional templates/assets | Usually not auto-discovered unless your tooling explicitly points here | Keep as source-of-truth docs; sync to runtime location as needed |
| GitHub Copilot customizations | `.github/instructions/*.instructions.md`, `.github/prompts/*.prompt.md`, `.github/agents/*.agent.md` | Instruction/prompt/agent markdown formats (not Claude `SKILL.md`) | Copilot discovers its own customization primitives, not Claude skills directly | Translate skill intent into Copilot instruction/prompt/agent files |
| Generic agent frameworks (varies) | Framework-specific (for example `.agents/skills/...` or config-defined paths) | Framework-defined schema (markdown/json/yaml) | Depends entirely on framework loader and config | Create adapter files or transform frontmatter/fields per framework |

## Practical migration pattern

1. Keep canonical skill content in this repo under `claude/skills/`.
2. For Claude runtime use, sync to `.claude/skills/` on each machine.
3. For Copilot, convert the workflow into `.github` instructions/prompts/agents.
4. For other frameworks, map fields (`name`, `description`, triggers, steps, outputs) into their expected schema.
5. Validate with a small test task before relying on the migrated version.

## One-command sync

- Script: `claude/sync-skills.sh`
- Default runtime directory: `~/claude`
- Default outputs:
  - `~/claude/CLAUDE.md`
  - `~/claude/skills/*`

```bash
./claude/sync-skills.sh
```

Use Claude Code default user-scope location instead:

```bash
./claude/sync-skills.sh "$HOME/.claude"
```

Optional clean mode (remove destination-only skill folders):

```bash
./claude/sync-skills.sh --clean
```
