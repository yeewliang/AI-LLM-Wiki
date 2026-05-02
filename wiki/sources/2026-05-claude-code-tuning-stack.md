---
type: source
title: I Spent 6 Months Tuning Claude Code. Here's the Exact Setup That Finally Worked.
author: unattributed (levelup.gitconnected / Medium)
date: 2026-05-02
url: https://levelup.gitconnected.com/i-spent-6-months-tuning-claude-code-heres-the-exact-setup-that-finally-worked-b41c67628478
ingested: 2026-05-02
tags: [claude-code, agentic-engineering, configuration, mcp, hooks, skills, subagents]
---

# I Spent 6 Months Tuning Claude Code

## Core argument
The productivity differential between [[claude-code]] users is not in the prompts they type — it is in the *configuration stack*. Users with a properly tuned `.claude/` directory ship features in tens of minutes that take un-configured users an afternoon. The author proposes a concrete eight-layer stack — short imperative root memory, path-scoped rules, plan mode, subagents, skills, hooks, a small MCP server set, and parallel worktrees + headless mode — illustrated through a citation-backed retrieval feature shipped in the example RAG service.

## Key concepts introduced or used
- [[claude-code]] — the agent under tuning; rich configuration surface area
- [[claude-code-configuration]] — the eight-layer stack as a coherent concept
- [[model-context-protocol]] — the connection layer between the agent and external tools; tool schemas consume context tokens on every turn
- [[agentic-engineering]] — the article is essentially a power-user guide to agentic engineering with this specific agent

## Notable claims or data points
- **Memory hierarchy**: five levels — personal preferences (home dir), project root file, path-scoped rules, local uncommitted overrides, automatic memory tool. The project root file is loaded every session and burns tokens permanently.
- "Cache hit rates drop noticeably past ~500 tokens" in the author's workloads; recommends keeping CLAUDE.md under 200 lines and strictly imperative ("all functions must have TypeScript type annotations" — not "write clean code").
- **Opus 4.7 tokenizer change**: existing prompts map to roughly **1.0×–1.35×** more tokens than before — the same workload is more expensive without disciplined ambient-context control.
- **Path-scoped rules** use YAML frontmatter with glob arrays. Rules load only when matching files are touched; zero token cost otherwise. Documented schema key is `paths:` but a known bug sometimes drops it — `globs:` or CSV format is more reliable in practice.
- **Plan Mode** has three tiers: Simple (single file), Visual (multi-file), Deep (multi-service / risk-bearing refactors). Deep Plan uses a *read-only-by-design* planning subagent — explicitly denied write/edit permissions.
- **Subagents**: built-in (explore, general-purpose, code-reviewer, code-architect) plus custom. Custom subagents specify `tools:` allowlists and `model:` (e.g. downshift to Sonnet to keep main loop on the expensive model). Defined in `.claude/agents/<name>.md` with YAML frontmatter and a system prompt body.
- **Skills**: folder + `SKILL.md` with frontmatter (`name`, `description`, `allowed-tools`); rely on **progressive disclosure** — metadata loads at session start, instructions load on trigger, bundled resources load on reference. Keeps ambient cost low even with many skills installed.
- **Hooks** (configured in `settings.json`): events include `PreToolUse`, `PostToolUse`, `SessionStart`, `UserPromptSubmit`, and (April 2026) `PermissionDenied`. The major April 2026 addition is **Deferred Permissions**: a pre-tool hook returns `{"permissionDecision": "defer"}`, the agent pauses mid-run in headless mode, a human approves out-of-band, the agent resumes via `claude --resume <session_id>`. Eliminates the prior `--dangerously-skip-permissions` vs. failed-job choice for nightly automations.
- **MCP servers**: tool schemas cost tokens every turn. Anthropic's tool-search documentation: 50 tools = 10–20k tokens/turn without lazy loading; tool-search lazy loading reduces by ~85%, but fewer servers is still better. Recommended five: a code-graph server with persistent session memory (`vexp`), GitHub, filesystem, brave-search, context7.
- **`vexp` claim**: 65–70% token reduction on long-running agent setups (vexp's published benchmarks).
- **April 2026 MCP feature**: servers can set `anthropic/maxResultSizeChars` annotation in a tool's `_meta` to keep large doc pulls inline rather than forcing file-write workarounds.
- **Parallel worktrees**: separate branch + worktree + isolated session per task slice; reduces merge conflicts when tasks are scoped to distinct domains (e.g. evals in one pane, core logic in another).
- **Headless mode in CI**: `claude -p --bare --output-format stream-json --allowedTools ...`; pairs with deferred-permission hooks for safe production-pushing automations.

## Relationship to existing wiki
- Provides the first deeply technical reference for [[claude-code]] configuration; promotes it from passing-mention status to a fully scoped tool entity.
- Concretises [[agentic-engineering]] beyond the conceptual: shows the actual configuration surface (rules, plan mode, subagents, skills, hooks, MCP, worktrees, headless) that a serious team operates.
- Introduces [[model-context-protocol]] as a first-class concept with token-economics implications for agent design.
- Quantifies guidance previously stated only qualitatively in [[2026-05-sausheong-vibe-to-agentic]] (e.g. that platform/agent context engineering matters): 500-token cache-hit threshold, 1.0–1.35× tokenizer inflation, 65–70% vexp savings, 85% tool-search reduction.

## Quality assessment
Highly technical, opinionated, and concrete. Strong on artefacts (full CLAUDE.md, full subagent file, full skill file, full hooks JSON, full GitHub Actions workflow) — the kind of content that survives well as wiki reference material. Weak on independent verification: most quantitative claims (cache thresholds, vexp savings, the Opus 4.7 tokenizer multiplier) are stated without citation or are the vendor's own benchmarks. Treat the artefacts as canonical patterns and the numbers as plausible-but-unverified. The author's "five servers exactly" prescription is opinionated; the underlying principle (tool schemas are not free) is sound. April 2026 features (`PermissionDenied` hook, deferred permissions, `anthropic/maxResultSizeChars`) should be cross-checked against current Claude Code release notes before relying on them.
