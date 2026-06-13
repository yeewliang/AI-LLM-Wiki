---
type: concept
title: Ralph Loop
aliases: [Ralph mode, ralph, autonomous agent loop]
tags: [agents, agentic-engineering, automation, workflow]
related: [[harness-engineering]], [[agent-harness]], [[agent-compaction]], [[agentic-engineering]], [[claude-code]]
created: 2026-06-13
updated: 2026-06-13
---

# Ralph Loop

## What it is
An autonomous AI agent loop that runs repeatedly until all items in a product requirements document (PRD) are complete. Each iteration starts from a **cleared context**, reads the PRD, performs one task, commits, and exits — then the loop restarts. Named after Ralph Wiggum from *The Simpsons*: very focused on one thing at a time, with no view of the bigger picture. Reference implementation: `snarktank/ralph`.

## How it works
The mechanism is deliberately minimal — a bash loop wrapping a single agent invocation:

```bash
while ! task_complete; do
  claude "Read the PRD, complete the next unfinished task, commit."
done
```

Each iteration:
1. Spawns a fresh agent session with **no carried-over context** from the previous iteration.
2. The agent reads the PRD (the durable state) to discover what remains.
3. Completes exactly one task.
4. Commits the result to the repo.
5. Exits; the loop re-evaluates the completion condition and restarts if work remains.

The clean-context-per-iteration design is the crux: progress lives entirely in the repo (the PRD and committed code), not in conversation history. This sidesteps context-window growth and [[agent-compaction]] entirely — there is nothing to compact because each iteration is short-lived.

## Why it matters
Ralph is the minimal embodiment of [[harness-engineering]] principles. Because all state is in the repo and each run starts clean, it directly realises **Repo as System of Record** — the agent cannot rely on anything not committed. Its six tenets map onto the harness-engineering principles, making it a useful concrete reference for what "the harness, not the prompt, carries the work" means in practice.

It also demonstrates a throughput-oriented stance: rather than one long, stateful session that accumulates baggage and drifts, many short stateless sessions each do one verifiable unit and commit.

## Key variants or extensions
- **PRD-driven completion** — the loop's terminating condition is "all PRD items done," making the PRD both the work queue and the source of truth.
- **Per-iteration verification** — stronger variants run tests or linters inside each iteration before committing, so a failed task does not advance the queue (cf. the constraint tests in [[harness-engineering]]).
- **Harness-agnostic** — the pattern is independent of the underlying agent; `claude` in the example is interchangeable with any agent CLI.

## Limitations and open questions
- **No global view** — by design the agent never holds the whole picture; cross-cutting changes that require coordinating many tasks at once fit poorly.
- **PRD quality is the ceiling** — if the PRD under-specifies a task, the clean-context agent has no conversational nuance to fall back on.
- **Cost** — re-reading the PRD and re-establishing context every iteration trades token cost for statelessness; economics depend on task granularity.
- **Loop-control robustness** — defining a reliable, machine-checkable `task_complete` condition is non-trivial for open-ended work.

## Key sources
- [[2026-05-harness-engineering-next-upgrade]] — Introduces Ralph mode as the autonomous-completion extension of harness engineering; cites `snarktank/ralph`
