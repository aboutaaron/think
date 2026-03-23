# AGENTS.md

Welcome to the `think` repository. If you are an AI agent (Claude Code, Cursor, OpenClaw, etc.) working in this repository, you must follow these rules to maintain the architecture.

## Architecture
This repo maintains a single source of truth for AI skills, which are then compiled into platform-specific formats.
- **Source of Truth:** The `skills/` directory (e.g., `skills/argument-architect/SKILL.md`, `skills/five-questions/SKILL.md`).
- **Generated Files:** `claude-code/commands/` and `cursor/rules/`. Do NOT manually edit files in these directories.

## How to Add or Edit a Skill
1. **Edit the Source:** Create or modify the `SKILL.md` file in `skills/` (e.g., `skills/new-skill-name/SKILL.md`).
2. **Update the Map (if new):** If you are adding a *new* skill that needs a `/think:` command, add it to the `SKILL_NAMES` array inside `scripts/generate-platform-files.sh`. The format is `"folder-name:think:command-name"`.
3. **Run the Generator:** You MUST run the generation script to update the platform files:
   ```bash
   ./scripts/generate-platform-files.sh
   ```
4. **Update README:** If adding a new skill, add it to the appropriate table in `README.md`.

## Style Guidelines
- Keep skills concise. 
- Use YAML frontmatter for `name` and `description`.
- Do not add complex build tools (npm, python requirements) unless absolutely necessary. This is a markdown-first cognitive toolkit.
