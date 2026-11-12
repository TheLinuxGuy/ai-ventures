# Codex skills

Repository-managed skills for Codex live here, separate from the Claude-specific collection under `claude/skills/`.

## Available skills

- [toilet-paper-value](toilet-paper-value/SKILL.md) — evaluate a toilet paper offer from a product link and user-supplied price using Tetrion TP Calculator Pro benchmarks and grading rules.

## Install on this device

This repository copy is the source of truth. To make a skill available in Codex, link its folder into the user skill directory:

```bash
ln -s "/Users/gfm/Library/CloudStorage/SynologyDrive-home/GitHub/ai-ventures/codex/skills/toilet-paper-value" "$HOME/.codex/skills/toilet-paper-value"
```

The link is device-local; the skill contents stay in this synced repository. If Codex was already open when installing, restart or refresh it so skill discovery can pick up the new skill.
