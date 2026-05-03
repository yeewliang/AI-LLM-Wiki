---
type: source
title: "Agentic Engineering in the Wild: Real-world Stories from GovTech Singapore"
author: [[sausheong-chang]]
date: 2026-05-03
url: https://sausheong.com
ingested: 2026-05-03
tags: [agentic-engineering, govtech-singapore, supervisory-engineering, case-study]
---

# Agentic Engineering in the Wild: Real-world Stories from GovTech Singapore

## Core argument
The productivity multipliers from [[agentic-engineering]] tools are real, measurable, and already happening inside regulated government organisations — not as projections, but as completed deliveries with observable outcomes. Three case studies from [[govtech-singapore]] demonstrate 8–30× reductions in engineering effort, role-boundary dissolution, and the emergence of [[supervisory-engineering]] as the actual bottleneck.

## Key concepts introduced or used
- [[agentic-engineering]] — Three practitioners demonstrate solo-to-scale, bottleneck inversion, and supervisory engineering in production
- [[supervisory-engineering]] — All three engineers are explicit: the AI does execution, not thinking; the human value is architectural decisions and judgment
- [[platform-as-trojan-horse]] — Monorepo with reusable patterns as "codebase-as-curriculum"; the platform becomes the guardrail that makes AI-generated code consistent and reviewable
- [[vibe-coding]] — PMs, data scientists, and UX designers coding features without traditional engineering background; boundaries across roles have dropped but not disappeared

## Notable claims or data points
**Case 1 — Software engineer, anti-scam team:**
- Delivered 2 fully functional projects in 2 weeks as sole developer; limited Android experience prior
- Project 1: Android app with on-device LLM for real-time scam message detection
- Project 2: Autonomous agent automating end-to-end scam-enabler disruption; operators direct via plain English
- Old model: 2–3 specialised engineers × 8–12 weeks = 16–36 person-weeks. New: 1 engineer × 2 weeks. Conservative 8–12× reduction.
- PMs now code simple features; data scientists troubleshoot deep model issues; one PM acts as data scientist on another project because of Claude

**Case 2 — Data scientist, Government Technology Office:**
- Zero software engineering background; built what is now a core part of the go-to-market platform for multimodal AI
- 2 data scientists, no software engineers; 30+ full-stack mini-apps (showcases) + 12 capability playgrounds; 150+ users across 20+ agencies
- Per-showcase: old = 2 engineers + 1 PM over 2 sprints (~12 person-weeks); new = 1 data scientist × 2 days (~0.4 person-weeks). ~30× multiplier.
- Overall studio: old = 4 engineers + 1 PM over 12–18 months (~60–90 person-months); actual = 2 data scientists part-time (~4 person-months). 15–22× multiplier.
- Monorepo with reusable patterns acts as curriculum: colleague with zero web development experience independently delivers full-stack apps by pattern-matching against established conventions
- PM "vibecoded" a missing feature over December holidays; now in client engagements. UX designer builds Figma plugins. Engineering manager polishes slides with Claude.

**Case 3 — Software engineer, built Prelude:**
- Built Prelude: AI-powered CI/CD code review agent, production-grade, serving 150+ government projects including Singpass, GovWallet, TradeNet
- System spans 6 independently deployable packages: backend/API (Express.js), AI/ML (4 specialised prompts, schema validation, confidence scoring, deduplication, failover routing), frontend (React 19, 10+ pages), data engineering (ClickHouse time-series, OpenTelemetry, distributed tracing), DevOps/infra (Docker multi-stage, GitLab CI/CD, sandbox isolation), security/compliance (government code classification, IP filtering across 11+ CIDR blocks, token management)
- Conservative staffing without Claude: 3–5 engineers across backend/frontend/AI-ML/DevOps, 6–12 months
- January 2026 alone: 256 commits, 94 merge requests (baseline: 60–70/month). ~3.5–4× velocity increase on Prelude while concurrently contributing to 6+ other projects
- 92% of Claude Code sessions fully or mostly achieved their goal

## Relationship to existing wiki
Provides concrete quantitative evidence for claims in [[2026-05-sausheong-vibe-to-agentic]] about solo-to-scale, bottleneck inversion, and supervisory engineering. Adds the motivation effect (not quantifiable): lower cost of trying → more ambitious experimentation, higher team enthusiasm. Prelude is the in-house tool referenced in [[govtech-singapore]] key works — now with full architectural detail.

## Quality assessment
First-person interview-based reporting from the author embedded in the organisation. Numbers are extraordinary but internally consistent and specific. Author acknowledges governance gaps (unreviewed PM holiday projects entering client engagements, single points of failure over production systems). Credibility high given author's role and named specifics.
