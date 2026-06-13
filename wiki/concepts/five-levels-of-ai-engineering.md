---
type: concept
title: Five Levels of AI Engineering
aliases: [Shapiro five levels, AI engineering levels]
tags: [framework, software-engineering, agents, governance]
related: [[vibe-coding]], [[agentic-engineering]], [[supervisory-engineering]], [[harness-engineering]]
created: 2026-05-02
updated: 2026-06-13
---

# Five Levels of AI Engineering

## What it is
A staged framework attributed to Dan Shapiro for situating teams and organisations along the trajectory of AI in software development. Used to make deliberate choices about where to invest, what governance to apply, and which transitions to attempt — rather than being swept toward the highest level uniformly.

## How it works
The levels are progressive but not uniformly applicable; different parts of an organisation can and should operate at different levels simultaneously, with governance matched to capability.

| Level | Name | Description |
|---|---|---|
| 1 | "Spicy autocomplete" | AI suggests completions in the developer's current context (e.g. early GitHub Copilot). Developer fully in control. |
| 2 | AI coding assistants | AI executes multi-step tasks across files and tools (e.g. [[claude-code]], Cursor, Windsurf). Most government/enterprise teams transitioning here. See [[agentic-engineering]]. |
| 3 | Autonomous development agents | AI takes tickets from backlog to deployment independently. Humans define requirements and review outputs. Few organisations have reached this. |
| 4 | Collaborative agent networks | Multiple specialised agents collaborate on design, coding, testing, deployment. Humans orchestrate. Largely theoretical as of 2026. |
| 5 | Software factory | Organisations describe business outcomes; full systems emerge from agent collaboration. Humans focus on strategy and product. Theoretical endpoint. |

## Why it matters
Each level transition requires fundamentally different governance, risk management, and quality assurance. Applying Level 1 governance to Level 3 capability — or Level 3 review burden to Level 1 work — both fail. The framework's primary value is preventing the trap of treating AI adoption as a single dimension to maximise; instead, low-risk easily rebuilt systems can race ahead while critical infrastructure deliberately stays at Level 2 with stronger guardrails.

## Key variants or extensions
- **Multi-level operation**: Authoritative use is selecting a level *per system class*, not per organisation. A single agency may run Level 3 on internal dashboards and Level 2 on systems handling citizen data.
- **Distinction from "AI-assisted / AI-native / AI-first"**: those terms describe organisational posture, not capability level. An "AI-native" team has redesigned workflows around AI; an "AI-first" organisation has rebuilt its operating model. Each level can be reached with any of these postures, with different investment implications.

## Limitations and open questions
- The framework is descriptive, not predictive: it does not specify *when* a given system should advance.
- The boundary between Level 2 and Level 3 (autonomy threshold) is unsettled and depends heavily on review tiering, deferred permissions, and trust calibration.
- Levels 4–5 remain speculative; criteria for reaching them are undefined.

## Key sources
- [[2026-05-sausheong-vibe-to-agentic]] — Practitioner application of the framework to government engineering strategy
