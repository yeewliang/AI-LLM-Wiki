# Vibe Coding: Definition, Trajectory, and Organisational Implications

**Generated:** 2026-05-03
**Sources:** wiki/concepts, wiki/entities, wiki/synthesis — synthesised from all relevant pages

---

## 1. What Vibe Coding Is

[[andrej-karpathy]] coined "vibe coding" in February 2026 to describe a style of software development in which the developer specifies intent in natural language and an LLM generates the implementation. The developer's role shifts: no longer writing code, but specifying behaviour, reviewing output, and accepting or rejecting changes.

The feedback loop is: **intent → LLM output → human review → next intent.**

The core claim is a bottleneck inversion: the limiting factor in software development is no longer the ability to write code but the ability to specify what to build. This lowers the barrier to prototyping significantly — non-developers can produce working code for well-specified problems in familiar domains.

Karpathy acknowledged the risk explicitly: sometimes he runs code he does not fully understand. This is not a bug in his usage but a feature of the paradigm — and the source of its principal failure modes.

---

## 2. Two Variants

| | Supervised | Unsupervised |
|---|---|---|
| **Mechanism** | Developer reviews every diff before accepting | Developer prompts and runs without review |
| **Best for** | Production systems, security-sensitive paths, novel domains, mathematically precise problems | Prototypes, well-understood domains (common web frameworks, data transforms), internal tools with limited blast radius |
| **Risk** | Velocity reduced | Technical debt accumulates; hard-to-diagnose bugs; security review shallow |
| **Net** | Amplifier for experienced engineers | Speed maximiser with deferred cost |

Vibe coding does not specify which variant to use. The practitioner chooses based on confidence in domain coverage, LLM training overlap, and system risk tolerance. Most practitioners blend both, running unsupervised on boilerplate and supervised on critical paths.

---

## 3. Documented Failure Modes and Mitigations

Three failure modes are established in the literature:

**3.1 Complexity accretion without refactoring**
LLMs optimise locally. Across many vibe-coding sessions on a single codebase, the generated code accretes layers without global coherence. The model does not track architectural intent across sessions.

*Mitigation:* Schedule periodic global refactoring prompts. Maintain a technical-debt section in the project context file (e.g. CLAUDE.md) that the LLM consults on each session. Force architecture reviews at scale milestones.

**3.2 Security review degradation**
When the developer does not fully understand the generated code, security review becomes shallow. The reviewer cannot reason about what they did not write.

*Mitigation:* Supervised-only for security-critical code paths. Ask the LLM to surface and document its security assumptions. Treat static analysis and SAST scanners as mandatory complements, not optional add-ons. In organisational contexts, embed automated security scanning in the CI pipeline by default ([[platform-as-trojan-horse]]).

**3.3 Off-distribution degradation**
LLM performance degrades on problems where training coverage is thin — novel algorithms, domain-specific mathematical reasoning, undocumented legacy systems. The model generates plausible-looking but incorrect code in these regimes.

*Mitigation:* Break novel problems into well-understood subproblems and vibe-code those. Hand-write the genuinely novel logic. Provide reference implementations or papers as context. Use vibe coding for boilerplate; reserve the novel parts for explicit human authorship.

**Open empirical question:** whether vibe-coded systems achieve maintainable production quality at scale — 10k lines, 100k lines — has not been established as of May 2026. Practitioner accounts focus on prototypes and internal tools. The absence of evidence is itself a signal about where production risk remains.

---

## 4. The Progression: Vibe Coding → Agentic Engineering → Supervisory Engineering

Vibe coding is not a stable end state. It sits at Level 1 of the [[five-levels-of-ai-engineering]] (Shapiro) — "spicy autocomplete" operating at the single-completion level. The field is actively transitioning to Level 2–3: agentic engineering.

### 4.1 Five Levels

| Level | Name | Description | Status (2026) |
|---|---|---|---|
| 1 | Spicy autocomplete | AI suggests completions in developer's context | Ubiquitous |
| 2 | AI coding assistants | AI executes multi-step, multi-file tasks | Most teams transitioning here |
| 3 | Autonomous development agents | AI takes tickets to deployment independently | Few organisations |
| 4 | Collaborative agent networks | Multiple specialised agents collaborate | Largely theoretical |
| 5 | Software factory | Business outcomes → full systems from agents | Theoretical endpoint |

