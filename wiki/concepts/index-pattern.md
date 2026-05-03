---
type: concept
title: Index Pattern
aliases: [lightweight index injection, demand-loading skills]
tags: [agents, agent-harness, prompt-cache-stability, cost-optimisation]
related: [[prompt-cache-stability]], [[agent-harness]], [[skills-as-markdown]], [[agent-compaction]], [[felix-agent]]
created: 2026-05-03
updated: 2026-05-03
---

# Index Pattern

## What it is
An agent design pattern in which the context injected into every prompt is a lightweight index of available capabilities (names, tags, one-line descriptions) rather than the full content of those capabilities. When the model determines it needs a specific skill, memory, or document, it calls a dedicated load-tool to fetch the full content on demand. Demand drives retrieval; the model's judgment replaces speculative pre-injection.

## How it works
**Conventional approach (inject-everything):**
On each turn, the harness retrieves potentially relevant memories, skill instructions, and reference documents and injects full content into the prompt. The retrieval heuristic is speculative — content is included because it *might* be needed.

**Index pattern:**
On each turn, the harness injects only an index: a compact list of available capabilities with names and one-line descriptions. If the model determines it needs the Apple Reminders skill, it calls `load_skill("apple-reminders")` and receives the full markdown document. If it determines a memory about a prior conversation is relevant, it calls `memory_search("project X")` and receives the matching entries.

The model's own judgment is the retrieval mechanism. Speculative injection is replaced by explicit demand.

**Savings:**
- [[felix-agent]] trims approximately 5–15 KB of speculative content from every prompt by switching from inject-everything to the index pattern
- This keeps the prompt prefix structure stable across turns regardless of which capabilities are available, enabling [[prompt-cache-stability]]
- Hosted providers charge approximately 10× less for cached prefix tokens; inconsistent prompt construction "quietly costs money every turn" and "five or ten times higher than it needed to be" at scale

## Why it matters
The index pattern has two compounding effects:

**1. Cost reduction**: Reducing per-prompt token volume directly reduces API cost. At the prefix-cache boundary, consistent prompt structure can produce a 10× cost reduction for the tokens in the cached portion.

**2. Cache stability**: The prompt structure stays consistent turn-to-turn because the index is small and deterministic, while full content varies based on what skills are installed or what memories exist. A stable prefix enables the provider's prompt cache to function correctly — see [[prompt-cache-stability]].

**3. Latency reduction**: Fewer tokens per prompt means faster time-to-first-token, especially for providers that charge for input processing.

The pattern also makes the system more predictable: the model decides what to load rather than the harness guessing what to include. Decisions are auditable in the session log as explicit tool calls.

## Key variants or extensions
- **Two-tier memory** ([[openclaw]], [[felix-agent]]): keyword search runs always-on for exact term matching; knowledge-graph/vector search runs on demand. The index pattern applies to both — neither pre-loads full content speculatively.
- **Tool schema lazy loading** ([[claude-code]]): analogous pattern for tool schemas — at 50 tools without lazy loading, tool schemas consume 10–20K tokens/turn; lazy loading via tool search reduces this by ~85%. Same principle: inject a searchable index, load schemas on demand.
- **Skill registry index** ([[openclaw]]): ClawHub's embedding-based skill search is the discovery mechanism for the index layer; the skill is installed locally only when the user (or agent) selects it.

## Limitations and open questions
- **Extra round trips**: demand-loading adds tool calls and model turns. If the model frequently needs capabilities it didn't know to pre-load, this can increase total latency compared to inject-everything.
- **Discovery quality**: the model's ability to identify the right capability from a one-line description varies by skill name clarity and description quality. Poor index entries lead to missed or wrong tool selection.
- **Cold sessions**: on the first turn of a new session, the model has no prior context to guide selection; it may load unnecessarily or miss needed capabilities without speculative injection to scaffold it.

## Key sources
- [[2026-05-sausheong-felix-agent]] — Primary source; index pattern as Felix design principle; prompt-cache economics motivation
- [[2026-05-sausheong-dissecting-open-claw]] — Skills-index in OpenClaw; ClawHub search
