---
type: concept
title: Supervisory Engineering
aliases: [supervising agents, agent supervision]
tags: [software-engineering, agents, workflow, role]
related: [[agentic-engineering]], [[vibe-coding]], [[five-levels-of-ai-engineering]]
created: 2026-05-02
updated: 2026-05-02
---

# Supervisory Engineering

## What it is
The emerging core competency for software engineers in an agent-driven workflow: directing, evaluating, and correcting AI output rather than implementing line by line. Spans specification writing, acceptance-criteria definition, system-level reasoning, judgement on what to delegate to agents versus what to reserve for humans, and review of changesets the engineer did not author.

## How it works
The work is structurally different from implementation. Implementation rewards depth — holding a complex system in one head and working through it methodically. Supervision rewards breadth — evaluating correctness, security, performance, and requirements alignment across multiple workstreams concurrently. The metaphor that fits is air traffic controller, not craftsman.

In practice supervisory engineering involves:

- Translating a goal into a specification precise enough for an agent to implement correctly.
- Reviewing thousand-line changesets for subtle correctness issues that tests do not catch.
- Decomposing projects into agent-suitable tasks vs human-judgement tasks.
- Calibrating which AI outputs to trust, which to verify, and which to reject.
- Managing context switching across multiple parallel agent sessions.

The principle "fully trusting an LLM's answer is folly, but using LLMs to navigate toward an answer is wise" captures the stance: value lies in navigation, not destination.

## Why it matters
This is the skill AI cannot replace, and it is not taught by traditional CS curricula or current professional-development frameworks. As implementation is automated, the engineer's value migrates from *knowing how to build* to *knowing what should be built, whether the agent's output is trustworthy, and where the real risks lie*. It is a harder role, not an easier one.

## Key variants or extensions
- **Tiered review supervision**: rigour calibrated to rebuild cost × failure impact; specification review and formal verification on high-risk paths, lighter review on easily rebuilt code.
- **Code review as learning exercise**: deliberately preserved as the last point at which engineers are forced to engage deeply with what is being built, to counter abstraction erosion.
- **AI Development Centre model** (offshore-development analogue): humans review outputs rather than supervising every keystroke; agents handle routine work, humans focus on specification, architecture coherence, security, and compliance.

## Limitations and open questions
- **Burnout risk**: parallel agent supervision is inherently fragmented; cognitively expensive in a way deep-flow implementation is not.
- **Training gap**: no established curricula, career ladders, or job descriptions for the role; current professional-development frameworks remain organised around implementation skills.
- **Brittleness via abstraction**: engineers who never read code, never debug, and never design directly may become highly productive in normal conditions but helpless when something genuinely novel breaks.
- **Implementer ≠ supervisor**: a strong implementer can be a poor supervisor and vice versa; the two skills are correlated weakly enough that promotion pipelines based on implementation excellence may misallocate the role.

## Key sources
- [[2026-05-sausheong-vibe-to-agentic]] — Names supervisory engineering as the emerging competency; details burnout risk, abstraction erosion, and the lack of training pathways
