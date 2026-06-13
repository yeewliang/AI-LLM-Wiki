---
type: concept
title: Agent Harness
aliases: [agent runtime, agent scaffold]
tags: [agents, infrastructure, agentic-engineering, architecture]
related: [[agentic-engineering]], [[harness-engineering]], [[agent-compaction]], [[prompt-cache-stability]], [[index-pattern]], [[model-context-protocol]], [[claude-code]], [[openclaw]], [[felix-agent]], [[martin-fowler]]
created: 2026-05-03
updated: 2026-06-13
---

# Agent Harness

## What it is
The software layer surrounding an LLM in an agent system that owns context management, tool routing, execution lifecycle, session identity, and integration with external services. The harness is distinct from the model: it determines how and when the model is called, what context it receives, what tools it may invoke, and how failures are handled.

> [synthesis] Apt framing from [[sausheong-chang]]: "The model is the engine, but the harness is the vehicle."

[[martin-fowler]]'s team gives a component-level definition that promotes the harness from a block of text to a designable, versionable, evaluable object:
> harness = system prompt + Context Management + Tool Use + Evaluation Loop

All four are required; missing any one leaves the agent unbounded on that dimension. The practice of designing and maintaining the harness and its surrounding constraints is [[harness-engineering]].

## How it works
A harness wraps each model interaction with at minimum:
- **Context assembly**: selecting, ordering, and truncating conversation history and system prompt before each turn
- **Tool routing**: presenting available tools to the model; routing tool calls to implementations; validating results
- **Compaction**: managing context window overflow — see [[agent-compaction]]
- **Session state**: persisting conversation history, memory, and intermediate state across turns and restarts
- **Provider abstraction**: routing requests to LLM providers; handling failover, auth rotation, rate limits

In more capable harnesses, additional layers include:
- **Prompt-cache management**: constructing prompts to maximise prefix reuse (see [[prompt-cache-stability]])
- **Subagent orchestration**: spawning parallel or sequential child agents with restricted tool permissions
- **Hooks**: deterministic pre/post-action callbacks that overlay the probabilistic model output
- **Cron/scheduled execution**: isolated agent invocations on timers with separate session identities
- **Security and sandboxing**: containing risky tool execution; permission allowlisting

Examples of full harnesses: [[claude-code]], [[openclaw]], [[felix-agent]].

## Why it matters
The harness is where agent behaviour under production conditions is actually determined. Every major AI lab has made this shift as of 2026:
- OpenAI: Agents SDK + Frontier (agent lifecycle management)
- Anthropic: domain-specific harnesses (Claude Code, Claude Cowork, Claude Design)
- Microsoft: Agent 365 (identity, governance, orchestration for Copilot)
- Google: Gemini Enterprise Agent Platform (Cloud Next 2026)
- xAI: acquired Cursor — buying workflow + developer execution loop, i.e., buying a harness

The harness contains decisions that are not documented in READMEs and not derivable from the model's capabilities: when to compact, what schema to use for summaries, how to handle compaction failures, how to route between providers, what to do when a tool times out. Two production agents built on the same underlying model can behave very differently because their harnesses make opposite choices at every one of these points. See [[2026-05-sausheong-own-your-harness]] for a detailed comparison of [[claude-code]] and [[openclaw]] compaction stacks.

The harness is also the calibration layer. Decisions are tuned against production telemetry from the harness's own user base. Buying someone else's harness means inheriting calibration for their users and their failure modes, not yours.

## Key variants or extensions
- **Thin harness**: minimal wrapper that defers most decisions to the model; higher model dependence; simpler to build; breaks more at edge cases. Claude Code was described by its creator as "the thinnest possible wrapper" — the compaction stack alone has 8 distinct mechanisms, suggesting "thin" is relative.
- **Domain-specific harness**: tuned for a specific work domain (coding, document drafting, data analysis); fewer generalist trade-offs; Claude Code vs Claude Cowork distinction.
- **Self-built harness**: purpose-built for one team's domain; highest fit; highest build cost; only viable if the domain is well-understood and the harness is maintained. [[felix-agent]] is an extreme example: built for a single person's personal workflow.
- **Platform harness**: harness as shared infrastructure across an organisation, encoding governance and compliance (see [[platform-as-trojan-horse]]).

## Limitations and open questions
- **Build-vs-buy**: For most teams, building a harness from scratch is not justified early. Wrapping a third-party SDK (as [[openclaw]] wraps `pi-coding-agent`) is a reasonable start. The question is when to diverge — typically when production behaviour diverges from the upstream's defaults.
- **Calibration opacity**: Even open-source harnesses do not document the reasoning behind threshold values, retry budgets, or summarisation schemas. Only telemetry over your own workload reveals whether inherited values fit.
- **Harness lock-in**: As agents accumulate session memory, compaction format choices, and tool permission structures, migrating to a different harness becomes a data migration problem, not just a code swap.

## Key sources
- [[2026-05-sausheong-own-your-harness]] — Compaction comparison between Claude Code and OpenClaw; primary argument for owning the harness
- [[2026-05-sausheong-dissecting-open-claw]] — Detailed architectural read of OpenClaw as a harness
- [[2026-05-sausheong-felix-agent]] — First-person design rationale for a self-built harness
