---
type: source
title: "I Built My Own AI Agent and Named It After a Cat"
author: [[sausheong-chang]]
date: 2026-05-03
url: https://sausheong.com
ingested: 2026-05-03
tags: [agent-harness, felix-agent, local-first, index-pattern, everything-is-a-tool]
---

# I Built My Own AI Agent and Named It After a Cat

## Core argument
Building a personal AI agent from scratch (Felix) for non-coding desk work produces better fit-for-purpose design than adapting a general-purpose tool. Three design principles (self-sufficient, robust, usable out of the box, secure by default) and four internal patterns (everything-is-a-tool, index pattern, long-running process contract, configuration mirroring) yield a system that is simpler, faster, cheaper, and more maintainable than naive alternatives.

## Key concepts introduced or used
- [[agent-harness]] — Felix is the implementation vehicle; single binary, ~/.felix/ state directory, no cloud dependency
- [[index-pattern]] — Lightweight index injection instead of full content injection; model loads on demand; trims 5–15 KB from every prompt; preserves prompt cache stability
- [[prompt-cache-stability]] — Index pattern explicitly motivated by prompt-cache economics: providers charge ~10× less for cached tokens; non-deterministic prompt construction "quietly costs money every turn"
- [[skills-as-markdown]] — Skills in Felix are markdown files with short header blocks; same concept as OpenClaw but in a different system

## Notable claims or data points
**Everything-is-a-tool:**
- All agent effects on the world go through one interface: read files, write files, shell commands, web requests, scheduled jobs, MCP servers, skills
- One place to check permissions, one place to audit; one concept to explain in settings UI
- Security model is legible: if a tool isn't on the allowlist, the agent cannot use it — that's the whole rule
- Bash tool layers a command-level allowlist on top of the tool allowlist as defence in depth

**Index pattern:**
- Conventional approach: retrieve relevant memories/skills/docs and inject full content into prompt on every turn (speculative)
- Felix approach: inject lightweight index (name, tags, one-line description); agent calls a load-tool when it actually needs full content
- Trims ~5–15 KB of speculative content per prompt
- Hosted AI providers charge ~10× less for tokens already seen at prefix; non-deterministic prompt construction = cache miss = "5 or 10× higher bill than it needed to be"

**Long-running process contract:**
- Config file changes take effect on next message, not on restart; LLM clients and permission checker swap atomically
- Exceptions (restart required): MCP server connections (can't be re-established mid-flight); statically-configured cron jobs (capture setup at registration time)

**Configuration mirroring:**
- Compaction summariser uses same model as chat agent by default; Cortex uses same embedder as memory system; Ollama port auto-injected
- Rule: "Every value you have to configure twice is a synchronisation bug waiting to happen"

**Robustness specifics:**
- Every external call has a deliberate timeout: Cortex recall = 800ms; bash tool = 120s; WebSocket messages capped at 1MB
- Session format self-heals after crash: orphaned tool calls on reload → synthetic error responses injected → conversation continues cleanly
- Compaction appends-only; delete the summary entry and raw history is intact underneath
- MCP circuit breaker: 3 consecutive failures → trips; Re-authenticate button in UI
- macOS menu-bar launcher runs gateway as separate subprocess in own process group; system kill of tray icon leaves chat session running

**Cortex (knowledge graph):**
- Every completed conversation → extraction pass → entities + relationships (people, projects, decisions, technical concepts) stored in local knowledge graph
- Subsequent conversations: Cortex recalls relevant nodes before agent starts reasoning
- Works alongside keyword search; surfaces different things (keyword finds "where you mentioned X"; Cortex finds "the project that conversation was about")
- Built as separate library (github.com/sausheong/cortex) before Felix; became long-term memory backbone

**Multi-agent:**
- Multiple agents per Felix install; different models, tool permissions, personas per agent
- Sub-agents: Claude Sonnet for heavy planning/reasoning; Gemma4 local model for repetitive execution tasks (zero cost); supervisor decides delegation
- Supports OpenTelemetry export (off by default)

**Local-first specifics:**
- Default model: Gemma4 (~9.6 GB); auto-downloads via bundled Ollama; progress bar shown; no API key required
- `tar ~/.felix/` → copy to another machine → pick up mid-conversation; no server sync
- Session JSONL, memory entries as Markdown, config as JSON-with-comments, skills as Markdown — all human-readable

## Relationship to existing wiki
Introduces [[felix-agent]] as a new entity and provides the primary source for the [[index-pattern]] concept. Complements [[2026-05-sausheong-dissecting-open-claw]] (Felix was built after using [[openclaw]] and wanting different design decisions). The everything-is-a-tool principle is a clean instance of the single-abstraction discipline recommended in [[agentic-engineering]] configuration stacks.

## Quality assessment
First-person design rationale from the builder. Patterns are justified by real production experience (circuit breaker triggered by actual runaway session; index pattern discovered by tracing slow response times). Self-aware about design trade-offs (9.6 GB first-run download is real friction). Codebase is Go; open source at github.com/sausheong/felix. High credibility.
