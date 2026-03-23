# AGENTS.md

Welcome to the `think` repository. If you are an AI agent (Claude Code, Cursor, OpenClaw, etc.) working in this repository, you must follow these rules to maintain the architecture.

## Architecture
This repo maintains a single source of truth for AI skills.
- **Source of Truth:** `skills/` directory (e.g., `skills/argument-architect/SKILL.md`).
- **Install Script:** `scripts/install.sh` reads from `skills/` and writes platform-specific formats. No generated files are checked in.

## How to Add or Edit a Skill
1. **Edit the Source:** Create or modify the `SKILL.md` file in `skills/` (e.g., `skills/new-skill-name/SKILL.md`).
2. **Include YAML frontmatter** with at least `name` and `description`.
3. **Update README:** If adding a new skill, add it to the appropriate table in `README.md`.
4. **Re-run install** for your platform to pick up changes: `./scripts/install.sh <platform>`

The install script auto-discovers all skills in `skills/`. No hardcoded lists to maintain.

## Style Guidelines
- Keep skills concise. 
- Use YAML frontmatter for `name` and `description`.
- Do not add complex build tools (npm, python requirements) unless absolutely necessary. This is a markdown-first cognitive toolkit.
