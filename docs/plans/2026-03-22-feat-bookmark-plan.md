# Plan: Bookmark Skill

**Date:** 2026-03-22
**Type:** Utility skill (capture, not analysis)

## What

A `bookmark` skill that captures ideas, tools, links, or concepts the user wants to defer — not evaluate.

## Three Steps

1. **What** — URL, idea, tool, or concept being bookmarked
2. **Why not now** — needs data, wrong time, dependency, lower priority
3. **Categorize + append** — one of: Build Later, Explore When Relevant, Reference

## Output

Appends entry to configurable bookmarks file (default: `docs/bookmarks.md`) with date, description, rationale, and source context. Commits the change.

## Design Constraints

- No analysis or evaluation — pure capture
- Works in any project
- Configurable file path via `BOOKMARKS_FILE` env var
- Follows repo conventions: frontmatter, clear triggers, structured output
