# AGENTS.md

Welcome to the `think` repository. If you are an AI agent (Claude Code, Cursor, OpenClaw, etc.) working in this repository, you must follow these rules to maintain the architecture.

## Architecture
This repo maintains a single source of truth for AI skills. Platform-specific formats are generated at install time — not checked into the repo.
- **Source of Truth:** `skills/` directory (e.g., `skills/argument-architect/SKILL.md`).
- **CLI:** `cli.ts` — TypeScript CLI using meow. Run via `npx tsx cli.ts install <platform>`.
- **Install Logic:** `lib/install.ts` — auto-discovers all skills in `skills/` and generates platform files on demand.

## How to Add or Edit a Skill
1. **Edit the Source:** Create or modify the `SKILL.md` file in `skills/` (e.g., `skills/new-skill-name/SKILL.md`).
2. **Include YAML frontmatter** with at least `name` and `description`.
3. **Update README.md:** Always update the README when you change files, add skills, or modify the CLI. The README must match reality. No exceptions.
4. **Verify install docs:** If install instructions change, check `cli.ts`, `package.json`, and `npx tsx cli.ts install <platform> --dry-run` before editing examples.
5. **That's it.** The install script auto-discovers all skills. No mapping file or hardcoded list to update.

## Writing a New Skill

Before adding a skill, ask: would the agent get this wrong without it? Have you done this three times, and will you do it three more? If no to either, don't write it — every skill has a permanent context cost.

Checklist for the skill itself (see `docs/audits/2026-08-10-skill-writing-review.md` for the full rationale):

- **Description = router.** On platforms that keep frontmatter loaded (Claude Code, Codex, OpenClaw — Cursor strips it), the description is the only part always in context, so write for those platforms. Lead with *when* to reach for the skill (including the trigger phrases users actually say), end with what it does, and disambiguate from neighboring skills. Target under ~50 words.
- **Be precise about:** the goal (what "done" looks like, how to self-verify), constraints and gates, and context the model can't derive (frameworks, thresholds, schemas, taste).
- **Be ambiguous about:** steps, failure handling, and runtime specifics (paths, file lists, counts, versions). Let the agent adapt to what's in front of it.
- **Prevent rot.** Volatile content — exact commands, API payloads, site-specific paths — goes in `references/` or links to the source of truth, never inline in the workflow. When a skill needs repeated fixes, regenerate the section from a stable base instead of patching; accreted patches cloud a skill's focus.
- **Ask the agent.** Before writing, ask it what tools and context it has. After a run, ask what broke and what it needs — then fold that in.

## Repo Structure
```
cli.ts              # CLI entry point (meow)
lib/install.ts      # Install logic (imported by cli.ts)
skills/             # Source of truth — all skills live here
package.json        # Dependencies (meow, tsx)
AGENTS.md           # You're reading it
README.md           # Must always match reality
```

## Secure Storage Convention
Files containing personal positions, strategic context, or sensitive data must be stored at `~/.think/` — **outside any git repo**. Never write these to `docs/` or any tracked directory.

- `~/.think/profile.md` — name, role, website, LinkedIn (used by cold-outreach, elevator-pitch)
- `~/.think/house-views.md` — personal PHVs
- `~/.think/work-house-views.md` — work-specific PHVs
- `~/.think/style-guide.md` — personal writing style guide
- `~/.think/work-style-guide.md` — work writing style guide
- `~/.think/lenses/` — custom evaluation frameworks (lens skill)
- `~/.think/` — any future sensitive or personal documents

The `THINKING_PHV_FILE` and `THINKING_STYLE_FILE` env vars control which files the PHV and style-guide skills read from.

## Style Guidelines
- Keep skills concise.
- Use YAML frontmatter for `name` and `description`.
- Reference files go in `skills/<name>/references/`, scripts in `skills/<name>/`.
- Keep public README examples platform-neutral where possible. Do not default public docs to a private/internal tool unless the project is specifically about that tool.
- The CLI and install script are the only non-markdown build dependencies (TypeScript + meow).
