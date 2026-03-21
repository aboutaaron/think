---

# Command mapping (skill name → slash command)
# five-questions → /think:start
# recall-first → /think:recall
# feynman-test → /think:feynman
# argument-architect → /think:architect
# devils-advocate → /think:challenge
# editorial-review → /think:review
# source-to-receipt → /think:receipt
# phv-challenge → /think:phv
# cold-outreach → /think:outreach
# one-question → /think:slow
# (composite) → /think:pipeline
# Thinking Pipeline Settings
# Copy this file to your project root and customize.

# Which skills are active (comment out to disable)
active_skills:
  - five-questions
  - recall-first
  - feynman-test
  - argument-architect
  - devils-advocate
  - editorial-review
  - source-to-receipt
  - phv-challenge
  - cold-outreach
  - one-question

# Auto-triggering (OpenClaw only — context-aware skill firing)
auto_trigger: true

# Path to your Personal House Views file (for /think:phv)
phv_file: docs/house-views.md

# Active writing project outline (for /think:receipt placement)
# active_outline: docs/current-outline.md
---

# Thinking Pipeline — Local Settings

This file configures the thinking pipeline plugin for your project.

## Usage

Place this file in your project root. The plugin reads it to determine which skills are active and where to find reference files.

## Customization

- **Disable a skill:** Comment it out from `active_skills`
- **PHV file:** Set `phv_file` to your House Views markdown file
- **Active outline:** Uncomment and set `active_outline` to auto-place citation receipts
