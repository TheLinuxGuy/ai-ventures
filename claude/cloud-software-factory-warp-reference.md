# Cloud Software Factory (Warp) Reference

Source video: https://www.youtube.com/watch?v=nKjPBAw_N_0

## Purpose

Chapter-complete reference for Zach Lloyd's (Warp) talk on moving from engineers prompting agents on laptops to a sandboxed, cloud-hosted "software factory" that is defined in code, measured on your own data, and improves itself. Vendor-neutral concepts first; Warp Factories is the demo vehicle, not a requirement.

This guide focuses on:
- Why interactive local agents stop scaling (security, cost, governance)
- The factory design principles: open, adaptable, code-defined, owned
- The measure → score → self-improve → benchmark loop
- How the engineer role splits into product work and factory work

## Video metadata

- Title: How to Build a Software Factory That Improves Itself - Zach Lloyd, Warp | AI Engineer
- Creator: AI Engineer (speaker: Zach Lloyd, founder/CEO of Warp)
- Duration: 22:01
- Published: 2026-11-09
- Chapters detected: 15

## Global prerequisites

- Already using coding agents (Claude Code, Codex, etc.) interactively; this talk is about the step after that
- A team, ideally 10+ engineers (the speaker says the system pays off at team scale, not for one person)
- Existing work-intake tools (Slack, Linear/Jira, GitHub PRs) the factory can plug into
- A place to run sandboxed agents on infrastructure and inference you control
- A git repo to hold the factory definition

## Official docs

- Warp: https://www.warp.dev (Warp Factories is a commercial, non-open-source product; Warp Terminal is open source)
- Claude Code sub-agents: https://docs.anthropic.com/en/docs/claude-code/sub-agents
- Claude Code skills: https://docs.anthropic.com/en/docs/claude-code/skills
- Claude Code memory / `CLAUDE.md`: https://docs.anthropic.com/en/docs/claude-code/memory

## Overlap with existing notes

Primary overlap targets:
- [`claude-code-elephant-goldfish-model-reference.md`](claude-code-elephant-goldfish-model-reference.md): spec-driven planning; the Q&A advice to build from specs matches EGM
- [`claude-code-advanced-course-reference.md`](claude-code-advanced-course-reference.md): skills, sub-agents, orchestration at the single-developer level
- [`claude-code-token-hacks-reference.md`](claude-code-token-hacks-reference.md) and [`claude-code-limits-optimization-reference.md`](claude-code-limits-optimization-reference.md): per-session cost control; this talk covers cost control at the org level
- [`plugins/README.md`](plugins/README.md): Codex plugin notes (one example of multi-agent/tool mixing)

How this reference differs:

| Topic | This file (software factory) | Existing notes |
|---|---|---|
| Scope | Team/org infrastructure running agents in the cloud | One developer's local Claude Code session |
| Cost control | Per-PR cost tracking, model routing from your own benchmarks | Context hygiene, token and limit tactics |
| Quality | LLM-judge scoring of every run, automated factory fixes | Manual review, plan critique before build |
| Config | Whole factory (agents, skills, MCP, webhooks) versioned in a repo | `CLAUDE.md`, skills and settings synced per machine |

Tactical vs strategic:
- Tactical (solo or small team): the existing notes, plus borrowing two ideas cheaply: version your skills/config in git, and keep a small benchmark list of real past tasks.
- Strategic (team of ~10+): this talk. A centralized, sandboxed, measurable factory is infrastructure work and only pays off with enough volume.

## Chapter-by-chapter reference

### 0:00 Intro

- **Concept:** Speaker background (principal engineer at Google who led engineering on Google Docs; now founder/CEO of Warp, which sells Warp Factories and the open-source Warp Terminal, ~65k GitHub stars). Thesis: build the software factory as infrastructure.
- **Prerequisites:** None.
- **When to use:** Deciding whether this talk applies; it targets companies, not hobby projects.
- **Example:** A platform team evaluating whether to build an internal agent pipeline.

### 1:12 From interactive prompting to automated development

- **Concept:** Most companies are in an "interactive prompting" phase: engineers run Claude Code or Codex on laptops. The goal is "automated development": extract maximum business value from agents at lowest cost, in a controlled and secure way. Interactive use ties output to whoever is driving the agent.
- **Prerequisites:** Agents already adopted by the team.
- **When to use:** When you see inconsistent processes and unpredictable spend across engineers.
- **Example:** Ten engineers each with their own prompts and tools, producing variable quality and cost.

### 2:21 Why local agents hit limits

- **Concept:** Three problems.
  - **Security:** a compromised local agent inherits everything the user can access on that laptop.
  - **Cost control:** hard when each person has a custom process.
  - **Governance/visibility:** everyone sets up their own MCP servers, skills and tools; nobody can audit them.
  - Fix for both security and manageability: sandbox agents and move them to the cloud.
