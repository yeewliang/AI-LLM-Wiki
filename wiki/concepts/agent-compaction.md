---
type: concept
title: Agent Compaction
aliases: [context compaction, context compression, compaction strategy]
tags: [agents, context-window, infrastructure, agentic-engineering]
related: [[agent-harness]], [[prompt-cache-stability]], [[claude-code]], [[openclaw]]
created: 2026-05-03
updated: 2026-05-03
---

# Agent Compaction

## What it is
The set of mechanisms an agent harness uses to keep conversation history within the model's context window during long-running sessions. Compaction is necessary because LLMs have no persistent memory between API calls — the full conversation history is resent on every turn. As history grows, the harness must decide what to retain, summarise, or discard.

## How it works
Compaction stacks are layered from cheap to expensive:

**Layer 1 — Per-turn cheap tricks (no LLM call):**
- *Tool-result eviction*: stale or oversized tool results (bash logs, file reads) are dropped from the prompt. [[claude-code]] uses a proprietary `cache_edits` API feature that removes specific tool results from the server-side cached prompt without invalidating the prefix (see [[prompt-cache-stability]]). [[openclaw]] uses a generic `tool-result-context-guard` that truncates any result over half the context window.
- *Sliding window*: oldest middle messages are dropped when context swells. Claude Code calls it "snip"; OpenClaw calls it `limitHistoryTurns` / `pruneHistoryForContextShare`.
- *Tool-pair repair*: after pruning, orphaned `tool_result` messages whose matching `tool_use` was dropped must be removed; Anthropic's API rejects such requests.

**Layer 2 — LLM summarisation:**
The whole conversation (or chunks of it) is passed to an LLM call that produces a structured summary, which replaces the raw history.

- *Trigger strategy*: **reactive** (Claude Code) fires when within 13,000 tokens of the context limit; **preemptive** (OpenClaw) estimates token cost × 1.2 safety margin before every LLM call and routes to the cheapest viable strategy.
- *Summarisation approach*: Claude Code makes a single call with a 20K-token output cap, streamed; the call inherits the parent agent's prompt-cache prefix so it arrives mostly as a cache hit. OpenClaw chunks on tool-call boundaries, summarises each chunk separately, then merges with a final call; supports a separate cheaper model for compaction.
- *Summary schema*: Claude Code demands a 9-section narrative (primary request, key technical concepts, files/code, errors/fixes, problem-solving, all user messages, pending tasks, current work, verbatim next-step quote). OpenClaw demands 5 terse headings (Decisions, Open TODOs, Constraints/Rules, Pending user asks, Exact identifiers) with strict opaque-identifier preservation policy.
- *Audit step*: OpenClaw runs `auditSummaryQuality` after generation — checks required headings present, all identifiers from the last 10 messages survive, latest user ask has token overlap with summary body; regenerates with structured feedback if any check fails. Claude Code has no programmatic verification; trusts the model to follow schema.

**Layer 3 — Memory as compaction substitute:**
[[claude-code]] maintains a per-session markdown file updated throughout the conversation by a sandboxed forked subagent (tool-restricted to `Edit` on one file). When compaction time arrives, if the file is non-empty, it is injected as the post-compact summary and no LLM summarisation call is made. [[openclaw]] uses an append-only memory journal flushed in a pre-compaction turn; after compaction, memory is not auto-injected but comes back lazily via search tools.

**Layer 4 — Failure recovery:**
- Claude Code: circuit breaker after 3 consecutive compaction failures (calibrated against "1,279 sessions with 50+ consecutive failures, wasting ~250K API calls/day globally"); lossy truncation fallback (`[earlier conversation truncated for compaction retry]` marker).
- OpenClaw: snapshots the on-disk session file before attempting; on failure, returns `{ cancel: true }` and continues with the unmodified transcript; progressive fallback: full summary → partial summary → note-only.

## Why it matters
Compaction is where the behaviour of a long-running agent session under pressure is determined. A poorly designed compaction stack causes the agent to behave inconsistently — not with a visible error, but by silently receiving a different conversation context. Cache misses from broken prefix stability don't surface as slower responses; they surface as a *different* assistant. Summary quality failures lose batch-progress state, leading agents to re-execute work already done.

The design choices are consequential and are not standardised across harnesses. Claude Code and OpenClaw — both mature production tools — disagree at every level: reactive vs preemptive trigger, narrative vs structural schema, memory-replaces-summary vs memory-supplements-summary, lossy-on-failure vs snapshot-on-failure. Neither is obviously correct; the right answer depends on session length, user domain, and failure tolerance. See [[2026-05-sausheong-own-your-harness]] for the full comparison.

## Key variants or extensions
- **cachedMicrocompact** (Claude Code): time-based variant of tool-result eviction that clears stale tool results when the user has been idle >60 minutes; at that point the server-side cache has expired anyway, so there is no cache cost.
- **Chunked summarisation** (OpenClaw): splits on tool-call boundaries so `tool_use`/`tool_result` pairs are never separated; N+1 LLM calls but supports cheaper-model routing for the compaction calls.
- **Dreaming** ([[openclaw]]): opt-in background pass that promotes daily memory notes to durable long-term memory via Light/Deep/REM phases; complements compaction by reducing what must be in the context window at all.

## Limitations and open questions
- Optimal threshold values (trigger margin, output cap, retry budgets) are calibrated against production telemetry; published values reflect the vendor's fleet, not yours.
- Verbatim-quote anchoring in Claude Code's summarisation prompt is an empirical fix for model drift post-compaction; the underlying drift is a model behaviour, not a harness bug.
- Session memory as compaction substitute requires the memory file to be incrementally maintained throughout the session — any crash or missed update degrades compaction quality silently.

## Key sources
- [[2026-05-sausheong-own-your-harness]] — Detailed compaction comparison; primary source for this concept
- [[2026-05-sausheong-dissecting-open-claw]] — OpenClaw ContextEngine interface and hook-point architecture
