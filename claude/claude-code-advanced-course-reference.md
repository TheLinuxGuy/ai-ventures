# Claude Code Advanced Course Reference

Source video: https://www.youtube.com/watch?v=UPtmKh1vMN8

## Purpose of this guide

This file converts the full 3-hour advanced course into a structured reference you can use while working. It is organized by chapter, and each chapter includes:
- What the concept means
- Prerequisites
- When to use it
- Practical examples

## Video metadata

- Title: CLAUDE CODE ADVANCED COURSE — 3 HOURS
- Creator: Nick Saraev
- Duration: 3:18:23
- Published: 2026-03-28

## Global prerequisites

- Comfortable with Claude Code basics (prompts, project context, normal edit-run-debug loop)
- Familiar with terminal workflows and git basics
- A project folder structure where notes, tasks, and decisions are saved consistently
- Basic understanding of AI variability (same prompt can produce different outputs)

## Official docs to keep open while using this guide

- Claude Code docs hub: https://docs.anthropic.com/en/docs/claude-code
- Slash commands: https://docs.anthropic.com/en/docs/claude-code/slash-commands
- Settings: https://docs.anthropic.com/en/docs/claude-code/settings
- Hooks: https://docs.anthropic.com/en/docs/claude-code/hooks
- Skills: https://docs.anthropic.com/en/docs/claude-code/skills
- Sub-agents: https://docs.anthropic.com/en/docs/claude-code/sub-agents
- MCP overview: https://docs.anthropic.com/en/docs/mcp

## Overlap with existing 9 hacks notes

This course overlaps heavily with the quick tips in [claude/README.md](claude/README.md):
- Skills and Skill Creator strategy
- Sub-agents and team parallelization
- Context management patterns
- Workflow and organization discipline

How they differ:
- The quick tips file is tactical and fast to scan.
- This course file is strategic and chapter-complete.

Recommended usage:
1. Use the quick tips for daily execution.
2. Use this course file for design decisions, team workflow setup, and process upgrades.

## Chapter-by-chapter reference

### 0:00 Introduction to the Claude Code Advanced Course

- Concept:
  - The course scope is beyond beginner usage and focuses on systems, scale, and reliability.
- Prerequisites:
  - Basic Claude Code proficiency.
- When to use:
  - At the start of a new phase where your workflows need to mature.
- Example:
  - Move from ad-hoc prompting to explicit process: planning, execution, review, and archival.

### 0:57 Advanced System Prompts and CLAUDE.md

- Concept:
  - Persistent instruction quality drives output quality more than one-off clever prompts.
  - CLAUDE.md acts as a stable behavior contract for project context and conventions.
- Prerequisites:
  - Clear project standards (coding style, review criteria, deployment constraints).
- When to use:
  - Any project that lasts more than a few sessions.
- Example:
  - Add explicit constraints in CLAUDE.md for testing expectations, migration safety, and output format.

### 9:03 Optimizing Workspace Organization

- Concept:
  - Better folder and note structure reduces context loss and repeated explanations.
- Prerequisites:
  - Agreement on where docs, stories, architecture, and operations notes live.
- When to use:
  - Before scaling project complexity or adding collaborators.
- Example:
  - Keep architecture, stories, and runbooks in stable paths and reference them in prompts.

### 13:57 Planning Features with Claude Code

- Concept:
  - Strong planning prompts reduce rework and improve implementation speed.
- Prerequisites:
  - Defined scope, success criteria, and non-goals.
- When to use:
  - Before coding any medium or large change.
- Example:
  - Ask for implementation plan plus risk list and rollback notes before first edit.

### 17:30 Workflow Management and Learning Loop

- Concept:
  - Treat every task as feedback data: what worked, what failed, what changed.
- Prerequisites:
  - A place to store lessons learned.
- When to use:
  - Continuously during active development.
- Example:
  - After each major task, capture one improvement to prompts, context files, or tooling.

### 17:53 Starting a New Project

- Concept:
  - Early setup quality determines long-term productivity.
- Prerequisites:
  - Project objective, tool constraints, and default architecture preferences.
- When to use:
  - Day zero of a new repository.
- Example:
  - Scaffold docs first: product goals, architecture notes, and operational guardrails.

### 26:47 Utilizing Agent Harnesses

- Concept:
  - Harnesses package a repeatable agent workflow for consistent outputs.
