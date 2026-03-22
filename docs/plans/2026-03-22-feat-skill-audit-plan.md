# Plan: skill-audit

**Date:** 2026-03-22
**Status:** Build

## What

A monthly checklist skill that evaluates the health of all thinking skills. Inspired by the Claude Code team's practice of auditing whether tools are constraining instead of helping.

## Why

Skills accumulate. Some stop being useful. Some overlap. Some actively get in the way by forcing a pattern that doesn't fit. A lightweight monthly audit catches drift before it compounds.

## Scope

The skill produces a markdown report with:

1. **Skill inventory table** — name, purpose, last-used date (if trackable), category
2. **Health evaluation per skill** — Is it being used? Is it redundant with another? Is it constraining instead of helping?
3. **Recommendation per skill** — kill, merge, or keep
4. **Autoresearch candidates** — Flag skills worth optimizing once enough usage data exists
5. **Summary** — Total counts, key actions, next audit date

## Output Format

Markdown report: table + recommendations section. Written to `docs/audits/YYYY-MM-DD-skill-audit.md`.

## Design Decisions

- **Checklist, not automation.** The agent walks through each skill with the user. No scoring algorithms.
- **Monthly cadence.** Frequent enough to catch drift, rare enough to not be annoying.
- **Pairs with weekly-review.** Weekly review tracks what shipped; skill-audit tracks whether the tools helped.
- **No overlap with existing skills.** This evaluates the toolkit itself, not the thinking it produces.

## Non-Goals

- Automated usage tracking (no telemetry)
- Prompt optimization (that's autoresearch's job if/when it exists)
- Evaluating non-thinking skills