The framework's key insight: governance must match level. Level 1 governance applied to Level 2 work fails (under-controlled). Level 3 review burden on Level 1 work also fails (over-controlled). Different parts of an organisation can and should operate at different levels simultaneously — determined by system risk class, not organisational posture.

### 4.2 Agentic Engineering

At Level 2–3, the agent executes whole tasks: reading a codebase, editing multiple files, running tests, opening pull requests — under human direction. The scope expansion from single completions (vibe coding) to full tasks (agentic engineering) is the defining transition.

Effective agentic engineering depends on a **configuration stack**, not prompt skill alone:

- Short imperative project memory (CLAUDE.md ≤200 lines) — loads every session, token-permanent
- Path-scoped rules — load only when matched files are touched, zero cost otherwise
- Plan mode — separates read-only exploration from file mutation
- Custom subagents — narrow tool allowlists; cheaper models for repeating roles
- Skills — progressive disclosure; metadata costs, instructions on trigger only
- Hooks — deterministic guardrails over probabilistic agents; deferred permissions for risky operations
- MCP servers — canonical five: code graph, GitHub, filesystem, search, library docs; 50 unmanaged tools = 10–20k tokens/turn
- Parallel worktrees + headless — concurrent sessions on isolated task slices; CI-safe non-interactive runs

The stack is the workflow multiplier. The prompt is the last 5%.

### 4.3 Supervisory Engineering

The role that emerges from agentic engineering is not a faster implementation engineer — it is a fundamentally different role: **supervisory engineering**.

The work is:
- Translating goals into specifications precise enough for an agent to implement correctly
- Reviewing thousand-line changesets for subtle correctness issues that tests do not catch
- Decomposing projects into agent-suitable tasks vs. human-judgement tasks
- Calibrating which outputs to trust, verify, or reject
- Managing parallel agent sessions without fragmenting attention dangerously

The metaphor is air traffic controller, not craftsman. The skill rewards breadth (evaluating correctness, security, performance across multiple workstreams) rather than depth (holding one complex system in one head).

**Critical limitation:** no established curricula, career ladders, or job descriptions exist for this role as of May 2026. Current professional-development frameworks remain organised around implementation skills. Organisations promoting implementation-excellent engineers into supervisory roles may be systematically misallocating talent — the two skill profiles correlate weakly.

**Burnout risk** is under-acknowledged. Parallel agent supervision is cognitively expensive in a way deep-flow implementation is not. The fragmented attention profile of multi-agent management is inherently draining.

---

## 5. Organisational Consequences

### 5.1 Bottleneck Inversion

When agents can produce a working prototype overnight, the critical path shifts. Building is no longer the bottleneck. Deciding what to build and evaluating whether the output is correct and safe becomes the dominant cost.

Governance structures — procurement, security review, change-approval chains, committee review — were all designed assuming building took longer than deciding. They become rate-limiting the moment that assumption inverts.

### 5.2 Vibe Coding as Organisational Phenomenon

Vibe coding is not only a developer practice. It describes the broader phenomenon of non-technical staff — product managers, designers, policy officers — shipping working software with AI assistance. This extends what was previously Level 1 capability to people with no engineering training.

This creates a governance gap: builders operating outside engineering organisations, without code-review processes, security review, or deployment guardrails.

### 5.3 Platform as Trojan Horse

The organisational response is [[platform-as-trojan-horse]]: encode governance into infrastructure rather than relying on policy compliance. The platform makes the right thing the easy thing; the wrong thing hard or impossible. Compliance happens by default, not by discipline under deadline pressure.