- Prerequisites:
  - Repeated task pattern worth standardizing.
- When to use:
  - For recurring tasks like reviews, migrations, release notes, and refactors.
- Example:
  - Build a harness that always returns severity-ranked findings and missing tests.

### 34:28 Understanding Parallelization Techniques

- Concept:
  - Parallel work improves speed when tasks are independent and mergeable.
- Prerequisites:
  - Clear subtask boundaries and merge strategy.
- When to use:
  - Multi-part tasks (research, code changes, test planning) that can run independently.
- Example:
  - Run architecture analysis and test strategy in parallel, then synthesize.

### 42:07 Exploring Stochastic Consensus and Debate

- Concept:
  - Multiple independent model passes can improve confidence via agreement patterns.
- Prerequisites:
  - A scoring or comparison method for candidate outputs.
- When to use:
  - High-stakes decisions where one-shot output is risky.
- Example:
  - Generate three solution variants, compare failure modes, and adopt the strongest hybrid.

### 58:09 Multi-Agent Consensus for Problem Solving

- Concept:
  - Assign specialized roles to agents and converge on a decision.
- Prerequisites:
  - Role definitions and explicit convergence criteria.
- When to use:
  - Complex technical decisions with competing tradeoffs.
- Example:
  - One agent focuses on performance, one on security, one on maintainability, then consolidate.

### 1:06:12 AI-Powered Cooking Innovations

- Concept:
  - Demonstrates transferability: the same agentic patterns can solve non-coding domains.
- Prerequisites:
  - Problem framing and structured constraints.
- When to use:
  - Cross-domain experimentation or personal knowledge workflows.
- Example:
  - Build a constrained meal-planning assistant using the same planning-consensus pattern.

### 1:07:32 Model-Chat: A New Approach

- Concept:
  - Different models can be used as complementary perspectives.
- Prerequisites:
  - Access to multiple models and criteria for routing tasks.
- When to use:
  - When one model is weak on a specific task type.
- Example:
  - Use one model for ideation and another for strict implementation validation.

### 1:09:17 Exploring Algorithmic Art

- Concept:
  - Creative domains still benefit from structured prompt and iteration systems.
- Prerequisites:
  - Quality criteria, style constraints, and iteration loop.
- When to use:
  - Design, concepting, or content generation tasks.
- Example:
  - Use staged prompts: concept pass, critique pass, refinement pass.

### 1:11:35 Streamlining Agent Teams

- Concept:
  - Teams of agents work best when roles, interfaces, and handoff formats are explicit.
- Prerequisites:
  - Shared task template and result schema.
- When to use:
  - Large initiatives where single-agent linear flow becomes slow.
- Example:
  - Define output schema for each role so merged results are consistent.

### 1:16:58 The Pipeline Concept

- Concept:
  - Pipeline design breaks work into repeatable, testable stages.
- Prerequisites:
  - Stage boundaries and acceptance criteria.
- When to use:
  - Work that repeats often and can be decomposed.
- Example:
  - Pipeline stages: intake, planning, implementation, validation, publish.

### 1:21:36 Skills vs. Subagents

- Concept:
  - Skills capture reusable instructions; sub-agents split execution across roles.
- Prerequisites:
  - Understanding of repeatability versus parallel specialization.
- When to use:
  - Skills: repeated task format.
  - Sub-agents: simultaneous specialist execution.
- Example:
  - Use a review skill inside each specialist sub-agent role.

### 1:22:58 Organizational Hierarchies in AI

- Concept:
  - Hierarchical orchestration improves control in large, multi-step efforts.
- Prerequisites:
  - Parent-child responsibility model and escalation rules.
- When to use:
  - Projects requiring multiple layers of delegation.
- Example:
  - Lead agent sets goals, worker agents execute, verifier agent audits outputs.

### 1:29:26 Introduction to Auto-Research

- Concept:
  - Auto-research is a continuous loop of hypothesis, retrieval, synthesis, and refinement.
- Prerequisites:
  - Research objective and source-quality criteria.
- When to use:
  - Open-ended problem spaces where understanding evolves over time.
- Example:
  - Ongoing competitor intelligence with periodic summary updates.

### 1:32:03 Setting Up Auto-Research

- Concept:
  - Setup quality determines signal-to-noise and repeatability.
