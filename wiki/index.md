# Wiki Index

Last updated: 2026-06-13 | Pages: 44

## Concepts
- [[llm-wiki-pattern]] — LLM-maintained persistent wiki; three-layer architecture (raw/wiki/schema), three operations (ingest/query/lint)
- [[vibe-coding]] — Intent-driven LLM programming coined by Karpathy (Feb 2026); developer specifies behaviour, LLM generates code
- [[agentic-engineering]] — Multi-step agent execution at Levels 2–3 of the Shapiro framework; the configuration-driven evolution of vibe coding
- [[harness-engineering]] — Discipline where the engineer's output is a constraint system, not code; six principles, three constraint tests; Prompt → Vibe → Harness progression
- [[ralph-loop]] — Autonomous agent loop; clears context each iteration, reads PRD, does one task, commits, until done (snarktank/ralph)
- [[supervisory-engineering]] — Emerging core competency: directing, evaluating, correcting AI output rather than implementing
- [[five-levels-of-ai-engineering]] — Shapiro's progression: spicy autocomplete → coding assistants → autonomous agents → agent networks → software factory
- [[platform-as-trojan-horse]] — Embedding governance/security/quality into platforms rather than relying on policy compliance
- [[capability-threshold-product-design]] — UI features added/removed as model capability changes; new product categories unlock at accuracy thresholds
- [[model-context-protocol]] — Protocol connecting agents to external tools; tool schemas have direct token-cost implications
- [[claude-code-configuration]] — The eight-layer `.claude/` stack (memory, rules, plan mode, subagents, skills, hooks, MCP, worktrees + headless)
- [[retrieval-augmented-generation]] — Embedding-based document retrieval at query time; baseline contrasted with the LLM Wiki pattern
- [[agent-harness]] — Software layer owning context, tools, execution, identity; the "vehicle" vs model as "engine"; the real competitive battleground
- [[agent-compaction]] — Context window management for long-running agents: cheap tricks, LLM summarisation, memory-as-substitute, failure recovery
- [[prompt-cache-stability]] — Design discipline for keeping prompt prefixes identical; cache correctness affects both cost (10×) and agent behaviour consistency
- [[skills-as-markdown]] — Capability extension via prose documents + YAML frontmatter; no compiled code; human-auditable; distributable via registries
- [[index-pattern]] — Inject lightweight capability index; load full content on demand; reduces per-prompt tokens 5–15 KB; enables prompt-cache stability
- [[memex]] — Vannevar Bush's 1945 vision of a personal, associatively-linked knowledge machine; intellectual predecessor to LLM Wiki
- [[zettelkasten]] — Luhmann's interlinked card index; manual-friction counterpoint to LLM-automated knowledge systems

## Entities — People
- [[andrej-karpathy]] — AI researcher; coined vibe coding; originator of the LLM Wiki pattern (April 2026)
- [[vannevar-bush]] — Engineer; authored "As We May Think" (1945); proposed the Memex
- [[niklas-luhmann]] — Sociologist; developed the Zettelkasten; ~90,000 cards over 40 years
- [[sausheong-chang]] — GovTech Singapore engineering leader; author of the public AI strategy articulation
- [[dan-shapiro]] — Author of the five-level AI engineering framework
- [[tobi-lutke]] — Shopify founder/CEO; built `qmd` markdown search MCP server
- [[cat-wu]] — Head of Product, Claude Code, Anthropic; articulator of capability-threshold product design
- [[martin-fowler]] — Software architecture author; his team's four-component definition of the agent harness grounds harness engineering
- [[ryan-lopopolo]] — OpenAI engineer; case study (3 people, 5 months, ~1M LOC, 1,500+ PRs) anchoring the harness-engineering argument

## Entities — Organisations
- [[anthropic]] — AI safety company; vendor of Claude models and Claude Code
- [[govtech-singapore]] — Public-sector engineering organisation publishing concrete AI strategy and platform stack

## Entities — Tools
- [[obsidian]] — Local-first markdown app; canonical viewing layer for LLM Wiki implementations
- [[cursor]] — AI-native code editor; alternative agent layer to Claude Code for LLM Wiki maintenance
- [[claude-code]] — Anthropic's terminal-native agentic coding CLI; dominant agentic-engineering tool as of mid-2026
- [[openclaw]] — Local-first agent gateway; 24 chat-channel adapters; 113 plugins; skills-as-markdown; documented harness-as-contract architecture
- [[felix-agent]] — Single-binary local AI agent by sausheong-chang; everything-is-a-tool design; index pattern; self-built for personal non-coding work

## Synthesis
- [[improving-vibe-coding]] — Mitigation strategies for vibe coding's documented limitations (complexity, security, novel problems)

## Sources
- [[2026-04-karpathy-second-brain-explained]] — Journalistic walkthrough of the LLM Wiki pattern; full architecture and step-by-step setup
- [[kosuri-2026-llm-wiki-build]] — Practitioner account; full scaffold built in 3 Cursor prompts; public repo available
- [[2026-04-designer-llm-wiki]] — LLM Wiki framed for design practice; introduces Obsidian Canvas and three-phases framing
- [[2026-05-karpathy-llm-wiki-future]] — Ecosystem map; five adjacent projects (Waykee Cortex, Sage-Wiki, Thinking-MCP, ELF, qmd)
- [[2026-05-sausheong-vibe-to-agentic]] — Practitioner strategy from GovTech Singapore; bottleneck inversion, supervisory engineering, platform stack
- [[2026-05-claude-code-tuning-stack]] — Eight-layer Claude Code configuration with full artefacts; MCP token economics; deferred permissions
- [[2026-05-cat-wu-anthropic-product-velocity]] — Anthropic product culture; capability-threshold design; Claude Code CLI vs Desktop; Co-Work distinction
- [[2026-05-sausheong-agentic-in-the-wild]] — GovTech Singapore case studies; 8–30× productivity multipliers; role-boundary dissolution; Prelude architectural detail
- [[2026-05-sausheong-dissecting-open-claw]] — OpenClaw architectural read; plugin SDK; skills-as-markdown; prompt-cache stability; agent loop contracts
- [[2026-05-sausheong-felix-agent]] — Felix design rationale; everything-is-a-tool; index pattern; long-running process contract
- [[2026-05-sausheong-own-your-harness]] — Compaction comparison (Claude Code vs OpenClaw); harness-ownership argument; production telemetry evidence
- [[2026-05-harness-engineering-next-upgrade]] — Chinese-language synthesis; Fowler's four-component harness, six harness-engineering principles, three constraint tests, Ralph mode
