# AGENTS.md

Welcome to the `think` repository. If you are an AI agent (Claude Code, Cursor, OpenClaw, etc.) working in this repository, you must follow these rules to maintain the architecture.

## Architecture
This repo maintains a single source of truth for AI skills, which are then compiled into platform-specific formats.
- **Source of Truth:** The standalone directories in the root of the repo (e.g., `argument-architect/SKILL.md`, `five-questions/SKILL.md`).
- **Generated Files:** `thinking-pipeline/claude-code/` and `thinking-pipeline/cursor/`. Do NOT manually edit files in these directories.

## How to Add or Edit a Skill
1. **Edit the Source:** Create or modify the `SKILL.md` file in the root-level skill directory (e.g., `new-skill-name/SKILL.md`).
2. **Update the Map (if new):** If you are adding a *new* skill, you must add it to the `SKILL_NAMES` array inside `thinking-pipeline/scripts/generate-platform-files.sh`. The format is `"folder-name:think:command-name"`.
3. **Run the Generator:** You MUST run the generation script to update the platform files:
   ```bash
   ./thinking-pipeline/scripts/generate-platform-files.sh
   ```
4. **Update README:** If adding a new skill, add it to the appropriate table in `README.md`.

## Style Guidelines
- Keep skills concise. 
- Use YAML frontmatter for `name` and `description`.
- Do not add complex build tools (npm, python requirements) unless absolutely necessary. This is a markdown-first cognitive toolkit.
