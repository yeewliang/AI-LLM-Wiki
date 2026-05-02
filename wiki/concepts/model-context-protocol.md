---
type: concept
title: Model Context Protocol
aliases: [MCP, MCP server]
tags: [agents, tools, protocol, llm, anthropic]
related: [[claude-code]], [[agentic-engineering]], [[claude-code-configuration]]
created: 2026-05-02
updated: 2026-05-02
---

# Model Context Protocol

## What it is
A protocol for connecting LLM agents to external tools and data sources. An MCP server exposes tool schemas and capabilities; an agent client (e.g. [[claude-code]]) loads those schemas and can invoke the tools during a session. MCP is what lets a single agent reach a filesystem, GitHub, a documentation index, a database, or a custom code-graph store with a uniform interface.

## How it works
Each server is configured in the agent's `.mcp.json` (or equivalent) with a launch command, environment variables, and arguments. On session start the agent loads the server's tool schemas. On every turn those schemas are part of the agent's context and consume tokens.

Reference numbers from Anthropic's tool-search documentation (cited in [[2026-05-claude-code-tuning-stack]]):

- 50 installed tools without lazy loading: roughly **10,000–20,000 tokens per turn** spent just on tool schemas.
- Tool-search lazy loading reduces that by approximately **85%**, but the cheaper strategy is still installing fewer servers.

A small canonical set covers most engineering needs: code graph with persistent session memory (e.g. `vexp`), GitHub for branch and PR management, filesystem for cross-directory access, web search for current docs, dedicated documentation server (e.g. context7) for version-specific library pulls. Adding more — fifteen or twenty servers — measurably degrades agent performance through context dilution and confused tool selection.

## Why it matters
MCP is the layer where agent capability and agent cost are negotiated. In [[agentic-engineering]] the configuration of MCP servers is one of the highest-leverage decisions: tool schemas are *not free*, and a poorly chosen server set silently increases per-turn cost while making the agent less reliable. It also extends agent reach beyond the local repository — to issue trackers, internal documentation, production telemetry, and custom organisational tools — turning the agent into an integration point rather than a code editor.

## Key variants or extensions
- **Tool-search lazy loading**: schemas are retrieved on demand rather than loaded ambient at every turn; ~85% token reduction in the high-tool-count regime.
- **Server-side `_meta` annotations** (April 2026): `anthropic/maxResultSizeChars` lets a server keep large documentation pulls *inline* in the agent's context window rather than forcing a file-write workaround.
- **Persistent session memory servers** (e.g. `vexp`): server maintains state across turns to avoid re-reading the same code graph; cited 65–70% token reduction on long-running agent setups (vendor benchmark).
- **MCP-exposed search engines** (e.g. `qmd` by [[tobi-lutke]]): markdown wikis, knowledge bases, or codebases exposed as MCP-callable search backends — used as the navigation layer for [[llm-wiki-pattern]] implementations beyond `index.md` scale.

## Limitations and open questions
- **Token economics dominate**: any MCP design discussion that ignores per-turn schema cost is misleading; real-world agent latency and cost are heavily influenced by server count.
- **Tool-selection failure modes**: with too many tools, agents pick the wrong one or pass malformed arguments more often.
- **Auth and trust boundary**: MCP servers run with the calling agent's permissions; sandboxing, scoping, and credential handling vary by server and are not standardised.
- **Versioning and compatibility**: tool schemas evolve; servers and agents do not always agree on shape, and breakage tends to surface mid-session rather than at startup.

## Key sources
- [[2026-05-claude-code-tuning-stack]] — Concrete five-server prescription, token-cost numbers, deferred-permission interactions, April 2026 `_meta` annotation
- [[2026-05-karpathy-llm-wiki-future]] — `qmd` and ecosystem projects exposed via MCP as wiki search backends
