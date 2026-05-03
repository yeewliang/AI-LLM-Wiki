---
type: concept
title: Prompt Cache Stability
aliases: [prefix stability, prompt prefix correctness, cache-prefix invariant]
tags: [agents, inference, cost-optimisation, infrastructure]
related: [[agent-compaction]], [[agent-harness]], [[index-pattern]], [[claude-code]], [[openclaw]]
created: 2026-05-03
updated: 2026-05-03
---

# Prompt Cache Stability

## What it is
The design discipline of keeping the prefix of each LLM request identical across consecutive turns in an agent session, enabling the model provider's prompt cache to serve the repeated prefix at a fraction of the cost of a cache miss. Most agent harnesses treat this as a performance concern; [[openclaw]]'s `AGENTS.md` treats it as a correctness invariant.

## How it works
Hosted LLM providers cache the start of each request (the *prefix*). On the next request, if the prefix matches exactly — character for character — the model skips re-reading it and processes only the new tokens. The cache match fails if any character in the prefix differs, even by one byte.

**Why matching is hard:**
- Plugin discovery order is determined by disk read completion order (non-deterministic on most filesystems)
- JavaScript runtimes do not guarantee object-iteration order
- OS directory listings are returned in arbitrary order
- Any of these can produce a different plugin or tool list ordering on successive turns

**Practical rules (from OpenClaw `AGENTS.md`):**
1. **Deterministic ordering**: any list assembled from plugin discovery, tool schemas, or file reads must be sorted before being used to construct the request
2. **Cut from the newest end**: when truncating context to fit the window, drop from the most recent messages, not the oldest; the prefix (start of conversation) must remain identical turn-to-turn
3. **Test coverage**: any change that could affect the cache prefix requires an automated test proving the prefix is stable across turns

**Provider economics:**
- Providers charge approximately 10× less for cached (prefix-hit) tokens than for new tokens
- A naive agent loop where skills and memory entries shuffle in and out based on relevance estimates invalidates the cache every turn
- [[felix-agent]]'s [[index-pattern]] is motivated explicitly by this: injecting a stable lightweight index instead of variable full-content injections keeps the prefix stable

**Cache miss consequence:**
Cache misses do not surface as slower responses. They surface as *different* assistant behaviour — the model effectively sees a different conversation, and can behave in subtly inconsistent ways that are hard to attribute to cache instability. [[openclaw]] calls this out explicitly: "Cache misses don't show up as a slower assistant. They show up as a different one."

**Profile pinning:**
[[openclaw]] also pins the auth profile (LLM provider API key/OAuth session) to a session once selected, because switching profiles mid-conversation breaks the provider's prompt cache in the same way that reordering the prefix would. The same session reuses the same profile until reset, compaction completes, or the profile enters cooldown.

## Why it matters
Cache stability has two independent effects:
1. **Cost**: 10× difference in token pricing between cache hits and misses; at scale this compounds significantly
2. **Correctness**: the model's behaviour depends on its context; an unstable prefix means the model sees a different conversation, leading to inconsistent outputs that are difficult to diagnose

For agent harnesses running at significant scale, both effects are economically material. For individual users, the correctness effect is the more dangerous one — there is no error signal when the prefix drifts.

## Key variants or extensions
- **cachedMicrocompact** ([[claude-code]]): uses a proprietary `cache_edits` API endpoint to surgically remove stale tool results from the server-side cached prefix *without* invalidating the cache; unavailable to third-party harnesses
- **Index pattern** ([[felix-agent]], [[openclaw]]): inject only a stable lightweight index of available skills/memories; load full content on demand; keeps the prefix structure stable across turns even as available skills change
- **Chunk summarisation boundary** ([[openclaw]]): splits on tool-call boundaries so that `tool_use` / `tool_result` pairs are never separated during compaction; preserves coherence in the rewritten context

## Limitations and open questions
- The `cache_edits` mechanism (Claude Code) is an Anthropic-proprietary API feature; no equivalent exists for third-party harnesses targeting providers that don't expose it
- Cache TTL is typically 5 minutes; sessions idle longer than 5 minutes will miss on the next turn regardless of prefix stability
- Automated tests for prefix stability are possible in principle but require snapshot-based comparison of the serialised request byte sequence, which is expensive to maintain across prompt changes

## Key sources
- [[2026-05-sausheong-dissecting-open-claw]] — OpenClaw AGENTS.md rules; "cache misses show up as a different assistant"
- [[2026-05-sausheong-own-your-harness]] — cachedMicrocompact; cache economics; provider difference between CC and OpenClaw
- [[2026-05-sausheong-felix-agent]] — Index pattern as prompt-cache stability mechanism; "5–10× higher bill" from non-deterministic prompt construction
