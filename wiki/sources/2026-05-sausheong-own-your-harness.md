---
type: source
title: "Own Your Harness: What Compaction in Claude Code and OpenClaw Says About Agent Infrastructure"
author: [[sausheong-chang]]
date: 2026-05-03
url: https://sausheong.com
ingested: 2026-05-03
tags: [agent-harness, agent-compaction, claude-code, openclaw, prompt-cache-stability]
---

# Own Your Harness: What Compaction in Claude Code and OpenClaw Says About Agent Infrastructure

## Core argument
Compaction strategy — one slice of agent harness design — demonstrates that two well-engineered production agents have built nearly opposite stacks at every level. The invisible scaffolding that determines agent behaviour under pressure cannot be derived from model choice or README documentation. Buying your harness off the shelf means inheriting someone else's calibration for their users and their domain; you forfeit the telemetry needed to improve it for yours.

## Key concepts introduced or used
- [[agent-compaction]] — The complete mechanism: cheap per-turn tricks (cache_edits, sliding window, tool-result truncation) → LLM summarisation → memory-as-compaction-substitute → failure recovery; reactive vs preemptive trigger strategies
- [[agent-harness]] — Framed as the "vehicle" to the model's "engine"; owns context, tools, execution, identity; the actual competitive battleground
- [[prompt-cache-stability]] — `cache_edits` (Claude Code private API) as the only mechanism that evicts tool results without invalidating the prefix; prompt prefix correctness as cost variable
- [[openclaw]] — Compaction stack: preemptive, token-estimation every turn, chunked summarisation, audit loop, snapshot-and-cancel recovery
- [[claude-code]] — Compaction stack: reactive (13K-token margin trigger), `cachedMicrocompact`, forked-agent cache-warm summarisation, circuit breaker calibrated on production telemetry

## Notable claims or data points
**Harness context:**
- OpenAI: workspace agents + Agents SDK + Frontier (agent lifecycle management)
- Anthropic: domain-specific harnesses (Claude Code, Claude Cowork, Claude Design)
- Microsoft: Copilot as system layer with Agent 365 (identity, governance, lifecycle)
- Google: Gemini Enterprise Agent Platform (Cloud Next 2026)
- xAI: acquiring Cursor — "effectively buying workflow, distribution, and a developer execution loop"
- Boris Cherny (built Claude Code): called it "the thinnest possible wrapper over the model" — but the actual compaction stack has 8 distinct mechanisms, a sandboxed forked subagent for session memory, and a circuit breaker calibrated on production logs

**Reactive vs preemptive:**
- Claude Code: fires when within 13,000 tokens of context window; fallback catches API `prompt_too_long` 413 error
- OpenClaw: estimates token cost × 1.2 safety margin before *every* LLM call; routes to `truncate_tool_results_only` / `compact_only` / `compact_then_truncate`; hard `transformContext` guard at 90% window

**Cheap per-turn mechanisms:**
- Claude Code `cachedMicrocompact`: beta `cache_edits` API feature — tells server to delete specific tool results from cached prompt without invalidating prefix; allowlisted tools: Read, Bash, Grep, Glob, Edit, Write, WebSearch, WebFetch; time-based variant clears stale tool results after 60min idle (server cache cold-expired anyway)
- OpenClaw `tool-result-context-guard`: shrinks any tool result >50% of window; throws overflow at >90% total; coarser, but provider-agnostic
- Both: sliding-window drop of middle messages; Claude Code calls it "snip", OpenClaw `limitHistoryTurns` + `pruneHistoryForContextShare`
- OpenClaw: "tool-pair repair" removes orphaned `tool_result` blocks after pruning (Anthropic API rejects requests with `tool_result` whose matching `tool_use` was dropped); Claude Code doesn't need this because `cache_edits` doesn't leave orphans

**LLM summarisation:**
- Claude Code: single call, whole conversation in, 20K-token output cap (sized for p99.99 of historical compact lengths ~17,387 tokens); streamed; runs via `runForkedAgent` inheriting parent's prompt-cache prefix → mostly cache hit; no separate cheaper-model option
- OpenClaw: delegated to `pi-coding-agent` SDK; can use separate cheaper model; when too big, splits on tool-call boundaries (tool_use+tool_result stay together), summarises each chunk, merges with a final call; merge prompt explicitly calls out "5/17 items completed" style batch progress as must-preserve
- OpenClaw audit step: `auditSummaryQuality` checks all 5 required section headings appear in order; every identifier from last 10 messages survives in summary; latest user ask token-overlaps with body; if fails → regenerate with structured feedback (`missing_section: ## Decisions`, `missing_identifiers: abc123`)

**Session memory as compaction substitute (Claude Code):**
- `~10-section markdown file updated by a sandboxed forked subagent; tool permissions: Edit on this one file only
- Updates fire on token thresholds (10K to initialise, 5K between) + tool-call thresholds (3 calls between)
- If file exists at compaction time → injected as post-compact summary user message → no LLM summarisation call made

**Session memory as pre-compaction journal (OpenClaw):**
- Append-only journal; indexed in SQLite+FTS5+embeddings; writes during "memory flush" turn just before compaction (tool-restricted, append-only to one path)
- After compaction: not auto-injected; memory comes back lazily via memory_search tool when needed

**Failure recovery:**
- Claude Code: 2 retries for streaming failures; 3 `MAX_PTL_RETRIES` for `prompt_too_long` (drops oldest message groups + truncation marker); 3 `MAX_CONSECUTIVE_AUTOCOMPACT_FAILURES` circuit breaker; code comment: "1,279 sessions had 50+ consecutive failures (up to 3,272), wasting ~250K API calls/day globally"
- OpenClaw: checkpoints on-disk before compaction; on failure → keeps checkpoint, returns `{ cancel: true }`, continues with unmodified transcript; `summarizeWithFallback`: full summary → fallback "summarise small messages, note large ones" → fallback "just note what was there"; no data mutation on failure

**Prompt engineering specifics (Claude Code):**
- `BASE_COMPACT_PROMPT`: 9 required narrative sections including verbatim quotes of current task ("to ensure there's no drift in task interpretation")
- No-tools preamble added because Sonnet 4.6 attempts tool calls during compaction 2.79% of the time vs 0.01% on Sonnet 4.5 — discovered via production telemetry, fixed with explicit warning in prompt

**Cost and latency:**
- Claude Code: cheaper hot path; 3/4 mechanisms zero-LLM; cache-warm summarisation; no cheaper-model option
- OpenClaw: N+1 calls for chunked summarisation; near-zero cache reuse across chunks; mitigated by cheaper model option; 15-minute hard abort timeout

## Relationship to existing wiki
Primary source for [[agent-harness]] and [[agent-compaction]] concepts. Provides the strongest argument for why harness ownership matters (calibration against own telemetry, not vendor's). Complements [[2026-05-sausheong-dissecting-open-claw]] (architectural read of OpenClaw) and updates [[claude-code]] with compaction stack details. The "own your harness" argument is the practitioner-level restatement of [[platform-as-trojan-horse]] applied to AI agent infrastructure.

## Quality assessment
Technical analysis of two production codebases (Claude Code source from the leaked repo; OpenClaw open source). Specific file paths, variable names, and code comments cited. Production telemetry numbers (1,279 sessions, 250K API calls/day, 2.79% vs 0.01% tool-call rates) are verifiable only if you have access to Anthropic's internal logs; author cites comment in source code as provenance. Credibility high; limitations are framing-level (compaction is one slice; other harness components have similar depth).
