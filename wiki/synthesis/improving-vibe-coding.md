---
type: synthesis
title: Improving Vibe Coding
covers: [[vibe-coding]], [[andrej-karpathy]]
tags: [llm, workflow, code-generation, practice]
created: 2026-05-02
updated: 2026-05-02
---

# Improving Vibe Coding

## The question or tension

[[vibe-coding]] offers significant productivity gains by shifting the bottleneck from implementation to intent specification. However, the current practice has documented limitations: code complexity accretion, difficulty in security review when the developer does not fully understand generated code, and degraded effectiveness on novel or mathematically precise problems. How can developers mitigate these risks while preserving the productivity gains?

## The landscape

The [[vibe-coding]] page identifies two key variants:

**Supervised vibe coding**: The developer reviews every change before accepting. This functions as an amplifier for experienced engineers who can quickly assess correctness. It preserves visibility into the generated code and maintains security review capability, but reduces velocity compared to unsupervised vibe coding.

**Unsupervised vibe coding**: The developer prompts and runs without review. This maximizes speed but accumulates technical debt and introduces hard-to-diagnose bugs. [[andrej-karpathy]] has acknowledged sometimes running code he does not fully understand.

## Key distinctions

The fundamental trade-off is **velocity vs. understanding**. The choice between supervised and unsupervised vibe coding reflects the developer's confidence in the problem domain, the LLM's training coverage, and the risk tolerance of the system being built.

**Supervised vibe coding** is most appropriate for:
- Production systems where correctness is non-negotiable
- Novel domains where the LLM's training coverage is uncertain
- Security-sensitive code paths
- Mathematically precise or domain-specific problems where local optimization can mask global architectural debt

**Unsupervised vibe coding** is most appropriate for:
- Prototyping and exploration where iteration speed matters more than correctness
- Well-understood domains where the LLM has high training coverage (common web frameworks, data transformations)
- Internal tools and scripts with limited blast radius

## Implicit improvement strategies (from the limitations)

The [[vibe-coding]] page identifies specific failure modes that suggest mitigation approaches:

1. **Complexity accretion without refactoring**: Vibe coding optimizes locally. Mitigation: periodically prompt the LLM for global refactoring passes; schedule architecture reviews; maintain a separate "technical debt" section in code or docs that the LLM can reference.

2. **Security review difficulty**: When the developer does not fully understand generated code, security review becomes shallow. Mitigation: for security-critical code, use supervised vibe coding exclusively; ask the LLM to explain or document its security assumptions; use code scanning tools (static analysis, SAST) as a complementary control.

3. **Degraded effectiveness on novel problems**: LLM performance falls off-distribution. Mitigation: break novel problems into well-understood subproblems; provide the LLM with reference implementations or papers; use vibe coding for boilerplate and hand-write the novel logic; iterate with the developer providing detailed architectural direction.

## State of the field

As of May 2026, the field has no empirical data on whether vibe coding produces maintainable production systems at scale. The [[andrej-karpathy]] entity page reports that Karpathy is now spending significant effort on the [[llm-wiki-pattern]] (AI-managed knowledge) rather than continuing with vibe coding directly. This suggests he may view knowledge curation as a higher-return use of AI than code generation—though this remains interpretation rather than direct statement.

The most credible practitioner account ([[kosuri-2026-llm-wiki-build]]) focuses on knowledge bases rather than vibe-coded applications, leaving open the question of whether vibe-coded systems achieve production quality.

## Open questions

- At what scale does complexity accretion become unmaintainable? (100 lines? 10k? 100k?)
- Does supervised vibe coding (with full code review) produce security equivalent to hand-written code at the same velocity?
- Can refactoring prompts be effective enough to prevent architectural drift, or does vibe coding require periodic human-driven refactoring?
- What is the minimum code review skill required to safely accept vibe-coded output?

## Sources

- [[vibe-coding]] — Definition, variants, and documented limitations
- [[andrej-karpathy]] — Originator of the term; current status as of April 2026
- [[kosuri-2026-llm-wiki-build]] — Practitioner account showing LLM utility in knowledge systems (not code generation)
