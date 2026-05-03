---
type: entity
entity_class: tool
title: Claude Code
aliases: [claude-code]
tags: [agent, cli, anthropic, agentic-engineering]
related: [[agentic-engineering]], [[claude-code-configuration]], [[model-context-protocol]], [[anthropic]], [[capability-threshold-product-design]], [[cat-wu]], [[agent-compaction]], [[agent-harness]], [[prompt-cache-stability]]
created: 2026-05-02
updated: 2026-05-03
---

# Claude Code

## Overview
Anthropic's terminal-native agentic coding tool. Operates as a CLI rather than an IDE plugin — part of a broader 2026 trend of the terminal re-emerging as the primary interface for AI-assisted software development. Configured per-repository through a `.claude/` directory of memory files, rules, agents, skills, hooks, and MCP server declarations.

## Why this entity matters to AI
Has emerged as the dominant agentic coding tool in industry conversations as of mid-2026, with traditional IDE-based assistants (Copilot, Windsurf, GitLab Duo) losing centrality in technical discussion. Adopted as a standard offering by [[govtech-singapore]] alongside Copilot. Some GovTech engineers have organically stopped writing code by hand entirely, relying on Claude Code with their Agent Prime Directives context pack.

Claude Code is the canonical implementation point for [[agentic-engineering]] practices: plan mode, custom subagents with tool allowlists, skills with progressive disclosure, hooks (including deferred permissions for safe headless automation), and MCP-driven external tool integration. It is also the most common viewer/maintainer reference for the [[llm-wiki-pattern]] (alongside [[cursor]]).

## Key works / outputs
- The Claude Code CLI — the tool itself
- `.claude/` configuration surface area — see [[claude-code-configuration]] for the full eight-layer stack (memory, rules, plan mode, subagents, skills, hooks, MCP, worktrees + headless)
- April 2026 release: `PermissionDenied` hook event; **Deferred Permissions** (pre-tool hooks can pause an agent mid-run for out-of-band human approval); MCP `anthropic/maxResultSizeChars` annotation
- Tool-search lazy loading documentation: notes that 50 tools without lazy loading consume 10–20k tokens/turn, reduced by ~85% with lazy loading

## Affiliations and relationships
- [[anthropic]] — vendor
- Used as the agent layer in [[llm-wiki-pattern]] implementations (CLAUDE.md schema)
- Adopted by [[govtech-singapore]] as a standardised tool
- Competes with [[cursor]], Windsurf, GitHub Copilot in the agentic coding space

## Product surface details
CLI vs Desktop distinction (per [[cat-wu]], May 2026):
- **CLI** — recommended for rapid code tasks where visual output is not needed
- **Desktop app** — recommended for frontend development; allows visual preview of web apps in-browser, making UI iteration viable without a separate dev server
- **Co-Work** (separate Anthropic product, not Claude Code) — targets non-code workflows: document drafting, inbox zero, presentation generation; integrates with Slack, Gmail, Google Drive

Product design follows [[capability-threshold-product-design]]: UI features are added to compensate for model limitations and removed as models outgrow the need. Example: older models required a structured to-do list UI to complete large refactors; current models hold context natively — the UI was removed.

## Compaction stack
[[agent-compaction]] details (from source-code analysis in [[2026-05-sausheong-own-your-harness]]):
- **Trigger**: reactive; fires when within 13,000 tokens of context window; fallback catches `prompt_too_long` 413 errors
- **cachedMicrocompact**: proprietary `cache_edits` API feature; surgically removes stale tool results from server-side cached prompt without invalidating the prefix; allowlisted tools: Read, Bash, Grep, Glob, Edit, Write, WebSearch, WebFetch; time-based variant clears stale results after 60min idle
- **Sliding window**: "snip" — drops oldest middle messages when context swells
- **LLM summarisation**: single call, 20K-token output cap (p99.99 of historical lengths ~17,387 tokens); streamed; runs via `runForkedAgent` inheriting parent's prompt-cache prefix → mostly cache hit
- **Session memory file**: 10-section markdown file updated by sandboxed forked subagent (Edit-on-one-file only); when non-empty at compaction time, replaces LLM summarisation entirely
- **Summary schema**: 9-section narrative; verbatim next-step quotes required (defence against post-compaction task drift); no-tools preamble added after Sonnet 4.6 attempted tool calls 2.79% of the time vs 0.01% on Sonnet 4.5
- **Failure recovery**: 3-retry circuit breaker calibrated against "1,279 sessions with 50+ consecutive failures, wasting ~250K API calls/day globally"; lossy truncation fallback

## Current status / latest developments
As of May 2026, on the Opus 4.7 model line (with a tokenizer change that maps prior prompts to roughly 1.0–1.35× more tokens — strict ambient-context control matters more under the new model). Active development: deferred-permission hook semantics, MCP server-side annotations for inline doc handling, tool-search lazy loading. Source code leak incident (human + Claude collaborating on a PR) led to hardened internal safeguards.
