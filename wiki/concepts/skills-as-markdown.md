---
type: concept
title: Skills as Markdown
aliases: [markdown skills, prose skills, skill documents]
tags: [agents, agent-harness, extensibility, agentic-engineering]
related: [[agent-harness]], [[index-pattern]], [[openclaw]], [[felix-agent]], [[claude-code-configuration]]
created: 2026-05-03
updated: 2026-05-03
---

# Skills as Markdown

## What it is
A capability-extension mechanism for AI agents in which skills are defined as prose documents (typically Markdown with YAML frontmatter) rather than as compiled code or JSON function schemas. The agent reads the skill document at runtime; the prose is the instruction, and the agent drives underlying tools or CLI commands itself.

## How it works
A skill document has two parts:
1. **YAML frontmatter**: machine-readable metadata — skill name, description, OS requirements, required binaries, install instructions. Example from [[openclaw]]:
   ```yaml
   name: apple-reminders
   description: Manage Apple Reminders via remindctl CLI.
   metadata:
     openclaw:
       os: ["darwin"]
       requires: { bins: ["remindctl"] }
       install:
         - kind: brew
           formula: steipete/tap/remindctl
   ```
2. **Prose body**: plain English — when to use this skill, when not to, what arguments the underlying tool accepts, worked examples. This is the context the model reads when deciding whether to invoke the capability.

The agent never registers a compiled function. It reads the prose and uses a generic shell/bash tool it already has to drive the CLI described in the skill. The skill is an instruction document that wraps an existing command-line tool.

**Distribution model:**
Skills are files, so publishing a new skill is a publishing problem (upload to a registry like ClawHub), not a release problem (no binary to ship, no compiled bundle). ClawHub registers skills with semver tags, a `.clawhub/lock.json` lockfile, and a content-hash divergence warning when local edits differ from the registry version.

**Contrast with function-calling:**
The conventional approach registers a JSON schema into a function-calling table that the model is prompted to select from. Human-readable guidance for when to use the function is either crammed into the `description` field or kept separately in the system prompt. The function definition and the usage guidance are structurally decoupled.

Skills-as-markdown inverts this: the prose explaining when to use the capability, when not to, and how to invoke it lives in the same document. A human can audit the whole thing in a text editor. A maintainer can change the model's behaviour by editing the prose, without recompiling anything.

## Why it matters
- **Human audibility**: any skill is readable in a text editor; no compiled bundle to inspect
- **Author accessibility**: non-engineers can write and maintain skills; no code compilation required
- **Behaviour editing**: changing how the agent uses a capability = editing a text file, not a code change
- **Decoupled distribution**: skills ship and update independently from the runtime binary
- **Unified context**: usage guidance and capability definition are co-located; less drift between documentation and implementation

The pattern scales: [[openclaw]] ships 53 skills in the repository; each wraps an external CLI (remindctl, spogo, etc.) that the agent drives. The skill author needs to know the CLI's interface, not the agent's internals.

## Key variants or extensions
- **CLAUDE.md / skills in Claude Code** ([[claude-code-configuration]]): Claude Code's skills layer also uses markdown files with structured frontmatter; operates within the `.claude/skills/` directory path; similar concept, different registry and loading mechanism
- **Skill registries**: ClawHub (OpenClaw), `.claude/skills/` (Claude Code), `~/.felix/skills/` (Felix); each has different discoverability and update mechanisms
- **Lazy loading via index pattern**: [[index-pattern]] — the agent loads the full skill prose only when it determines the skill is needed, rather than injecting all skills into every prompt; see [[prompt-cache-stability]]

## Limitations and open questions
- **Schema enforcement**: prose skills have no type system; incorrect guidance in the prose silently degrades agent behaviour with no compile-time error
- **CLI brittleness**: a skill wrapping a CLI breaks when the CLI changes its interface; the skill document must be updated manually
- **Discovery cost**: at scale, the model must read many skill descriptions to select appropriately; mitigated by the index pattern but not eliminated
- **Security surface**: skills drive arbitrary CLIs; a malicious or compromised skill document can instruct the agent to run harmful commands — requires tool allowlisting and sandbox isolation at the harness level

## Key sources
- [[2026-05-sausheong-dissecting-open-claw]] — Skills as markdown in OpenClaw; ClawHub registry; contrast with function-calling
- [[2026-05-sausheong-felix-agent]] — Skills implementation in Felix; same pattern, different runtime
