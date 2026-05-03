---
type: concept
title: Capability-Threshold Product Design
aliases: [capability thresholds, model-driven UX, removing UI crutches]
tags: [product-design, ai-product, llm, anthropic]
related: [[claude-code]], [[anthropic]], [[five-levels-of-ai-engineering]], [[vibe-coding]]
created: 2026-05-03
updated: 2026-05-03
---

# Capability-Threshold Product Design

## What it is
A product design principle, articulated internally at [[anthropic]], holding that UI features should be added or removed based on model capability, not user familiarity. When a model surpasses a capability threshold, scaffolding previously required to compensate for model limitations is removed; when a model crosses an accuracy threshold, new product categories that were previously unreliable become viable.

## How it works
Two symmetrical dynamics apply:

**Removing crutches.** An older model cannot maintain task context across a large refactor, so the product surface includes a structured to-do list UI to externalise that state. A newer model holds the context natively. The UI is stripped — not iterated on, removed. Teams must actively audit UI features for whether they compensate for a model deficiency rather than serving genuine user needs.

**Unlocking new surfaces.** At 85% accuracy, an autonomous code-review agent produces enough false positives to be noise. At 99%+, it becomes blockable without human review. The product does not exist at 85%; it can exist at 99%. This threshold dynamic determines when to build, not just how to build.

The **100% accuracy rule** (attributed to [[cat-wu]]): workflows at 95% accuracy deliver incomplete leverage — the human must still monitor for the 5% failure case. Only at 100% is the cognitive overhead of oversight genuinely eliminated. Reaching 100% requires prompt refinement, model feedback iteration, and structured evals — not accepting "good enough."

## Why it matters
Most product development treats model capability as a fixed constraint and designs UX around its limitations. Capability-threshold design inverts this: UI is temporary scaffolding, revised continuously as the underlying model changes. This requires tighter coupling between product and model teams and faster design iteration cycles than traditional product development supports.

> [synthesis] This principle is implicit in [[five-levels-of-ai-engineering]]: each level transition represents a capability threshold crossing that makes new product architectures possible. The design philosophy described here is the product-management operationalisation of that framework.

## Key variants or extensions
- **Eval-driven PM** — the corresponding PM skill: crafting model evaluations to detect when a capability threshold has been crossed and to systematically close the gap to 100% accuracy. Framed by [[cat-wu]] as a core emerging competency for AI product managers.
- **Co-Work vs Claude Code split** — a product-level expression of threshold logic: Claude Code targets code output (where model capability is sufficiently reliable); Co-Work targets non-code knowledge workflows (documents, email, calendar coordination) where a different capability surface is required.

## Limitations and open questions
- The 100% accuracy threshold is practically unattainable for many task types; what the heuristic likely means is "no residual errors in the modal failure class" rather than literal perfection.
- Removing UI crutches creates regression risk: users who relied on the scaffold for legibility may experience worse outcomes on boundary cases even when average performance improves.
- The design loop (capability improves → audit crutches → remove → iterate) requires close model–product team coupling; at larger organisations this coupling degrades.

## Key sources
- [[2026-05-cat-wu-anthropic-product-velocity]] — primary articulation of the crutch-removal principle and 100% accuracy rule, with timestamps
