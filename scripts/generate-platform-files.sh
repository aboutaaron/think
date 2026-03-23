#!/bin/bash
# Generate Claude Code commands and Cursor rules from standalone skills
# Run this after modifying any standalone skill in the repo root

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Claude Code commands
CC_DIR="${REPO_ROOT}/claude-code/commands"
mkdir -p "$CC_DIR"

# Cursor rules
CURSOR_DIR="${REPO_ROOT}/cursor/rules"
mkdir -p "$CURSOR_DIR"

# Map standalone skill name to command name
SKILL_NAMES=(
  "argument-architect:think:architect"
  "devils-advocate:think:challenge"
  "feynman-test:think:feynman"
  "cold-outreach:think:outreach"
  "phv-challenge:think:phv"
  "recall-first:think:recall"
  "source-to-receipt:think:receipt"
  "editorial-review:think:review"
  "five-questions:think:start"
)

for entry in "${SKILL_NAMES[@]}"; do
  skill="${entry%%:*}"
  cmd="${entry#*:}"
  cursor_name="${cmd#think:}"
  
  src="${REPO_ROOT}/${skill}/SKILL.md"
  if [ ! -f "$src" ]; then
    echo "SKIP: $src not found"
    continue
  fi
  
  # Strip YAML frontmatter robustly (only first block between --- markers)
  content=$(awk 'BEGIN{in_fm=0; done_fm=0} /^---$/ && !done_fm {in_fm++; if(in_fm==2){done_fm=1}; next} done_fm || in_fm==0 {print}' "$src")
  
  echo "$content" > "${CC_DIR}/${cmd}.md"
  echo "$content" > "${CURSOR_DIR}/${cursor_name}.md"
  echo "OK: ${skill} → ${cmd}"
done

echo ""
echo "Generated $(ls "$CC_DIR" | wc -l) Claude Code commands"
echo "Generated $(ls "$CURSOR_DIR" | wc -l) Cursor rules"
