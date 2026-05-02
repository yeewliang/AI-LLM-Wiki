---
type: concept
title: Memex
aliases: [memory extender]
tags: [knowledge-management, history-of-computing, hypertext]
related: [[llm-wiki-pattern]], [[vannevar-bush]], [[zettelkasten]]
created: 2026-05-02
updated: 2026-05-02
---

# Memex

## What it is
A hypothetical personal knowledge machine described by [[vannevar-bush]] in his 1945 essay "As We May Think." The Memex (memory extender) was envisioned as a desk-sized device storing an individual's books, records, and communications on microfilm, navigable via associative trails — user-defined links between related documents that could be named and shared.

## How it works
Bush described two core operations:
- **Storage**: A private, curated library of documents, indexed and retrievable by mechanical means.
- **Trail blazing**: The user forges associative links between documents, creating named "trails" that encode the reasoning path connecting them. Trails can be shared with others as a transferable record of the user's thinking.

The Memex was mechanical, pre-digital. Bush imagined physical microfilm rather than digital storage, but the conceptual architecture was prescient: a personal, curated knowledge store where the relationships between documents carry as much value as the documents themselves.

## Why it matters
The Memex anticipated hypertext, the World Wide Web, and personal knowledge management systems by decades. Bush's key insight — that human memory works by association rather than by hierarchical index, and that knowledge tools should mirror this — directly influenced Ted Nelson (who coined "hypertext"), Douglas Engelbart, and Tim Berners-Lee.

The web that emerged is public and noisy rather than private and curated, which is not what Bush envisioned. The [[llm-wiki-pattern]] is arguably closer to Bush's original vision: private, deeply interlinked, actively curated. The part Bush could not solve — who creates and maintains the associative trails — is resolved by delegating trail-maintenance to an LLM.

## Key variants or extensions
The Memex was never built. Its conceptual successors include hypertext (Ted Nelson, 1960s), the World Wide Web (Tim Berners-Lee, 1989), personal knowledge managers like [[obsidian]], and the [[llm-wiki-pattern]], which resolves Bush's unsolved maintenance problem by delegating trail-forging to an LLM.

## Limitations and open questions
Bush could not solve the maintenance problem: in the Memex, the human must forge every link manually. The [[llm-wiki-pattern]] resolves this by automating link creation and maintenance, but introduces the question of whether the trails that result from LLM curation carry the same epistemic value as trails forged through deliberate human reasoning.

## Key sources
- Bush, V. (1945). "As We May Think." *The Atlantic*.
- [[2026-04-karpathy-second-brain-explained]] — Cites Memex as intellectual predecessor to the LLM Wiki
- [[2026-04-designer-llm-wiki]] — Frames the LLM Wiki as "closer to what [Bush] imagined than anything we've built in 80 years"
