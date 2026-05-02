---
type: source
title: "I used Karpathy's LLM Wiki to build a knowledge base that maintains itself with AI"
author: Balasubramanyam Kosuri
date: 2026-04
url: https://github.com/balukosuri/llm-wiki-karpathy
ingested: 2026-05-02
tags: [llm-wiki, cursor, obsidian, implementation, technical-writing]
---

# I Used Karpathy's LLM Wiki to Build a Knowledge Base That Maintains Itself with AI

## Core argument
The [[llm-wiki-pattern]] can be instantiated in ~30 minutes using [[cursor]] as the agent layer and [[obsidian]] as the viewer. Domain adaptation requires only editing the `CLAUDE.md` schema file. The barrier to entry is low enough for non-developers.

## Key concepts introduced or used
- [[llm-wiki-pattern]] — Walkthrough of all three layers and three operations; concrete file structure provided; step-by-step repo setup
- [[cursor]] — Used as the agent layer (natural-language prompts → file writes); complete scaffold built in 3 prompts with no CLI usage
- [[obsidian]] — Pre-configured vault with graph view colours, hotkeys, and sidebar layout included in the public repo

## Notable claims or data points
- Complete wiki scaffold built in 3 natural-language prompts to Cursor:
  - Prompt 1: mapped the pattern to the author's role as technical writer
  - Prompt 2: generated `CLAUDE.md`, directory structure, and four starter wiki pages (`index.md`, `log.md`, `overview.md`, `glossary.md`)
  - Prompt 3: installed and configured [[obsidian]] (including via Homebrew)
- After one week of use by a technical writer: 15–20 wiki pages, living glossary, overview with open questions, full activity log, graph view showing connections.
- A single-source ingest can touch 10–15 wiki pages.
- The `index.md`-based navigation "works surprisingly well at moderate scale (~100 sources, ~hundreds of pages)."
- Public repo: [github.com/balukosuri/llm-wiki-karpathy](https://github.com/balukosuri/llm-wiki-karpathy) includes Karpathy's original `llm-wiki.md`, a pre-built `CLAUDE.md`, and pre-configured [[obsidian]] vault.
- Practical tip: ingest one source at a time and stay involved; batch ingest loses the opportunity to guide the LLM on emphasis.

## Relationship to existing wiki
Primary evidence that [[llm-wiki-pattern]] is accessible to non-developers. Adds concrete data on setup time (~30 min) and initial output volume (15–20 pages after one week). Introduces [[cursor]] as an alternative agent layer to Claude Code. Confirms index.md sufficiency claim at moderate scale.

## Quality assessment
First-person practitioner account with high specificity. Author is a technical writer, not a developer — credible evidence of low barrier to entry. Repo is public and verifiable. Week-1 output claims (15–20 pages) are plausible but not independently verified. Author identity confirmed: Balasubramanyam Kosuri, LinkedIn linked in article.