- **Prerequisites:** An inventory of what agents can currently reach (credentials, repos, MCP servers).
- **When to use:** As the checklist for justifying the move off laptops.
- **Example:** Audit which MCP servers and secrets each engineer's agent can use; the sprawl is the argument.

### 3:08 What a cloud software factory is

- **Concept:** A company-run loop in the cloud where humans and agents share the work. Humans set tasks; agents handle lifecycle stages: triage, spec work with a human, implementation, and verification (including computer use). You define the human/agent rules, then measure and improve the process.
- **Prerequisites:** Agreed stages for your lifecycle and where humans must approve.
- **When to use:** When designing the workflow before picking tools.
- **Example:** Task arrives → triage agent → spec agent with human sign-off → implementation agent → verification agent → PR.

### 4:03 Treat your factory as infrastructure

- **Concept:** Not a product or "AI colleague" but a stack you build on. Three traits:
  - **Open:** any model (open-weight or frontier) and any harness (the coding-agent runtime, e.g. Claude Code or Codex), since the best models and harnesses keep changing.
  - **Adaptable:** works with your existing infrastructure.
  - **Defined in code:** workflows, skills, MCP servers and where they run are described in version control, so you can test factory versions and let coding agents update the factory itself.
- **Prerequisites:** A repo for the factory definition; model/tool-agnostic wiring.
- **When to use:** As vendor-selection criteria and design principles.
- **Example:** Swapping the implementation agent's model by editing one config and opening a PR.

### 5:15 Own your data and compute

- **Concept:** "AI sovereignty": own all data going in and out, run agents on your own infrastructure and compute, and bring your own inference. Keep options open (any model, any harness) and own the core components.
- **Prerequisites:** Infra and inference you can host or contract; data-handling policy.
- **When to use:** Regulated or large-enterprise contexts; also anywhere lock-in is a concern.
- **Example:** Agents run in your cloud account against your inference endpoint, with traces stored in your own storage.

### 6:01 Measure on your own data

- **Concept:** Public leaderboards (SWE-bench, Terminal-Bench, Twitter opinions on the "best" model or harness) are not your workload. The target state is "measurement first on your own data": score (eval) how your coding agents are doing, feed the scores to agents that improve the factory, and build your own benchmarks by replaying real tasks on different models.
- **Prerequisites:** Stored run traces and a way to replay tasks (see later chapters).
- **When to use:** Before committing to a model or tool, and on a recurring basis as models change.
- **Example:** Re-run last month's frontend tasks on two models before choosing a default.

### 6:55 Product engineers and factory engineers

- **Concept:** Two engineering roles.
  - **Product engineers** build features and fix bugs, directing work through the factory.
  - **Factory engineers** (platform team or engineers generally) improve the factory: skills, context, model mix.
- **Prerequisites:** Someone owns factory quality; it is a real responsibility, not a side task.
- **When to use:** When assigning ownership and planning headcount or time.
- **Example:** A platform engineer spends a sprint tuning skills based on the most common failure patterns.

### 7:51 Demo: Warp Factories

- **Concept:** A factory review dashboard for a factory engineer or manager: how automated the factory is, cycle time (DORA metrics), and spend. Warp shows its own internal development: every engineer's and every automation's runs, with full traces and artifacts preserved. Stored agent behavior is the raw material for improvement. Engineers keep working in existing tools (Slack, Linear or Jira, GitHub PR comments) and all work flows into one place.
- **Prerequisites:** Intake integrations; centralized trace storage.
- **When to use:** When you need org-level visibility into agent work and spend.
- **Example:** Submit a task from Slack or a Linear ticket; review the run's trace and cost from the central view.

### 10:33 Defining the factory in code

- **Concept:** The workflow shown has an orchestrator agent that routes a task to triage, spec, implementation or code review stages. Each stage is an agent definition: secrets, MCP servers, agent prompt, model and more. A repository holds the whole factory at any point in time: agent definitions, automations, benchmarks, where agents run, skills, webhooks.
- **Prerequisites:** A repo and a review process for changes to it.
- **When to use:** Always; this is what makes the factory testable, diffable and agent-editable.
- **Example:** Changing the review agent's model or adding a skill is a PR to the factory repo, reviewable and revertable.

### 12:01 Scoring agent runs

- **Concept:** Besides productivity and spend metrics, set up **scorers** (think online evals): agents look at every run going through the system and use an LLM as judge to decide whether the run was good. Example scorer: agents writing redundant tests, a common coding-agent failure mode. Each failure is an improvement opportunity; a person could grade runs, but agents do it far more efficiently.
- **Prerequisites:** Stored traces; a defined list of failure modes worth scoring.
- **When to use:** Once you have enough runs that manual review no longer covers them.
- **Example:** A scorer that flags "added tests that duplicate existing coverage" and tracks its rate over time.