- Prerequisites:
  - Data sources, cadence, and output templates.
- When to use:
  - Before starting long-running research loops.
- Example:
  - Define source list, update frequency, and summary structure before first run.

### 1:42:45 Key Components for Auto-Research

- Concept:
  - Core components include retrieval quality, synthesis logic, and memory of prior findings.
- Prerequisites:
  - Stable storage for notes and decision history.
- When to use:
  - During system design for research workflows.
- Example:
  - Keep dated research snapshots and compare deltas between cycles.

### 1:48:43 Applications of Auto-Research

- Concept:
  - Research loops can power strategy, product discovery, and operations.
- Prerequisites:
  - Defined business or technical objective.
- When to use:
  - Problems requiring continuous external signal monitoring.
- Example:
  - Track ecosystem changes and trigger architecture review notes.

### 1:53:35 HTTP Requests and Internet Automation

- Concept:
  - Programmatic web access enables repeatable data retrieval and integrations.
- Prerequisites:
  - API understanding, auth strategy, and rate-limit awareness.
- When to use:
  - Any repeatable workflow that depends on external web data.
- Example:
  - Pull structured data from APIs and summarize changes daily.

### 1:55:29 Browser Automation Explained

- Concept:
  - Browser automation is needed when APIs are unavailable or incomplete.
- Prerequisites:
  - Tool choice, legal/terms review, and selector reliability strategy.
- When to use:
  - Dynamic web workflows requiring true browser interaction.
- Example:
  - Automate repetitive portal actions and collect artifacts for review.

### 2:00:10 Advanced Browser Automation Techniques

- Concept:
  - Advanced patterns improve robustness under dynamic UI and anti-fragile operation.
- Prerequisites:
  - Retry policy, failure handling, and observability.
- When to use:
  - Complex flows with many conditional states.
- Example:
  - Add fallback selectors, retries, and verification screenshots at each step.

### 2:07:51 Navigating CloudCode Performance Fluctuations

- Concept:
  - Runtime/model performance can vary; process should adapt.
- Prerequisites:
  - Monitoring signals and fallback procedures.
- When to use:
  - When quality or latency changes during critical work.
- Example:
  - Switch to smaller scoped tasks, clear context, and route to alternate model if needed.

### 2:12:54 Diversifying Your Models

- Concept:
  - Model portfolio strategy reduces single-model risk and improves fit-by-task.
- Prerequisites:
  - Task classification and benchmark prompts.
- When to use:
  - Teams with varied workloads (analysis, coding, summarization, ideation).
- Example:
  - Maintain a routing matrix: which model to use for which task type.

### 2:24:17 Organizing Your Workspace

- Concept:
  - Workspace architecture should support personal work, business contexts, and client isolation.
- Prerequisites:
  - Naming standards, folder templates, and data separation policy.
- When to use:
  - During workspace redesign or portfolio expansion.
- Example:
  - Separate client-specific policies and memory notes from shared global templates.

### 2:39:16 Understanding Security Concerns

- Concept:
  - Security posture is essential as automation autonomy increases.
- Prerequisites:
  - Threat model, access boundaries, and auditing expectations.
- When to use:
  - Before enabling broad tool permissions or auto modes.
- Example:
  - Restrict high-risk commands and require explicit review for destructive operations.

### 3:00:28 The Future of Claude and Agentic Engineering

- Concept:
  - The ecosystem is moving toward orchestrated, multi-agent, workflow-native engineering.
- Prerequisites:
  - Openness to continuous process iteration.
- When to use:
  - Strategic planning for tooling and team workflow evolution.
- Example:
  - Revisit your agent architecture quarterly and retire patterns that no longer scale.

## Practical implementation checklist

1. Keep CLAUDE.md and project instructions current and concise.
2. Add one repeatable harness or skill for your highest-frequency task.
3. Define one safe parallelization pattern for independent subtasks.
4. Add a research loop note template for ongoing discovery topics.
5. Create a model routing matrix and review monthly.
6. Enforce security guardrails before increasing automation autonomy.

## Suggested companion files in this repository

- Quick tactics: [claude/README.md](claude/README.md)
- Shared cross-device settings: [claude/settings.json](claude/settings.json)

## Notes

- This guide is based on full transcript and chapter extraction from the source video.
- Commands and feature availability can evolve; verify current behavior in official docs.
