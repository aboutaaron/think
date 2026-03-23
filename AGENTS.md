# AGENTS.md

Welcome to the `think` repository. If you are an AI agent (Claude Code, Cursor, OpenClaw, etc.) working in this repository, you must follow these rules to maintain the architecture.

## Architecture
This repo maintains a single source of truth for AI skills. Platform-specific formats are generated at install time — not checked into the repo.
- **Source of Truth:** `skills/` directory (e.g., `skills/argument-architect/SKILL.md`).
- **CLI:** `cli.ts` — TypeScript CLI using meow. Run via `npx tsx cli.ts install <platform>`.
- **Install Logic:** `scripts/install.ts` — auto-discovers all skills in `skills/` and generates platform files on demand.

## How to Add or Edit a Skill
1. **Edit the Source:** Create or modify the `SKILL.md` file in `skills/` (e.g., `skills/new-skill-name/SKILL.md`).
2. **Include YAML frontmatter** with at least `name` and `description`.
3. **Update README:** If adding a new skill, add it to the appropriate table in `README.md`.
4. **That's it.** The install script auto-discovers all skills. No mapping file or hardcoded list to update.

## Style Guidelines
- Keep skills concise.
- Use YAML frontmatter for `name` and `description`.
- Reference files go in `skills/<name>/references/`, scripts in `skills/<name>/`.
- The CLI and install script are the only non-markdown build dependencies (TypeScript + meow).