### 13:21 The self-improvement loop

- **Concept:** Agents look at the failure modes, aggregate them, find patterns, and propose changes to the factory definition so the same failure does not recur. Demo example: "read matching repository skills before implementing", proposed because the system saw that failure 37 times, delivered as a PR to the factory definition. The loop: detect → diagnose → propose fix → human merges.
- **Prerequisites:** Code-defined factory (so fixes are PRs), scoring in place, a human reviewer for factory PRs.
- **When to use:** After scoring has run long enough to show recurring patterns.
- **Example:** Weekly review of agent-proposed factory PRs, merging the ones that address top failure clusters.

### 14:42 Benchmarks on your own tasks

- **Concept:** Add past runs to a benchmark suite, replay them across model configurations, and get a cost-vs-quality trade-off chart on your own tasks (the same kind of chart public benchmarks publish, but on your data). Demo numbers: "GLM53 Flash" was about 93% correct at a cost of $2; "GPT56 Sol" was about 95% correct at roughly three times the cost (model names as heard in the audio; unverified). Use results to build a model routing strategy grounded in your code and stack.
- **Prerequisites:** Replayable tasks with scorers that define "correct".
- **When to use:** When choosing defaults per task type (e.g., frontend vs backend) or reacting to a new model release.
- **Example:** Route routine frontend tasks to the cheaper model and keep the frontier model for hard tasks, if the chart supports it.

### 17:15 The factory stack

- **Concept:** Summary of the layers: everything defined by code; control over data in and out; sandboxed execution; flexible inference; self-improvement driven by benchmark scores; orchestration for multi-step workflows; access from all the tools your team uses.
- **Prerequisites:** The preceding chapters.
- **When to use:** As a build-or-buy checklist for any factory platform, including a home-grown one.
- **Example:** Score a vendor or internal design 0/1 against each layer.

### 17:57 Q&A

- **Concept:**
  - **Verification at scale:** PRs pile up. Develop from specifications so changes can be checked against them, and add computer-use verification that gives user-perspective evidence, which lightens code review.
  - **Budgeting:** track cost per PR, then measure what share goes to evaluation, benchmarking and so on, and extrapolate. The key idea is a measurable, improvable system.
  - **Benchmark data curation:** start by hand-picking small, medium and hard representative tasks; later let the factory mine past sessions for good candidates, since sessions are stored.
  - **Correctness:** everything in the cost-quality chart is LLM-as-judge today; human grading is a sensible addition not yet built. Any scorer defined in the system can serve as a benchmark criterion.
  - **Availability:** Warp Factories is not open source; designed to be open to existing tools; not enterprise-only (small teams and personal projects can try it) but best at about 10+ engineers. Overkill for an individual, who is better served by a Claude Code subscription.
- **Prerequisites:** Specs, scorers, per-PR cost tracking.
- **When to use:** Reference when planning verification, budget and benchmark seeding.
- **Example:** Start with 10 hand-picked tasks (3 easy, 4 medium, 3 hard) and add mined ones later.

## Practical implementation checklist

- [ ] Inventory what local agents can access today (secrets, MCP servers, skills)
- [ ] Define lifecycle stages (triage, spec, implement, review, verify) and human approval points
- [ ] Put agent definitions, skills, MCP config and automations in one git repo
- [ ] Route work in through existing tools (Slack, Linear/Jira, GitHub)
- [ ] Run agents in sandboxes on infrastructure and inference you control
- [ ] Store every run's trace and artifacts centrally
- [ ] Track cost per PR and cycle time
- [ ] Add LLM-judge scorers for your known failure modes
- [ ] Review agent-proposed factory PRs on a regular cadence
- [ ] Build a 10-task benchmark from real past work; rerun on new models
- [ ] Name an owner for factory engineering

## Companion files

- [`claude-code-elephant-goldfish-model-reference.md`](claude-code-elephant-goldfish-model-reference.md)
- [`claude-code-advanced-course-reference.md`](claude-code-advanced-course-reference.md)
- [`claude-code-token-hacks-reference.md`](claude-code-token-hacks-reference.md)
- [`claude-code-limits-optimization-reference.md`](claude-code-limits-optimization-reference.md)

## Notes and caveats

- Terminology and quotes were corrected against a local Whisper (`mlx-community/whisper-large-v3-turbo`) transcription of the audio, which replaced the garbled YouTube auto-captions (e.g. "estimates" → scorers, "launches" → runs, "tools" → harnesses).
- Remaining uncertainty: the benchmark demo model names ("GLM53 Flash", "GPT56 Sol") are as heard and not verified; Whisper writes "Cloud Code" where Claude Code is meant.
- Speaker is a vendor; the principles transfer, but the demo features are Warp Factories-specific and not verified here.
- This is not Claude-specific. It lives in `claude/` as general agent-workflow guidance per the repo routing rules.
