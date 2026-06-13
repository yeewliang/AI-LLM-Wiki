---
type: concept
title: Vibe Coding
aliases: [vibe coding, intent-driven programming]
tags: [llm, workflow, code-generation, agents]
related: [[andrej-karpathy]], [[llm-wiki-pattern]], [[agentic-engineering]], [[five-levels-of-ai-engineering]], [[supervisory-engineering]], [[harness-engineering]]
created: 2026-05-02
updated: 2026-06-13
---

# Vibe Coding

## What it is
A style of software development coined by [[andrej-karpathy]] in February 2026 in which the developer describes intent in natural language and an LLM generates the implementation. The developer's role shifts from writing code to specifying behaviour, reviewing output, and accepting or rejecting changes — "going with the vibe" rather than dictating exact syntax.

## How it works
The developer states what they want in natural language (a feature, a bug fix, a refactor). The LLM — typically accessed through an AI-native editor like Cursor or an agent like Claude Code — generates the corresponding code changes across one or more files. The developer reviews diffs, accepts or requests revisions, and iterates. The feedback loop is: intent → LLM output → human review → next intent.

Vibe coding does not require understanding every line of generated code, which is both its key affordance and its primary risk.

## Why it matters
Reframes the bottleneck of software development: from knowing how to write code to knowing what to build. Lowers the barrier to prototyping significantly — non-developers can produce working code for well-specified problems. Enables developers to operate at a higher level of abstraction, delegating boilerplate and mechanical transformations to the LLM.

Karpathy positioned vibe coding as the first of three phases of human-AI collaboration: (1) vibe coding (AI writes code), (2) agentic engineering (AI executes multi-step tasks), (3) AI manages knowledge (the [[llm-wiki-pattern]]). This "three phases" framing is attributed to Karpathy via secondary sources; treat as editorial interpretation until a direct citation is confirmed.

A parallel progression frames vibe coding as the stage before [[harness-engineering]]: Prompt Engineering → Vibe Coding → Harness Engineering. In that framing vibe coding's low ceiling on large or multi-person codebases is the signal to move to harness engineering — designing the constraint system the agent works within rather than asking for better output.

## Key variants or extensions
- **Supervised vibe coding**: Developer reviews every change before accepting; functions as an amplifier for experienced engineers who can quickly assess correctness.
- **Unsupervised vibe coding**: Developer prompts and runs without review; fast but accumulates technical debt and introduces hard-to-diagnose bugs. Karpathy himself noted he sometimes runs code he does not fully understand.

## Limitations and open questions
- Generated code tends to accrete complexity without refactoring; the LLM optimises locally and does not track the global architecture.
- Security review is harder when the developer does not fully understand the generated code.
- Effectiveness degrades on novel, domain-specific, or mathematically precise problems where the LLM lacks training coverage.
- Whether vibe coding produces maintainable production systems at scale remains an open empirical question as of 2026.

Beyond the programming-style framing, vibe coding now also refers to the *organisational phenomenon* of non-technical staff (product managers, designers, policy officers) shipping working software with AI assistance — extending Level 1 capability to people who would not previously have written code. This sits at the entry of the [[five-levels-of-ai-engineering]] progression and motivates the [[platform-as-trojan-horse]] response: extend governance and review to builders who have no engineering training.

## Key sources
- [[andrej-karpathy]] — coined the term February 2026; described as a natural consequence of LLM capability reaching the threshold where intent specification is faster than implementation
- [[2026-05-sausheong-vibe-to-agentic]] — Extends vibe coding to organisational and governance consequences; situates it as Level 1 in the [[five-levels-of-ai-engineering]] framework
