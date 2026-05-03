---
type: source
title: "Dissecting OpenClaw: System Design and Architecture"
author: [[sausheong-chang]]
date: 2026-05-03
url: https://sausheong.com
ingested: 2026-05-03
tags: [agent-harness, openclaw, architecture, plugin-sdk, prompt-cache-stability, agent-loop]
---

# Dissecting OpenClaw: System Design and Architecture

## Core argument
[[openclaw]] is an agent-environment (a runtime in which the agent lives and acts) rather than a workflow-with-an-agent. Its distinguishing architectural discipline is naming and enforcing seams: every extensibility boundary is a documented contract on disk, enforced at build time or via tests. The codebase was largely written by an AI assistant; the load-bearing artefacts are the docs, not the code.

## Key concepts introduced or used
- [[agent-harness]] — OpenClaw is examined as an example of harness architecture; control plane, fan of adapters, per-device daemons, plugin SDK
- [[skills-as-markdown]] — Skills are markdown documents with YAML frontmatter; no compiled code; prose is what the model reads; installable via ClawHub registry
- [[prompt-cache-stability]] — `AGENTS.md` promotes cache-prefix correctness to a first-class tested invariant; five rules, two doing most work (deterministic ordering, cut-from-newest-end)
- [[agent-compaction]] — Context assembly and compaction are plugin slots; `ContextEngine` interface with ingest/assemble/compact/after-turn lifecycle
- [[model-context-protocol]] — MCP is bridged via `mcporter`, deliberately not first-class in core; protects core from fast-moving spec changes

## Notable claims or data points
**Architecture:**
- Gateway = control plane; node-host = per-device daemon holding secrets; channels = 24 inbound adapters; extensions = 113 plugins
- Plugin-to-core boundary enforced via `src/plugin-sdk/` only — never via `src/**` direct import
- `VISION.md` "What We Will Not Merge" list: nested agent hierarchies, first-class MCP runtime in core, wrapper channels

**Plugin SDK:**
- API baseline: generated snapshot of every public type; build fails if live API diverges from snapshot without regeneration
- Approach is API-first from launch; contrast with WordPress/Node.js retrofitting stability after ecosystem grows around internals

**Skills as markdown:**
- YAML frontmatter declares OS, required binaries, install method (e.g. Homebrew formula)
- Everything after frontmatter is plain English: when to use, when not to, what arguments the CLI takes
- Distribution via ClawHub with semver tags, `.clawhub/lock.json`, content-hash divergence warnings

**Channel decomposition:**
- ~40 narrow capability files (lifecycle, status, streaming, pairing, send-result, etc.) instead of one fat `ChatChannel` interface
- Each adapter implements only the slots its network can honour; gateway asks at runtime whether threading/reactions/pairing is supported
- Avoids "polite fiction" adapters that stub capabilities their network lacks

**Agent loop as contract:**
- 5 phases: intake → context assembly → inference → tool execution → streaming+persistence
- ~12 named hook points: `before_model_resolve`, `before_prompt_build`, `before_tool_call`, `after_tool_call`, `before_compaction`, `after_compaction`, `session_start/end`, `gateway_start/stop`, `message_received/sending/sent`
- Runs serialised per session key; optional global lane; prevents concurrent-access race conditions in transcript/tool state

**Prompt cache stability:**
- `AGENTS.md` rule 1: sort any list built from plugin discovery before constructing the request (JS runtimes, disk reads, OS directory listings do not guarantee order)
- `AGENTS.md` rule 2: cut from newest end when shortening context; prefix at start must stay identical turn-to-turn
- Cache misses don't appear as slower assistant — they appear as *different* assistant behaviour

**Sandbox:**
- 4 knobs: mode (off/non-main/all), scope (per-agent/per-session/shared), backend (docker/ssh/openshell), workspace access (none/ro/rw)
- 3 Docker images: `bookworm-slim`, `sandbox-common` (adds curl/jq/nodejs/python3/git), `sandbox-browser` (Chromium)
- No network by default; egress explicit; `tools.elevated` for host bypass; `exec-approvals.json` per-command allowlist

**Auth profiles and failover:**
- Profiles per-agent at `~/.openclaw/agents/<id>/agent/auth-profiles.json`
- Rotation order: explicit `auth.order` if set, else OAuth before API keys, within type oldest-`lastUsed` first; cooldowns/disabled at end
- Rate-limit cooldown: exponential backoff 1m/5m/25m/1h cap; billing failure: 5h starting, doubles to 24h cap
- Profile pinned per session for prompt-cache warmth; session compaction or reset allows switch

**Memory and dreaming:**
- Per-agent: `MEMORY.md` (durable, loaded every DM session), `memory/YYYY-MM-DD.md` (daily notes), `DREAMS.md` (consolidation diary)
- Plugin backends: `memory-core` (SQLite + FTS5 + vector), `memory-qmd` (local-first, reranking, query expansion), `memory-honcho` (cloud cross-session), `memory-wiki` (structured claims, contradiction tracking)
- Dreaming: opt-in; 3 phases: Light (ingest+dedup+stage, never writes durable), Deep (rank+promote to MEMORY.md), REM (theme extraction for next Deep ranking)
- Pre-compaction: silent turn nudging agent to save important facts before context loss

**Multi-agent:**
- Multiple agents in one gateway, routed by binding (channel × account × peer × platform keys); most-specific match wins
- Each agent has own `SOUL.md` (persona: tone, opinions, brevity, humour; loaded into system prompt)
- `sessions_spawn` for background work; `maxSpawnDepth` defaults to 1 (recursion opt-in); never exceeds 2 as default
- "What We Will Not Merge": manager-of-managers / recursive planner trees as default architecture

**Cron jobs:**
- Each cron tick spawns an isolated agent with own session identity, auth profile, delivery lane, tool policy
- Sandbox config asserted fresh every tick; blast radius confined to cron session, not user chat history

**Security model:**
- Single trust boundary: authenticated gateway callers = trusted operators. No `operator.write` vs `operator.admin` split
- Prompt injection explicitly out of scope as false positive; plugin supply chain: installed plugin = operator
- `src/security/` ~80 entries, ~50 named `audit-*`; formal severity guide; `openclaw/trust` threat model repo

## Relationship to existing wiki
Introduces [[openclaw]] as a new entity. Provides the primary source for [[skills-as-markdown]] and [[prompt-cache-stability]] concepts. Adds architectural contrast to [[agent-harness]]. Complements [[2026-05-sausheong-own-your-harness]] which compares OpenClaw vs Claude Code compaction stacks. MCP-bridge design is the counterpoint to [[model-context-protocol]]'s token-cost framing.

## Quality assessment
Author read the documentation (not the AI-generated code) deliberately. The code is re-generated from docs; docs are the load-bearing artefact. Analysis is structural rather than code-review; honest about what was not covered (voice pipeline, browser tool, canvas, native apps). Inspected at commit `cdaa70facb9bc073eede221bf741db8a4a843c0a`. Credibility high; author has hands-on experience building [[felix-agent]] for comparison.
