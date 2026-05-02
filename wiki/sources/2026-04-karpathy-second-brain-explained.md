---
type: source
title: "Andrej Karpathy Stopped Using AI to Write Code. He's Using It to Build a Second Brain Instead."
author: Unknown (Medium)
date: 2026-04
url: [not available in raw file]
ingested: 2026-05-02
tags: [llm-wiki, knowledge-management, karpathy, rag]
---

# Andrej Karpathy Stopped Using AI to Write Code

## Core argument
The [[llm-wiki-pattern]] is a fundamentally different approach to AI-assisted knowledge management than [[retrieval-augmented-generation]]: instead of re-deriving knowledge from raw documents at query time, an LLM compiles raw sources into a persistent, interlinked wiki that accumulates and improves over time. The human curates; the LLM maintains.

## Key concepts introduced or used
- [[llm-wiki-pattern]] — Full three-layer architecture (raw, wiki, schema), three operations (ingest/query/lint), and step-by-step setup instructions for non-technical users
- [[retrieval-augmented-generation]] — Contrasted as the approach that "rediscovers knowledge from scratch on every question"; NotebookLM and ChatGPT file uploads cited as examples
- [[memex]] — Cited as 1945 intellectual predecessor; Karpathy's system described as closer to Bush's vision than the modern web
- [[zettelkasten]] — Cited via [[niklas-luhmann]] to argue AI compilation does not replace the need to think; Luhmann's note cards as counter-argument

## Notable claims or data points
- [[andrej-karpathy]]'s personal wiki on a single research topic: ~100 articles, ~400,000 words, with minimal direct editing.
- The `llm-wiki.md` idea file was posted April 3, 2026; went viral immediately.
- Vamshi Reddy observation: "Every business has a raw/ directory. Nobody's ever compiled it. That's the product."
- At 400,000 words, the LLM navigates the wiki via index files alone — no vector database required.
- Potential downstream use: a comprehensive wiki as synthetic training data for fine-tuning a domain-specific smaller LLM.
- The schema layer (`CLAUDE.md`) absorbs all domain-specific configuration, making the same architecture domain-agnostic.

## Relationship to existing wiki
Foundational secondary source for [[llm-wiki-pattern]], [[retrieval-augmented-generation]], [[memex]], and [[andrej-karpathy]]. Most comprehensive architecture explanation in the current corpus. Source for the fine-tuning downstream use case (speculative; no direct Karpathy citation in this article).

## Quality assessment
Journalistic explanation of a technical concept; no original research. Accurate to the source material (Karpathy's gist). Accessible framing with clear architectural breakdown. Potential oversimplification of the fine-tuning downstream use case, which is presented speculatively. Author unknown; no methodology to assess.
