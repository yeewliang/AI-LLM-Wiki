---
type: concept
title: LLM Wiki Pattern
aliases: [LLM Wiki, llm-wiki, knowledge compilation, AI second brain]
tags: [knowledge-management, agents, llm, workflow]
related: [[retrieval-augmented-generation]], [[memex]], [[zettelkasten]], [[obsidian]]
created: 2026-05-02
updated: 2026-05-02
---

# LLM Wiki Pattern

## What it is
A pattern for building persistent, self-maintaining personal knowledge bases using LLMs. Raw source documents are fed to an LLM, which compiles and incrementally maintains a structured wiki of interlinked markdown files. Knowledge accumulates across sessions instead of being re-derived at query time.

## How it works
Three distinct layers compose the system:

**Raw sources (`raw/`)** — Immutable source documents: articles, papers, PDFs, transcripts. The LLM reads from this layer but never modifies it.

**The wiki (`wiki/`)** — LLM-generated markdown files: entity pages, concept pages, source summaries, synthesis pages, and two operational files (`index.md` as master catalog, `log.md` as append-only operation record). The LLM owns this layer entirely.

**The schema (`CLAUDE.md` / `AGENTS.md`)** — A configuration file that defines page formats, naming conventions, workflows, and domain scope. Transforms a general-purpose LLM into a disciplined wiki maintainer. Domain-specific configuration lives here.

Three operations drive the system:

**Ingest** — A new source is added to `raw/`. The LLM reads it, creates a source summary page, updates 10–15 existing wiki pages (entity pages, concept pages, synthesis), adds backlinks, updates `index.md`, and logs the operation.

**Query** — The LLM reads `index.md` to locate relevant pages, then drills into them to synthesise an answer. Query results worth preserving are filed back into the wiki as new pages, compounding the knowledge base.

**Lint** — Periodic health check: broken wikilinks, orphan pages (no inbound links), stale claims, pages missing from `index.md`, missing frontmatter, contradictions between pages.

## Why it matters
Solves the core failure mode of knowledge bases: maintenance burden. Cross-referencing, updating summaries, keeping claims consistent across pages — this work is cognitively cheap for LLMs but expensive for humans, which is why human-maintained wikis go stale. By making the LLM the maintainer, the cost of wiki upkeep approaches zero, and the knowledge base compounds instead of decaying.

Contrast with [[retrieval-augmented-generation]]: RAG re-derives knowledge at query time from raw chunks; LLM Wiki compiles knowledge once and keeps it current, enabling richer synthesis and cross-source reasoning.

## Key variants or extensions
- **Fine-tuning endpoint**: Karpathy notes that a sufficiently clean, comprehensive wiki could generate synthetic training data for fine-tuning a smaller LLM, internalising domain knowledge into model weights rather than reading it at query time.
- **Team/business variant**: Internal wikis fed by Slack threads, meeting transcripts, customer calls. Humans review LLM-generated updates rather than writing them.
- **Search augmentation**: At scale (~hundreds of pages), the `index.md` approach starts to degrade. Tools like `qmd` (hybrid BM25/vector search for markdown, with CLI and MCP server) can replace the index for retrieval.
- **Three phases framing**: [[andrej-karpathy]] (per secondary sources) positioned the LLM Wiki as a third phase of human-AI collaboration — after vibe coding and agentic engineering, AI managing knowledge rather than code. This framing is editorial interpretation; treat as [synthesis] until a direct citation is available.

## Limitations and open questions
- **Synthesis vs. reconnaissance**: The LLM is effective at organising and cross-referencing but not at forming original conclusions from the material. Higher-order synthesis — determining what the evidence means — remains a human responsibility.
- **Scale ceiling**: The `index.md`-based navigation works well up to ~100 sources / hundreds of pages. Above that, semantic search infrastructure becomes necessary.
- **LLM error propagation**: Misinterpretations in early ingests can propagate into many downstream pages before being caught by a lint pass.
- **Context limits**: Very large wikis require the LLM to work with the index as a navigation layer; it cannot hold the entire wiki in context simultaneously.
- **Externalised understanding**: Contrast with [[zettelkasten]]: Luhmann argued that writing in your own words is the mechanism of understanding, not merely a record of it. Delegating this to an LLM may produce well-organised knowledge the practitioner does not actually understand.

## Key sources
- [[kosuri-2026-llm-wiki-build]] — Practitioner implementation; confirms 10–15 page updates per ingest and index.md sufficiency at moderate scale
- [[2026-04-karpathy-second-brain-explained]] — Full architecture walkthrough; introduces fine-tuning downstream use case
- [[2026-04-designer-llm-wiki]] — Designer use case; adds three-phases framing
