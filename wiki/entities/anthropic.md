---
type: entity
entity_class: organisation
title: Anthropic
aliases: []
tags: [ai-lab, frontier-lab, llm, alignment]
related: [[claude-code]]
created: 2026-05-02
updated: 2026-05-02
---

# Anthropic

## Overview
AI safety company and frontier lab. Vendor of the Claude model family (Opus, Sonnet, Haiku tiers) and of [[claude-code]], the terminal-native agentic coding tool. Founded by former OpenAI researchers; positions itself around alignment and interpretability research alongside frontier model development.

## Why this entity matters to AI
One of the small set of frontier labs producing top-tier general-purpose LLMs. As of mid-2026 the Opus line is the model behind serious agentic engineering deployments via [[claude-code]]. Anthropic's product surface — Claude Code's hook system, deferred permissions, MCP server ecosystem, tool-search lazy loading — has materially shaped how teams structure agent-driven workflows.

## Key works / outputs
- Claude model family (Opus / Sonnet / Haiku tiers); Opus 4.7 current as of May 2026 with a tokenizer change that inflates existing prompts by roughly 1.0–1.35×
- [[claude-code]] — agentic coding CLI
- Public documentation on tool-search lazy loading, deferred permissions, and MCP server annotations

## Affiliations and relationships
- Competes with OpenAI, DeepMind, Meta AI, Mistral in the frontier LLM space
- Co-developer / supporter of the [[model-context-protocol]] ecosystem

## Current status / latest developments
Active model and tooling development as of mid-2026: Opus 4.7 release with tokenizer change; April 2026 Claude Code release adding the `PermissionDenied` hook and deferred-permission semantics; MCP server-side `anthropic/maxResultSizeChars` annotation.
