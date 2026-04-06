# Codex Plugin for Claude Code

## What this plugin is

The Codex plugin lets you run OpenAI Codex capabilities from inside Claude Code workflows.

In practice, this gives you:
- Independent code reviews from Codex while staying in Claude sessions.
- Adversarial review workflows that challenge architecture and risk assumptions.
- A rescue/delegation path for investigation and implementation tasks.
- Background job controls so long-running Codex tasks do not block your main flow.

## Official metadata

- Plugin name: Codex plugin for Claude Code
- Maintainer: OpenAI
- Official plugin repository: https://github.com/openai/codex-plugin-cc
- Official Codex docs hub: https://developers.openai.com/codex
- Codex app server docs: https://developers.openai.com/codex/app-server
- Context7 library ID used for command verification: `/openai/codex-plugin-cc`

## Requirements

- Claude Code with plugin support
- Node.js 18.18+
- A ChatGPT subscription (including Free) or OpenAI API key
- Local Codex CLI availability (`@openai/codex`), which can be auto-installed during setup

## Installation

1. Add the OpenAI plugin marketplace:

```bash
/plugin marketplace add openai/codex-plugin-cc
```

2. Install Codex plugin:

```bash
/plugin install codex@openai-codex
```

3. Reload plugins:

```bash
/reload-plugins
```

4. Run setup check:

```bash
/codex:setup
```

5. If prompted, install/login Codex CLI:

```bash
npm install -g @openai/codex
!codex login
```

## How to use it effectively

Recommended baseline loop:

1. Build or refactor with Claude (Sonnet/Opus).
2. Run `/codex:review` for a neutral second pass.
3. Run `/codex:adversarial-review` for pressure testing before shipping.
4. Feed highest-severity findings back into Claude for implementation.
5. Re-run review on final diff.

When to use `/codex:rescue`:
- A task is mostly investigative and can be delegated.
- You want a lower-cost or alternate-model pass before using higher-cost models.
- You need background execution while continuing other work.

## Verified command list (as of 2026-04-05)

The following commands were verified against official OpenAI plugin docs and Context7 retrieval.

### 1) `/codex:setup`

- Purpose: Verify/install Codex readiness and authentication.
- Key options:
  - `--enable-review-gate`
  - `--disable-review-gate`

### 2) `/codex:review`

- Purpose: Standard read-only review of current work.
- Key options:
  - `--base <ref>`
  - `--background`
  - `--wait`
  - `--scope <value>`

### 3) `/codex:adversarial-review`

- Purpose: Steerable review that challenges implementation and design choices.
- Key options:
  - `--base <ref>`
  - `--background`
  - `--wait`
  - trailing focus text (custom challenge prompt)

### 4) `/codex:rescue`

- Purpose: Delegate investigation/implementation tasks to Codex rescue subagent.
- Key options:
  - `--background`
  - `--wait`
  - `--resume`
  - `--fresh`
  - `--model <model>`
  - `--effort <level>`

### 5) `/codex:status`

- Purpose: Show running/recent Codex jobs for the current repository.
- Typical usage:
  - `/codex:status`
  - `/codex:status <task-id>`

### 6) `/codex:result`

- Purpose: Show stored final output for completed Codex job.
- Typical usage:
  - `/codex:result`
  - `/codex:result <task-id>`

### 7) `/codex:cancel`

- Purpose: Cancel an active background Codex job.
- Typical usage:
  - `/codex:cancel`
  - `/codex:cancel <task-id>`

## Insights learned from the two video walkthroughs

- The strongest workflow is hybrid, not model-vs-model:
  - Use Claude for implementation speed and repo context.
  - Use Codex review commands for second-opinion rigor.
- Adversarial review is most useful right before merge or deployment gates.
- Review results can differ between models; the practical win comes from combining them.
- For cost-sensitive workflows, route exploratory tasks to lower-cost paths first, then escalate.

## Caveats

- Background and review-gate loops can consume usage quickly if left unattended.
- Plugin command flags and behavior can change; re-check the official repo docs after updates.
- Use read-only reviews as decision support, then apply changes through your normal code-review process.