# Wiki Index

Last updated: 2026-05-03 | Pages: 28

## Concepts
- [[llm-wiki-pattern]] — LLM-maintained persistent wiki; three-layer architecture (raw/wiki/schema), three operations (ingest/query/lint)
- [[vibe-coding]] — Intent-driven LLM programming coined by Karpathy (Feb 2026); developer specifies behaviour, LLM generates code
- [[agentic-engineering]] — Multi-step agent execution at Levels 2–3 of the Shapiro framework; the configuration-driven evolution of vibe coding
- [[supervisory-engineering]] — Emerging core competency: directing, evaluating, correcting AI output rather than implementing
- [[five-levels-of-ai-engineering]] — Shapiro's progression: spicy autocomplete → coding assistants → autonomous agents → agent networks → software factory
- [[platform-as-trojan-horse]] — Embedding governance/security/quality into platforms rather than relying on policy compliance
- [[capability-threshold-product-design]] — UI features added/removed as model capability changes; new product categories unlock at accuracy thresholds
- [[model-context-protocol]] — Protocol connecting agents to external tools; tool schemas have direct token-cost implications
- [[claude-code-configuration]] — The eight-layer `.claude/` stack (memory, rules, plan mode, subagents, skills, hooks, MCP, worktrees + headless)
- [[retrieval-augmented-generation]] — Embedding-based document retrieval at query time; baseline contrasted with the LLM Wiki pattern
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

## Entities — Organisations
- [[anthropic]] — AI safety company; vendor of Claude models and Claude Code
- [[govtech-singapore]] — Public-sector engineering organisation publishing concrete AI strategy and platform stack

## Entities — Tools
- [[obsidian]] — Local-first markdown app; canonical viewing layer for LLM Wiki implementations
- [[cursor]] — AI-native code editor; alternative agent layer to Claude Code for LLM Wiki maintenance
- [[claude-code]] — Anthropic's terminal-native agentic coding CLI; dominant agentic-engineering tool as of mid-2026

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
