---
type: entity
entity_class: tool
title: Felix
aliases: [felix-agent]
tags: [agent-harness, local-first, self-built, go]
related: [[agent-harness]], [[index-pattern]], [[prompt-cache-stability]], [[skills-as-markdown]], [[model-context-protocol]], [[openclaw]], [[sausheong-chang]]
created: 2026-05-03
updated: 2026-05-03
---

# Felix

## Overview
Single-binary, local-first AI agent built by [[sausheong-chang]] for personal non-coding desk work: research, writing, information organisation, automating recurring personal and work tasks. All state lives in `~/.felix/` as human-readable plain files (JSONL sessions, Markdown memory entries, JSON config, Markdown skills). No cloud account, no external server, no required network connection after initial model download.

Named after a cat deliberately — "No scary claws. Just a cat."

## Why this entity matters to AI
Felix is a documented self-built [[agent-harness]] from an experienced practitioner, designed after dissatisfaction with [[openclaw]]'s design choices. It provides the primary source for:
- **[[index-pattern]]**: lightweight index injection + on-demand full-content loading; trims 5–15 KB per prompt; keeps [[prompt-cache-stability]]
- **everything-is-a-tool**: all agent effects on the world (files, shell, web, scheduled jobs, MCP servers, skills) go through one interface with one permission list and one audit trail; no parallel capability abstractions
- **long-running process contract**: config changes take effect on next message without restart; atomic component swaps; explicit "restart required" labels for exceptions (MCP connections, statically-configured cron)
- **configuration mirroring**: compaction summariser mirrors chat model; knowledge graph mirrors memory embedder; auto-configured values default to matching rather than requiring explicit duplication

Provides a contrast case to [[openclaw]]: same philosophical space (local-first, skills-as-markdown), different design decisions (simpler plugin model, explicit security defaults rather than opt-in).

## Key works / outputs
- Felix binary — released at github.com/sausheong/felix; macOS pkg installer
- **Cortex** — local knowledge graph library (github.com/sausheong/cortex); extracts entities and relationships from completed conversations; stores in local graph; recalls relevant nodes before each turn; works alongside keyword search
- `~/.felix/` state format: JSONL sessions, Markdown memory, JSON-with-comments config, Markdown skills
- Built-in tools: file read/write, targeted in-place edit, shell execution, web fetch (Markdown conversion), headless browser, Telegram send, scheduled jobs, skill/memory load, image pass-through to model

## Affiliations and relationships
- [[sausheong-chang]] — author and sole user (designed for personal use, not product roadmap)
- [[openclaw]] — inspiration and contrast; Felix built after using OpenClaw and wanting different design decisions
- Default model: Gemma4 (~9.6 GB) via bundled Ollama; also supports Anthropic, OpenAI, Gemini, Qwen, and others

## Current status / latest developments
As of May 2026, active personal tool under ongoing development. Direction driven by personal usage (index pattern from tracing slow response times; circuit breaker from runaway MCP session; hot-reload from frustration restarting on key changes). Codebase intentionally small; complexity added only when absence felt during actual use. Available open source; Go implementation.
