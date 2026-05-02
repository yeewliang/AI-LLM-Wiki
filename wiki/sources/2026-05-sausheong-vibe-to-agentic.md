---
type: source
title: From vibe coding to agentic engineering
author: [[sausheong-chang]]
date: 2026-05-02
url: https://sausheong.com/
ingested: 2026-05-02
tags: [agentic-engineering, vibe-coding, government, governance, platform-engineering, supervisory-engineering]
---

# From vibe coding to agentic engineering

## Core argument
AI is not merely accelerating software engineering — it is restructuring its bottlenecks, artefacts, and team shapes. Engineering capacity is no longer scarce; decision speed is. Code may cease to be the primary durable artefact, with specifications and decision history overtaking it. Team composition is collapsing toward solo-to-scale. The author, writing from [[govtech-singapore]], maps these shifts onto Dan Shapiro's [[five-levels-of-ai-engineering]] framework and outlines GovTech's strategic response, branded "vibe coding to agentic engineering."

## Key concepts introduced or used
- [[agentic-engineering]] — multi-step AI execution at Level 2–3 of the Shapiro framework; positioned as a *transitional* phase between [[vibe-coding]] and full agent orchestration, not an end state.
- [[five-levels-of-ai-engineering]] — Shapiro's progression: spicy autocomplete → AI coding assistants → autonomous agents → collaborative agent networks → software factory.
- [[supervisory-engineering]] — emerging core competency: directing, evaluating, correcting AI output; reasoning at system level rather than line level.
- [[vibe-coding]] — non-technical builders shipping working software via AI; recognised as both opportunity and unsanctioned risk inside government.
- [[platform-as-trojan-horse]] — encoding governance, security, and quality into the platform itself rather than relying on policy compliance.

## Notable claims or data points
- "Humanity is not ready for this much software." (attributed conversation partner) — agents now produce work faster than humans can review, customers can absorb, or organisations can adapt.
- The bottleneck inversion: building was historically the long pole; approval and review are now the long pole. Government procurement, security review, data-governance review, compliance sign-off chains were designed assuming engineering took longer than deciding.
- Three durable shifts: (1) decision speed becomes the bottleneck; (2) the durable artefact may be the specification + decision history rather than code; (3) team structures shrink dramatically (solo-to-scale).
- "AI amplifies existing conditions. It doesn't create them. Strong teams become faster and dysfunctional teams become more chaotic." — there is a "you must be this tall for AI" readiness threshold (clear standards, organised data, governance maturity).
- **Brownfield reality**: lambda-heavy, hidden-coupling, decade-evolved legacy systems make AI rewrites *more* dangerous, not less, because cascading downstream impact is invisible. AI maturity is gated by *system* maturity (observability, dependency mapping, documentation).
- **Resistance pattern in seniors** (Java/C analogy): senior engineers tend to use AI tools the way they use Stack Overflow — slotting agents into existing workflows rather than restructuring around them — and conclude AI is overhyped. "Exposure to AI tools won't drive transformation" without structured intervention.
- **Junior engineer thesis** (counter to the prevailing "AI eliminates juniors" narrative): juniors are *more* viable, not less. They lack legacy habits, are willing to make mistakes (essential in stochastic systems), and learn supervisory skills natively.
- **Alien intelligence principle**: agents do not learn like humans. Front-loading instructions has diminishing returns. Let agents fail, then build skills from observed failures — failures are the signal.
- **Code review tiering**: line-by-line review breaks at AI-generated volume; emerging answer is risk-tiered (rebuild cost × failure impact) with formal verification, specification review, and AI-assisted review on high-risk paths.
- **Vendor and SaaS disruption**: capacity-based vendor value proposition collapses when 5 internal engineers + AI match 20 vendor engineers. "Subset of features" SaaS purchases (using ~20% of a product) become candidates for custom AI-built replacements.
- **GovTech tooling stack**: *Agent Prime Directives* (centrally curated context packs / skills / prompts, locally consumed); *Prelude* (in-house AI code review — ~50% of comments rated useful by engineers); *Graphiqode* (legacy codebase analysis → dependency graphs → docs → AI-assisted modernisation, embodying "conceptual model as source of truth"); *Backstage* (service catalogue); *Astrolabe* (engineering metrics).
- **GovTech standardised AI tools**: Copilot and [[claude-code]], with proposed credit allocation per engineer per month; preferred tool installed by default on developer devices.
- "Code is not the same classification as system data" — separation of concerns enables tool usage with appropriate guardrails per tier; "governance as graph traversal" framing for compliant agent configurations.

## Relationship to existing wiki
- Massively extends [[vibe-coding]] coverage with organisational, governance, and team-structure consequences absent from prior sources (which framed it primarily as a programming style).
- Introduces [[agentic-engineering]] and [[supervisory-engineering]] as named phases beyond vibe coding — adjacent to but distinct from the [[llm-wiki-pattern]]'s "third phase" framing.
- Adds [[five-levels-of-ai-engineering]] as a structuring framework for the field as a whole; useful for placing future sources.
- Introduces [[govtech-singapore]] and the practitioner [[sausheong-chang]] to the entity layer.
- Reinforces the supervisory/abstraction-erosion concern noted in the [[improving-vibe-coding]] synthesis.

## Quality assessment
Strong first-person account from a senior practitioner inside a government engineering organisation actively deploying these tools at scale. Mixes industry observation, internal data points (Copilot merge-request doubling; Prelude review acceptance ~50%), and explicit strategy. Bias toward government and platform-engineering perspective; thin on counter-evidence (e.g., does not seriously engage cases where AI-assisted seniors *do* outperform AI-native juniors). Several internal product names (Prelude, Graphiqode, Astrolabe, Agent Prime Directives) are proprietary GovTech tooling and unverifiable externally. Useful as a high-confidence diagnosis of the *shape* of the transition rather than a settled prescription.
