---
type: entity
entity_class: person
title: Martin Fowler
aliases: []
tags: [software-engineering, architecture, agentic-engineering]
related: [[harness-engineering]], [[agent-harness]]
created: 2026-06-13
updated: 2026-06-13
---

# Martin Fowler

## Overview
Software engineer and author, long associated with Thoughtworks, known for influential work on refactoring, enterprise application architecture, continuous integration, and microservices. In the AI-agent era his team produced a precise definition of the [[agent-harness]] that grounds the [[harness-engineering]] discipline.

## Why this entity matters to AI
Fowler's team gave the [[agent-harness]] an engineering definition that promotes it from "a block of explanatory text" to a designable, versionable, evaluable object:

> harness = system prompt + Context Management + Tool Use + Evaluation Loop

All four components are required; missing any one leaves the agent unbounded on that dimension and bound to fail there eventually. This four-part decomposition is the conceptual backbone of [[harness-engineering]] and complements the build-vs-buy and engine-vs-vehicle framings of [[agent-harness]] from other sources.

## Key works / outputs
- Harness Engineering essay (martinfowler.com/articles/harness-engineering.html) — defines the four-component harness and the principles underpinning [[harness-engineering]].
- Pre-AI body of work: *Refactoring*, *Patterns of Enterprise Application Architecture*, and widely cited writing on continuous integration and microservices (context for his architectural authority).

## Affiliations and relationships
- Long-time Thoughtworks fellow.
- His harness definition is cited alongside OpenAI's harness-engineering writeup and the work of [[ryan-lopopolo]] in [[2026-05-harness-engineering-next-upgrade]].

## Current status / latest developments
As of 2026 his team's harness-engineering framing is a primary reference for the constraint-system stance in agentic development. See [[harness-engineering]] for how the four-component definition maps onto the six core principles and three constraint tests.
