---
type: entity
entity_class: tool
title: OpenClaw
aliases: [openclaw]
tags: [agent-harness, local-first, multi-channel, agent-runtime]
related: [[agent-harness]], [[agent-compaction]], [[prompt-cache-stability]], [[skills-as-markdown]], [[model-context-protocol]], [[felix-agent]], [[sausheong-chang]]
created: 2026-05-03
updated: 2026-05-03
---

# OpenClaw

## Overview
Local-first AI agent gateway and runtime. Runs on your machine as a long-running control plane with adapters for 24 chat networks (Telegram, WhatsApp, Signal, iMessage, Matrix, Discord, IRC, Nostr, Slack, and others), a plugin SDK with 113 bundled plugins, markdown-based skills, voice, browser control, canvas, cron, and companion apps for macOS, iOS, and Android. The agent lives in the environment; the environment is not a workflow wrapper around the agent.

## Why this entity matters to AI
OpenClaw is one of two well-documented production [[agent-harness]] implementations (alongside [[claude-code]]) that have been analysed at the design level as of 2026. Its architectural discipline — naming and enforcing seams via documented contracts — is the clearest available example of harness-as-contract thinking.

Key architectural distinctions:
- **Plugin SDK with generated API baseline**: build fails if any public type changes without regenerating a snapshot; API-first from launch (contrast with WordPress/Node.js retrofitting stability after ecosystem grows around internals)
- **[[skills-as-markdown]]**: skills are prose documents with YAML frontmatter; no compiled code; agent drives underlying CLIs; distributable via ClawHub registry
- **Channel decomposition**: 24 adapters implement narrow per-capability interfaces (lifecycle, threading, reactions, etc.) rather than one fat `ChatChannel` interface; each adapter implements only what its network can honour
- **Agent loop as contract**: 5-phase loop (intake → context assembly → inference → tool execution → streaming+persistence) with ~12 named hook points that plugins can register against
- **[[prompt-cache-stability]] as tested invariant**: `AGENTS.md` mandates deterministic ordering and cut-from-newest-end truncation; cache misses are treated as correctness failures, not performance degradation
- **MCP bridged, not first-class**: MCP support via `mcporter` project, not a first-party runtime; core stays stable as MCP spec changes
- **Dreaming**: opt-in background memory consolidation (Light / Deep / REM phases) promoting daily observation notes to durable `MEMORY.md`
- **Compaction**: preemptive token estimation before every LLM call; chunked summarisation with N+1 calls; `auditSummaryQuality` audit-and-regenerate loop; snapshot-and-cancel failure recovery

## Key works / outputs
- OpenClaw gateway runtime — `src/gateway/`, 113 plugins under `extensions/`
- ClawHub — external skill and plugin registry with semver tags, lockfile, content-hash verification
- `AGENTS.md`, `VISION.md`, `SECURITY.md` — load-bearing design documents (code is generated from docs; docs are the authoritative spec)
- ACP (Agent Client Protocol) support — editor integration via ACP bridge, routing IDE prompts through same gateway as chat channels

## Affiliations and relationships
- Maintainer: Peter Steinberger (openly uses AI assistant to generate most code; does not read the output line by line)
- [[felix-agent]] — built by [[sausheong-chang]] after using OpenClaw and wanting different design decisions; shares the skills-as-markdown concept
- [[sausheong-chang]] — wrote the architectural analysis at commit `cdaa70facb9bc073eede221bf741db8a4a843c0a`

## Current status / latest developments
As of May 2026, active open-source project with 113 bundled plugins, 53 skills, ACP IDE integration, and ClawHub external registry. The codebase is AI-generated from docs; the maintainer regenerates code as specs evolve. Trust model is explicitly single-user / single-operator (no multi-tenant boundary). Security advisory process exists via GitHub Security Advisories and a named Security & Trust lead.
