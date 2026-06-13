---
type: concept
title: Harness Engineering
aliases: [harness engineering, constraint-system engineering]
tags: [agentic-engineering, workflow, constraints, software-engineering, architecture]
related: [[agent-harness]], [[agentic-engineering]], [[vibe-coding]], [[supervisory-engineering]], [[ralph-loop]], [[five-levels-of-ai-engineering]], [[claude-code-configuration]]
created: 2026-06-13
updated: 2026-06-13
---

# Harness Engineering

## What it is
A discipline of AI-assisted software development in which the engineer's primary output is not code but the **environment that lets agents work reliably** — the constraint system: AGENTS.md, architecture rules, custom linters, and feedback paths. It is the mature successor to [[vibe-coding]] in the progression Prompt Engineering → Vibe Coding → Harness Engineering. Where vibe coding produces artefacts directly, harness engineering produces the [[agent-harness]] and surrounding constraints that make agent output trustworthy at scale.

> [synthesis] Distinct from [[agent-harness]] (the technical artefact — system prompt + context management + tool use + evaluation loop) and from [[agentic-engineering]] (multi-step agent execution under human direction). Harness engineering is the *practice* of designing and maintaining that artefact and its constraints. The three are nested: a harness engineer builds the harness so that agentic engineering is reliable.

## How it works
The core shift: the engineer's deliverable becomes a **constraint system** rather than a program. This rests on six principles (Martin Fowler / OpenAI framing):

1. **Repo as System of Record** — Anything not in the repo does not exist to the agent. Slack threads, verbal consensus, and architectural decisions held only in your head are invisible. Every decision, convention, and plan must be committed to the repo, not re-narrated each session.
2. **Map, Not Manual** — Provide an entry point, not a complete handbook. AGENTS.md is a table of contents pointing to deeper detail files.
3. **Mechanical Enforcement** — Docs rot; lint rules don't. Promote conventions to enforced rules so violations fail automatically rather than relying on human memory.
4. **Agent Readability** — Documents are optimised for agent reasoning speed, not human reading flow.
5. **Entropy & Garbage Collection** — Agents reproduce the patterns in the repo, *including bad ones*. Technical debt pollutes the agent's in-context learning, so periodic scanning and cleanup of drift and violations is required maintenance.
6. **Throughput Changes Merge** — High agent throughput makes PRs short-lived; intermittent failures are solved by re-running rather than careful manual diagnosis.

The three most load-bearing in practice are **Repo as System of Record**, **Mechanical Enforcement**, and **Entropy & Garbage Collection**.

Operationally this maps to three layers (OpenAI framing):
- **Context engineering** — a continuously enhanced knowledge base inside the codebase, plus agent access to dynamic context (observability data, browser navigation).
- **Architectural constraints** — monitored not only by LLM agents but by deterministic custom linters and structural tests.
- **Garbage collection** — agents that run periodically to find documentation inconsistencies or constraint violations, fighting entropy and decay.

## Why it matters
It reframes the failure mode practitioners hit on production codebases. When an agent "keeps messing things up," maintenance keeps getting harder, or every session needs re-briefing, the diagnosis is not a weak prompt but a broken environment. The cited evidence (OpenAI engineer [[ryan-lopopolo]], Feb 2026): a 3-person team produced ~1M lines of code and 1,500+ PRs over 5 months — "no special model, no secret prompt" — by changing their working method to harness engineering.

This generalises the [[agentic-engineering]] "configuration stack" into a stance: you do not need a better prompt, you need a better environment that you design. It is the engineering-practice complement to the build-vs-buy [[agent-harness]] argument.

## Three tests of a good constraint
A constraint is worth promoting to a rule only if it passes:

1. **Machine-verifiable** — checkable by lint or CI, not human review. If you cannot describe how a program would check the rule, it is a suggestion, not a rule.
2. **Embedded fix instruction** — the error message is written for the agent, not the human:
   - ❌ `Error: import violation`
   - ✅ `LINT ERROR: core/user.py directly imports infra/db. Use the UserRepo interface in core/ports.py.`
   The second lets the agent read and self-correct without human intervention.
3. **Progressive disclosure** — AGENTS.md is a ~100-line index pointing to deeper detail files, not an encyclopaedia. Giant instruction files have three failure modes: they blow out the context window, get forgotten quickly, and cannot be mechanically verified. (Mirrors the [[index-pattern]].)

## Key variants or extensions
- **Ralph mode** — the [[ralph-loop]]: an autonomous loop that clears context each iteration, reads a PRD, does one task, and commits, until all tasks complete. Its six tenets map directly onto the harness-engineering principles; clean-context-per-iteration is the same idea as Repo as System of Record.
- **Memory layer** — a persistent in-repo knowledge base agents read and write (cf. the per-agent memory in [[felix-agent]]).
- **Custom linters as constraints** — deterministic structural tests encoding architecture rules (e.g. "core layer must not import infra").

## Limitations and open questions
- **Constraint authoring cost** — writing machine-verifiable rules with embedded fix instructions is real engineering work; the payoff depends on agent throughput high enough to amortise it.
- **Over-constraint risk** — too many rules can over-fit the agent to current patterns and suppress good deviations; the boundary between healthy enforcement and ossification is unsettled.
- **Garbage collection reliability** — using agents to police entropy assumes the policing agents themselves resist the entropy they detect; effectiveness over long horizons is unproven.
- **Framing overlap** — "harness engineering" (Fowler/OpenAI), Karpathy's three phases, and Shapiro's [[five-levels-of-ai-engineering]] are competing maps of the same transition; none is canonical.

## Key sources
- [[2026-05-harness-engineering-next-upgrade]] — Chinese-language synthesis defining the six principles and three constraint tests; source of the Lopopolo case study and Ralph mapping
- [[2026-05-sausheong-own-your-harness]] — Complementary "own your harness" argument; engine-vs-vehicle framing for [[agent-harness]]
