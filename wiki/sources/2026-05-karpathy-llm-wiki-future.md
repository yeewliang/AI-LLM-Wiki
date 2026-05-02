---
type: source
title: Why Andrej Karpathy's "LLM Wiki" is the Future of Personal Knowledge
author: unattributed (Medium)
date: 2026-05-02
url:
ingested: 2026-05-02
tags: [llm-wiki, ecosystem, knowledge-management, rag]
---

# Why Andrej Karpathy's "LLM Wiki" is the Future of Personal Knowledge

## Core argument
The [[llm-wiki-pattern]] introduced by [[andrej-karpathy]] in April 2026 is a design pattern, not a product: an LLM-maintained, compounding markdown layer that sits between the user and their raw sources. It addresses two simultaneous failures: [[retrieval-augmented-generation]]'s lack of accumulation, and human-maintained wikis' bookkeeping burden. A small ecosystem of related projects has already emerged around the same problem.

## Key concepts introduced or used
- [[llm-wiki-pattern]] — three-layer architecture (raw sources / LLM-maintained wiki / schema file like CLAUDE.md); three operations (ingest / query / lint). Article quotes Karpathy: "Obsidian is the IDE, the LLM is the programmer, the wiki is the codebase."
- [[retrieval-augmented-generation]] — characterised as having "no accumulation": each query re-derives synthesis from scratch.

## Notable claims or data points
- An ingest typically updates "10–15 related concept pages" per source — corroborates the same claim in [[kosuri-2026-llm-wiki-build]].
- Five named ecosystem projects framed as adjacent solutions to the same RAG bottleneck:
  - **Waykee Cortex** (waykee.com) — team-oriented; strict hierarchical context inheritance (UI screen → module → system); combines a Knowledge layer with a Work layer (tasks, bugs, milestones) so issues inherit dual context.
  - **Sage-Wiki** by *xoai* (github.com/xoai/sage-wiki) — treats the LLM as a strict compiler (make-like). Five-step incremental pipeline: diff → summarize → extract → write → images. Enforces a typed-entity system (`is-a`, `contradicts`) to prevent duplicate concepts.
  - **Thinking-MCP** (github.com/multimail-dev/thinking-mcp) — captures *how* a user thinks rather than what they know: heuristics, tensions, decision rules. Uses **node decay**: core values persist, ephemeral ideas fade.
  - **ELF — Eli's Lab Framework** (github.com/ProjectEli/ELF) — for scientific research; mixes PARA organisation with wiki architecture; uses a "base-delta protocol" for incremental experiments.
  - **qmd** by [[tobi-lutke]] (github.com/tobi/qmd) — local search engine over markdown using hybrid BM25 + vector search, exposed via MCP server. Designed to replace the `index.md` navigation layer when wikis scale beyond a few hundred files.

## Relationship to existing wiki
- Reinforces and extends [[llm-wiki-pattern]] with the explicit ecosystem framing — pattern not product, solving the same RAG-vs-bookkeeping problem.
- Adds named external projects worth tracking but not yet given dedicated entity pages (each is referenced only in passing here).
- Confirms the ~100-page scale ceiling for `index.md` navigation already noted on [[llm-wiki-pattern]] — qmd is the article's named answer to that ceiling.

## Quality assessment
Journalistic survey article. Useful as an ecosystem map; light on first-party verification of the projects it lists. Each external project is a single-paragraph capsule, often citing the project's own README or a single tweet. Treat capsule descriptions as accurate to project self-presentation, not as independent evaluation. The article ends with a teaser link to a separate "Japanese firm where the most important employee was a markdown file" piece — not ingested here.
