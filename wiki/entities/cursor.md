---
type: entity
entity_class: tool
title: Cursor
aliases: []
tags: [ai-ide, tool, code-editor]
related: [[llm-wiki-pattern]]
created: 2026-05-02
updated: 2026-05-02
---

# Cursor

## Overview
An AI-powered code editor (fork of VS Code) with deep LLM integration — inline completions, multi-file editing, and natural language commands over the open project directory. As of 2026, one of the dominant AI-native development environments alongside Claude Code, GitHub Copilot, and others.

## Why this entity matters to AI
Referenced as the agent layer in Balasubramanyam Kosuri's practitioner implementation of the [[llm-wiki-pattern]]. Kosuri built a complete wiki scaffold — `CLAUDE.md`, full directory structure, four starter wiki pages, and a pre-configured [[obsidian]] vault — in three natural-language prompts to Cursor, with no command-line usage. This is the primary evidence that the [[llm-wiki-pattern]] is accessible to non-developers; any LLM-capable IDE or agent with file-system access can serve as the maintenance layer.

## Key works / outputs
- Cursor IDE — AI-native code editor (VS Code fork) with inline completions, multi-file editing, and natural-language command interface over the open project directory.

## Affiliations and relationships
- Anysphere Inc. — creator and developer of Cursor.
- VS Code / Microsoft — upstream codebase from which Cursor is forked.

## Current status / latest developments
Cursor competes directly with Claude Code and GitHub Copilot Workspace in the AI-native IDE space as of 2026. Its file-system access model — can read and write arbitrary files within the open project — makes it compatible with the [[llm-wiki-pattern]] without additional tooling or MCP configuration.
