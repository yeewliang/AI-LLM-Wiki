---
type: concept
title: Agentic Engineering
aliases: [agent-driven engineering, AI coding agents]
tags: [llm, agents, workflow, software-engineering]
related: [[vibe-coding]], [[supervisory-engineering]], [[five-levels-of-ai-engineering]], [[claude-code]], [[platform-as-trojan-horse]]
created: 2026-05-02
updated: 2026-05-02
---

# Agentic Engineering

## What it is
Software engineering in which an LLM-powered agent executes multi-step, multi-file tasks across a codebase — planning, reading, editing, running tests, opening pull requests — under human direction. Sits at Levels 2–3 of the [[five-levels-of-ai-engineering]]: above "spicy autocomplete" (Level 1), below fully autonomous and collaborative agent networks (Levels 4–5). Distinguished from [[vibe-coding]] by scope (whole tasks, not single completions) and from autonomous development by the requirement of human-in-the-loop direction and review.

## How it works
A developer states a task — typically at the level of a feature, bug fix, or refactor. An agent (e.g. [[claude-code]], Cursor, Windsurf) plans the change, navigates the codebase, edits multiple files, runs tests, and surfaces a diff for review. Effective agentic engineering depends on a *configuration stack* rather than prompt skill alone:

- A short imperative project memory file (e.g. CLAUDE.md) defining conventions and guardrails.
- Path-scoped rules loaded only when matching files are touched.
- Plan mode separating exploration from mutation.
- Subagents with restricted tool allowlists for review and exploration.
- Skills packaging repeatable workflows.
- Hooks adding deterministic guardrails over the probabilistic agent.
- A small set of MCP servers (filesystem, code graph, version control, documentation, web) — not many, since tool schemas consume context tokens on every turn.

The human role shifts toward [[supervisory-engineering]]: specification, review, judgement on what to delegate, and out-of-band approval of risky operations.

## Why it matters
Agentic engineering is where most engineering organisations are currently transitioning (Level 2 → Level 3). It inverts the historical software bottleneck: when an agent can produce a working prototype overnight, *deciding what to build and whether it is right* becomes the critical path. Procurement, security review, change-approval chains, and committee-based governance — all designed assuming building took longer than deciding — become the dominant cost.

For organisations operating at scale, agentic engineering forces investment in [[platform-as-trojan-horse]] infrastructure (governance, code classification, automated review, deployment guardrails) because policy-only enforcement fails when machines generate code faster than humans can review it.

## Key variants or extensions
- **Headless / non-interactive mode**: Agents run unattended in CI pipelines (e.g. nightly evaluation jobs) with whitelisted tools, deferred-permission hooks for risky operations, and out-of-band human approval to resume.
- **Parallel worktrees**: Independent agent sessions in separate git worktrees, each with isolated context, run concurrently on distinct task slices.
- **Tiered code review**: Review rigour is calibrated to rebuild cost × failure impact rather than applied uniformly; specification review and formal verification replace line-by-line review on high-risk paths.
- **Solo-to-scale team model**: A single individual reaches validated proof-of-value with agents before any team is formed; team scales to match validated demand instead of anticipated demand.

## Limitations and open questions
- **Brownfield risk**: Agents generate syntactically correct code without understanding hidden coupling, production quirks, or tribal knowledge. AI maturity is gated by *system* maturity (observability, dependency mapping).
- **Abstraction erosion**: When engineers stop reading, debugging, and designing because the agent does, they lose the muscle memory and intuition that detect subtle wrongness. Productive but brittle teams.
- **Senior adoption resistance**: Senior engineers tend to slot agents into existing workflows (the "C-in-Java-syntax" pattern) rather than restructure around them, then conclude the tools are overhyped.
- **Cognitive load of supervision**: Managing multiple agents in parallel fragments attention; burnout risk under-acknowledged.
- **Liability ambiguity**: When an AI-generated change causes a vulnerability, the assignment of responsibility (developer who approved, organisation that deployed, vendor that supplied the model) is unsettled and constrains adoption in regulated contexts.
- **Transitional, not terminal**: Agent swarms, orchestration, and collaborative agent networks (Levels 4–5) are the next phase; agentic engineering is explicitly a way station.

## Key sources
- [[2026-05-sausheong-vibe-to-agentic]] — Practitioner account from [[govtech-singapore]] mapping the shift, organisational consequences, and platform response
- [[2026-05-sausheong-agentic-in-the-wild]] — Quantified case studies: 8–12× (solo engineer, 2 products in 2 weeks), 15–22× (2 data scientists, 30+ full-stack apps), 30× (per-showcase multiplier); role-boundary dissolution in practice; Prelude architectural detail