Concrete instantiations (from GovTech Singapore's documented stack):
- Risk-tiered deployment pipelines (low-risk fast path; high-risk full scrutiny)
- Default-installed AI tooling on developer devices with shared context (Agent Prime Directives)
- AI-assisted code review embedded in CI by default (Prelude)
- Code classification separated from data classification — unlocking safer AI tool usage with appropriate per-tier guardrails
- Service catalogues (Backstage-class) tracking ownership, health, dependency graphs for both human and agent consumption

The principle generalises: when machines generate code faster than humans can review it, policy-only enforcement fails. The platform becomes the primary mechanism for quality control and security posture at agentic scale.

---

## 6. The Product-Side Lens: Capability-Threshold Design

[[capability-threshold-product-design]] (articulated by [[cat-wu]], Head of Product for Claude Code at Anthropic) provides a complementary view from the tooling vendor's side.

Two dynamics:

**Removing crutches.** As models improve, UI features added to compensate for prior limitations become unnecessary and are removed. Older Claude models required a structured to-do list UI to complete large refactors; current models hold context natively — the UI was stripped. Teams must audit UI surfaces for whether they compensate for a model deficiency or serve genuine user needs.

**Unlocking new product categories.** An autonomous code-review agent at 85% accuracy produces too many false positives to be useful. At 99%+, it can block code merges without human review. The product does not exist at 85%. Threshold crossing determines when to build a category, not just how.

**The 100% accuracy rule:** workflows at 95% accuracy deliver incomplete leverage — the human must still monitor for the 5% failure case. Only at 100% is oversight overhead genuinely eliminated. The path to 100% is prompt refinement, model feedback iteration, and structured evals — not accepting "good enough."

This frames what developers and organisations should expect from vibe coding: not a fixed practice, but one whose safe scope and required supervision level should adjust continuously as model capabilities shift. Practices appropriate for GPT-4 may be under-supervised for Claude Opus 4.7; thresholds will continue to move.

---

## 7. Vibe Coding's Third Phase: Knowledge Management

> [synthesis] Per secondary sources, Karpathy positioned vibe coding as the first of three phases of human-AI collaboration: (1) vibe coding (AI writes code), (2) agentic engineering (AI executes tasks), (3) AI manages knowledge ([[llm-wiki-pattern]]). Direct citation unconfirmed; treat as editorial interpretation.

Karpathy's own reported usage shift is telling: by April 2026, he reports spending significant AI usage on building personal knowledge bases rather than code generation. If accurate, this suggests he views knowledge curation as a higher-return use of AI than code generation — though this interpretation is not directly stated.

The practical implication: vibe coding may not converge to a mature solo practice. Its natural trajectory leads to agentic engineering (Level 2–3), which in turn requires supervisory engineering as the core human skill. The developer who optimises vibe coding as a terminal practice may be solving for the wrong level.

---

## 8. Open Questions

1. At what codebase scale does complexity accretion from vibe coding become unmaintainable? No empirical data as of May 2026.
2. Does supervised vibe coding with full code review produce security equivalent to hand-written code at comparable velocity?
3. What is the minimum code-review skill level required to safely accept vibe-coded output? Current practitioner accounts assume the reviewer is an experienced engineer.
4. How does the autonomy threshold between Level 2 and Level 3 get operationalised? Depends on review tiering, deferred permissions, and trust calibration — no settled definition.
5. When does the governance cost of platform-as-trojan-horse exceed the governance cost of not having it? Especially relevant for small organisations that cannot amortise the investment.
6. Will supervisory engineering emerge as a named, trainable role with established curricula, or will it remain implicit and organisation-dependent?

---

## Sources

- [[vibe-coding]] — Definition, variants, failure modes
- [[agentic-engineering]] — Level 2–3 mechanics, configuration stack, failure modes, variants
- [[supervisory-engineering]] — The emerging human role; burnout risk; training gap
- [[five-levels-of-ai-engineering]] — Shapiro framework; multi-level governance
- [[improving-vibe-coding]] — Synthesised mitigation strategies; supervised vs. unsupervised analysis
- [[platform-as-trojan-horse]] — Organisational governance response; GovTech stack
- [[capability-threshold-product-design]] — Product-side lens; 100% accuracy rule; threshold dynamics
- [[claude-code-configuration]] — Agentic engineering configuration stack (eight layers)
- [[andrej-karpathy]] — Originator; current status
- [[sausheong-chang]] / [[govtech-singapore]] — Practitioner organisational account
- [[cat-wu]] / [[anthropic]] — Product-side perspective on tooling and model capability
