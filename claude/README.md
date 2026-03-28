# Claude setup and notes

This folder stores Claude-related setup, customizations, and usage notes so I can keep multiple devices in sync.

## What is included

- `settings.json`: canonical Claude CLI settings to reuse across devices.
- Notes for software in my Claude Pro setup:
  - Claude CLI
  - Claude macOS app
  - Claude Chrome extension

## Install and reference links

- Claude Code (CLI) docs and install: https://docs.anthropic.com/en/docs/claude-code/quickstart
- Claude desktop app download: https://claude.ai/download
- Claude in browser: https://claude.ai
- Chrome Web Store Claude search (for extension listing): https://chromewebstore.google.com/search/Claude%20Anthropic

## MacBook Air setup checklist

1. Sign in to Claude Pro on web and desktop app.
2. Install Claude CLI using the official quickstart guide.
3. Install the Claude extension from the Chrome Web Store.
4. Copy this repository's settings into local CLI config:

```bash
cp claude/settings.json ~/.claude/settings.json
```

5. Verify the settings are active:

```bash
cat ~/.claude/settings.json
```

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

## Ongoing maintenance

- Treat `claude/settings.json` in this repo as source of truth.
- After changing local settings on one device, copy the updated file here and sync to other devices.
- Add dated notes for any new hooks, plugins, or workflow conventions.
