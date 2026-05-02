# 🧠 AI & Technology Second Brain

A personal knowledge base for building deep, compounding expertise in AI and
technology. Built on the [LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
by Andrej Karpathy.

Raw sources go in. A structured, interlinked wiki comes out. Knowledge
accumulates permanently instead of being rediscovered from scratch.

---

## How it works

The core idea is simple: instead of asking an AI questions and forgetting the
answers, the AI **writes and maintains a wiki** on your behalf.

```
You drop articles into raw/
        ↓
Claude reads, extracts, and structures knowledge
        ↓
Wiki pages are created in wiki/ with full wikilinks
        ↓
You browse, query, and build on it in Obsidian
        ↓
Everything is version-controlled on GitHub
```

No RAG. No vector databases. Just markdown files that compound over time.

---

## Vault Structure

```
vault/
├── .claude/
│   └── commands/           # Slash commands for Claude Code
│       ├── ingest.md       # /ingest
│       ├── lint.md         # /lint
│       ├── query.md        # /query
│       ├── report.md       # /report
│       └── update.md       # /update
├── raw/                    # Drop source articles here
│   ├── archive/            # Processed sources moved here automatically
│   └── assets/             # Images and attachments
├── wiki/
│   ├── concepts/           # Algorithms, architectures, techniques
│   ├── entities/           # People, labs, models, papers
│   ├── synthesis/          # Cross-topic analyses and open questions
│   ├── index.md            # Master catalog of all pages
│   └── log.md              # Chronological record of all operations
├── output/                 # Generated reports and briefings
├── CLAUDE.md               # Agent config and operating rules
└── README.md               # This file
```

---

## Domain Coverage

**Core:**
- Machine learning fundamentals (transformers, diffusion, RL, optimisation)
- Large language models (architecture, training, alignment, inference)
- AI agents and tool use (scaffolding, memory, multi-agent systems)
- AI infrastructure (compute, distributed training, serving, quantisation)
- Frontier labs (Anthropic, OpenAI, DeepMind, Meta AI, Mistral)
- Emerging techniques (MoE, RLHF, DPO, RAG, speculative decoding)

**Adjacent:**
- Hardware as it relates to AI capability
- AI safety and alignment research
- Regulation and policy

---

## Getting Started

### Prerequisites

- [Obsidian](https://obsidian.md) — for browsing the wiki and graph view
- [Claude Code](https://claude.ai/code) — the AI agent that runs the wiki
- [Node.js](https://nodejs.org) — required for Claude Code
- A GitHub account — for version control

### Setup

**1. Clone this repo**
```bash
git clone https://github.com/yourusername/your-repo-name.git
cd your-repo-name
```

**2. Install Claude Code**
```bash
npm install -g @anthropic/claude-code
```

**3. Open the vault in Obsidian**
File → Open Vault → select this folder

**4. Open Claude Code in the vault directory**
```bash
claude
```

Claude reads `CLAUDE.md` automatically on every session.

---

## Daily Workflow

### Add new sources
Drop any article, PDF, or note into `raw/`. Name it with a date prefix:
```
raw/2026-05-02-attention-is-all-you-need.md
```

Use the [Obsidian Web Clipper](https://obsidian.md/clipper) browser extension
to clip articles directly into `raw/` with automatic date-prefixed filenames.

### Run ingest
```
/ingest
```

Claude processes all new files in `raw/`, builds wiki pages, updates the index,
archives the sources, and commits to GitHub.

### Query your wiki
```
/query what are the trade-offs between RLHF and DPO
/query what do my sources say about speculative decoding
```

Answers come only from your own ingested knowledge, with citations.

### Generate a briefing
```
/report transformer inference optimisation
/report state of AI agents 2026
```

Saved to `output/` as a timestamped markdown file.

### Housekeeping
```
/lint
```

Run monthly. Fixes broken wikilinks, orphan pages, missing frontmatter, and
stale entity pages.

---

## Commands

| Command | What it does |
|---|---|
| `/ingest` | Process new files in `raw/`, build wiki pages, archive, commit |
| `/query [question]` | Answer from wiki only, cite pages, write synthesis if needed |
| `/report [topic]` | Generate structured briefing, save to `output/` |
| `/update [page]` | Refresh a specific page with new information |
| `/lint` | Audit wiki for broken links, orphans, missing frontmatter |

---

## Browsing the Wiki

Open Obsidian and use:

- **Graph View** — see all concepts and entities as a connected graph. Clusters
  reveal the shape of your knowledge. Gaps appear as thin or isolated nodes.
- **Wikilinks** — follow `[[concept]]` links between pages like a personal web.
- **Search** — full-text search across everything you've ever ingested.
- **`wiki/index.md`** — the master catalog, organised by type.

---

## Inspiration

- [Andrej Karpathy's LLM Wiki gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
- [second-brain by NicholasSpisak](https://github.com/NicholasSpisak/second-brain)
- Vannevar Bush's Memex (1945) — the original vision for associative knowledge