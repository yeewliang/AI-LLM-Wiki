---
type: entity
entity_class: tool
title: Obsidian
aliases: []
tags: [knowledge-management, markdown, tool, note-taking]
related: [[llm-wiki-pattern]], [[zettelkasten]]
created: 2026-05-02
updated: 2026-05-02
---

# Obsidian

## Overview
A local-first markdown note-taking application built on a plain-file vault (a folder of `.md` files). Core features include bidirectional wikilinks (`[[page-name]]`), a graph view visualising link relationships between notes, and an extensive plugin ecosystem. Available on Mac, Windows, Linux, and mobile. Free for personal use.

## Why this entity matters to AI
Obsidian is the canonical viewing layer in the [[llm-wiki-pattern]] workflow. [[andrej-karpathy]] described his setup as: LLM agent on one side making edits; Obsidian on the other for real-time browsing. Its plain-file architecture is the key property — the LLM writes directly to the vault directory without any API or integration layer; Obsidian reads whatever markdown files are present.

Key features relevant to the pattern:
- **Graph view**: Visualises the wikilink network; hubs (high-link pages) and orphans (no inbound links) are immediately visible — useful for lint passes.
- **Obsidian Web Clipper**: Browser extension that converts web articles to local markdown with one click; primary source intake mechanism for the `raw/` folder.
- **Dataview plugin**: Runs structured queries over YAML frontmatter, enabling dynamic tables and catalogs from page metadata.
- **Marp plugin**: Renders markdown as slide presentations; enables LLM-generated reports as presentation-ready slide decks.
- **Canvas**: Spatial, whiteboard-style view of notes as connected nodes; particularly valuable for visual thinkers (e.g., designers).

## Key works / outputs
- Obsidian application — local-first markdown note-taking app with bidirectional wikilinks, graph view, and plugin ecosystem; primary product of Dynalist Inc.
- Obsidian Web Clipper — browser extension for converting web articles to local markdown.

## Affiliations and relationships
- Dynalist Inc. — creator and developer of Obsidian (founders: Erica Xu and Shida Li).
- [[andrej-karpathy]] — public advocate; described his [[llm-wiki-pattern]] workflow as pairing Claude Code with Obsidian as the viewer.

## Current status / latest developments
As of 2026, Obsidian is widely adopted in the [[llm-wiki-pattern]] community. Its combination of local-first storage (no vendor lock-in, no subscription required for core use), bidirectional links, and graph view makes it the most frequently cited frontend for LLM-maintained wikis. At least one product design leader (Polgár, per secondary sources) switched their entire note-taking workflow to Obsidian specifically to enable direct Claude Code file access without MCP complexity.
