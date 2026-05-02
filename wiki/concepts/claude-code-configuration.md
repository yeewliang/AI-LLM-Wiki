---
type: concept
title: Claude Code Configuration Stack
aliases: [.claude directory, Claude Code stack, eight-layer stack]
tags: [claude-code, agentic-engineering, configuration, hooks, skills, subagents, mcp]
related: [[claude-code]], [[agentic-engineering]], [[model-context-protocol]], [[supervisory-engineering]]
created: 2026-05-02
updated: 2026-05-02
---

# Claude Code Configuration Stack

## What it is
The set of files under a repository's `.claude/` directory (plus settings and MCP config) that turn an out-of-the-box [[claude-code]] install into a power-user setup. The performance differential between users is dominated by this stack rather than by prompt skill — a tuned setup ships features in tens of minutes that an empty setup takes an afternoon for. Per [[2026-05-claude-code-tuning-stack]], eight layers compose the stack.

## How it works

**Layer 1 — Memory hierarchy.** Five levels: home-dir personal preferences; project root (`CLAUDE.md`); path-scoped rules; local uncommitted overrides; the automatic memory tool (per-session writes). The project root file loads every session and burns tokens permanently. Keep it under ~200 lines, strictly imperative ("all functions must have TypeScript type annotations" — *not* "write clean code"). Cache hit rates degrade past ~500 tokens. Under Opus 4.7 the same prompts now map to ~1.0–1.35× more tokens, so disciplined ambient context matters more than before.

**Layer 2 — Path-scoped rules.** YAML-front-matter files in `.claude/rules/` declaring glob arrays. The rule loads only when a matched file is touched; zero token cost otherwise. Three or four short rule files beat one large root file. (Documented schema key is `paths:`; a known bug sometimes drops it — `globs:` or CSV is more reliable in practice.)

**Layer 3 — Plan mode.** Three tiers — Simple (single file), Visual (multi-file), Deep (multi-service / risk-bearing). Deep Plan uses a *read-only-by-design* planning subagent explicitly denied write/edit. Plan mode separates exploration from mutation: explicit plan document → review → exit plan mode → mutation.

**Layer 4 — Custom subagents.** `.claude/agents/<name>.md` with YAML frontmatter (`name`, `description`, `tools` allowlist, `model`) and a system-prompt body. Custom subagents fit (a) repeating tasks, (b) roles needing tool restrictions, (c) system prompts that conflict with the main configuration. The `tools:` line is a narrow allowlist (e.g. `Read, Grep, Glob, Bash(git diff:*), Bash(uv run pytest:*)`); the `model:` line typically downshifts to Sonnet so the main loop keeps the expensive model for hard reasoning.

**Layer 5 — Skills.** `.claude/skills/<name>/SKILL.md` with frontmatter (`name`, `description`, `allowed-tools`). Architecture is **progressive disclosure**: metadata loads at session start, instructions on trigger, bundled resources on reference. Keeps ambient cost low even with many skills installed.

**Layer 6 — Hooks.** Configured in `settings.json`. Events: `SessionStart`, `UserPromptSubmit`, `PreToolUse`, `PostToolUse`, `PermissionDenied` (added April 2026). The major April 2026 addition is **Deferred Permissions**: a pre-tool hook returns `{"permissionDecision": "defer"}`, the agent pauses mid-run in headless mode, a human approves out-of-band, the agent resumes via `claude --resume <session_id>`. Replaces the prior "all-or-nothing" choice between `--dangerously-skip-permissions` and a failed nightly job. The highest-ROI hook is a one-liner post-tool formatter (e.g. `ruff format $CLAUDE_TOOL_FILE_PATH`) — keeps file state clean turn-to-turn.

**Layer 7 — MCP servers.** See [[model-context-protocol]]. Tool schemas are not free — 50 tools without lazy loading is 10–20k tokens/turn; tool-search lazy loading reduces ~85%, but a smaller server set is still better. The recommended canonical five: a code-graph server with persistent session memory (e.g. `vexp`, claimed 65–70% token reduction on long-running setups), GitHub, filesystem, brave-search, context7.

**Layer 8 — Parallel worktrees + headless mode.** A single command creates a branch + worktree + isolated session per task slice; concurrent panes operate on distinct domains (evals in one, core logic in another) to minimise merge conflicts. Headless mode (`claude -p --bare --output-format stream-json --allowedTools "..."`) runs the agent non-interactively in CI; pairs with deferred-permission hooks for safe production-pushing automations (e.g. nightly eval → draft PR with regression fix).

## Why it matters
The stack is the workflow; the workflow is the multiplier; the prompt is the last 5%. Each layer has a specific cost-control role: keeping ambient context tiny (memory + rules + skills progressive disclosure), keeping risky work out of the main loop (plan mode + subagents), making the probabilistic system safe to run unattended (hooks + deferred permissions), keeping tool integration honest about token economics (MCP), and parallelising attention (worktrees + headless).

This is the operational substrate for [[supervisory-engineering]]: it is the configuration that makes it possible to direct multiple agents simultaneously without each one drowning in token cost or running unsafe operations unsupervised.

## Key variants or extensions
- **Minimum viable stack** (per the article's "Floor and Ceiling"): short imperative root memory; two path-scoped rule files for the most-edited directories; one formatting hook; three MCP servers (repo, filesystem, library docs); plan mode for any risky task. Add subagents when a task repeats; add skills when a workflow stabilises; add worktrees when branch-switching exceeds twice per hour; add headless mode when shipping while you sleep.
- **Headless CI integration**: GitHub Actions runs `claude -p --bare --output-format stream-json --allowedTools "..."`; pipeline parses NDJSON for `permissionDecision: defer`, captures session ID, pauses; a human approves; a follow-up step runs `claude --resume "$SESSION_ID"` to finish.

## Limitations and open questions
- **Long-running context rot**: even a tuned stack struggles when the context window slowly fills with outdated observations across long tasks. Compaction and tool-result clearing are open problems flagged for future work.
- **Schema-key drift**: documented vs. actual frontmatter keys (e.g. `paths:` vs `globs:`) silently break rule loading; canonical configuration cannot be assumed stable.
- **Vendor-cited numbers**: 65–70% vexp savings, 85% tool-search reduction, 1.0–1.35× tokenizer inflation — plausible but largely from the vendors themselves. Independent verification is sparse.

## Key sources
- [[2026-05-claude-code-tuning-stack]] — full eight-layer walkthrough with concrete artefacts (CLAUDE.md, rule file, subagent, skill, hooks JSON, gate shell script, GitHub Actions workflow)
