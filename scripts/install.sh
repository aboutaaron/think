#!/bin/bash
# Install Think skills into your AI coding environment
#
# Usage:
#   ./scripts/install.sh claude-code          # Claude Code slash commands
#   ./scripts/install.sh codex                # OpenAI Codex agents/skills
#   ./scripts/install.sh cursor               # Cursor rules
#   ./scripts/install.sh openclaw [dir]       # OpenClaw workspace skills
#   ./scripts/install.sh all                  # All platforms
#
# Each platform gets the skill content (YAML frontmatter stripped)
# in the format it expects. Source of truth is always skills/*/SKILL.md.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="${REPO_ROOT}/skills"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

strip_frontmatter() {
  awk 'BEGIN{in_fm=0; done_fm=0} /^---$/ && !done_fm {in_fm++; if(in_fm==2){done_fm=1}; next} done_fm || in_fm==0 {print}' "$1"
}

get_skill_name() {
  # Extract name from YAML frontmatter
  grep '^name:' "$1" 2>/dev/null | head -1 | sed 's/^name: *//' | tr -d '"' | tr -d "'"
}

install_claude_code() {
  local target="${1:-.claude/commands}"
  mkdir -p "$target"
  local count=0

  for skill_dir in "$SKILLS_DIR"/*/; do
    local skill_file="${skill_dir}SKILL.md"
    [ -f "$skill_file" ] || continue

    local name
    name=$(get_skill_name "$skill_file")
    [ -z "$name" ] && name=$(basename "$skill_dir")

    # Claude Code uses slash commands: /think:name
    local cmd_name="think:${name}"
    strip_frontmatter "$skill_file" > "${target}/${cmd_name}.md"
    count=$((count + 1))
  done

  echo -e "${GREEN}✓${NC} Installed ${count} Claude Code commands in ${target}/"
  echo "  Usage: /think:five-questions, /think:argument-architect, etc."
}

install_codex() {
  local target="${1:-.agents/skills}"
  mkdir -p "$target"
  local count=0

  for skill_dir in "$SKILLS_DIR"/*/; do
    local skill_file="${skill_dir}SKILL.md"
    [ -f "$skill_file" ] || continue

    local name
    name=$(basename "$skill_dir")

    # Codex uses directory-based skills with SKILL.md or instruction files
    local dest="${target}/${name}"
    mkdir -p "$dest"
    cp "$skill_file" "${dest}/SKILL.md"

    # Copy any references or scripts alongside the skill
    for extra in "${skill_dir}"references "${skill_dir}"scripts "${skill_dir}"*.sh; do
      [ -e "$extra" ] && cp -r "$extra" "${dest}/"
    done

    count=$((count + 1))
  done

  echo -e "${GREEN}✓${NC} Installed ${count} Codex skills in ${target}/"
  echo "  Usage: Reference skill names in your prompts or AGENTS.md"
}

install_cursor() {
  local target="${1:-.cursor/rules}"
  mkdir -p "$target"
  local count=0

  for skill_dir in "$SKILLS_DIR"/*/; do
    local skill_file="${skill_dir}SKILL.md"
    [ -f "$skill_file" ] || continue

    local name
    name=$(basename "$skill_dir")

    # Cursor uses .md rules in .cursor/rules/
    strip_frontmatter "$skill_file" > "${target}/${name}.md"
    count=$((count + 1))
  done

  echo -e "${GREEN}✓${NC} Installed ${count} Cursor rules in ${target}/"
  echo "  Usage: Reference by name in chat — \"Use the argument-architect skill\""
}

install_openclaw() {
  local target="${1:-$HOME/.openclaw/workspace/skills/think}"
  mkdir -p "$target/skills"
  local count=0

  # OpenClaw loads skills from directories with SKILL.md
  for skill_dir in "$SKILLS_DIR"/*/; do
    local skill_file="${skill_dir}SKILL.md"
    [ -f "$skill_file" ] || continue

    local name
    name=$(basename "$skill_dir")
    local dest="${target}/skills/${name}"
    mkdir -p "$dest"
    cp "$skill_file" "${dest}/SKILL.md"

    # Copy any references or scripts
    for extra in "${skill_dir}"references "${skill_dir}"scripts "${skill_dir}"*.sh; do
      [ -e "$extra" ] && cp -r "$extra" "${dest}/"
    done

    count=$((count + 1))
  done

  echo -e "${GREEN}✓${NC} Installed ${count} OpenClaw skills in ${target}/skills/"
  echo "  Skills are auto-loaded by OpenClaw on next session."
}

usage() {
  echo "Usage: $0 <platform> [target-dir]"
  echo ""
  echo "Platforms:"
  echo "  claude-code    Install as Claude Code slash commands (.claude/commands/)"
  echo "  codex          Install as Codex agent skills (.agents/skills/)"
  echo "  cursor         Install as Cursor rules (.cursor/rules/)"
  echo "  openclaw       Install as OpenClaw skills (~/.openclaw/workspace/skills/think/)"
  echo "  all            Install for all platforms"
  echo ""
  echo "Options:"
  echo "  target-dir     Override the default install directory"
  echo ""
  echo "Examples:"
  echo "  $0 claude-code                    # Install to .claude/commands/"
  echo "  $0 claude-code ./my-project/.claude/commands"
  echo "  $0 all                            # Install for all platforms"
  exit 1
}

# Main
case "${1:-}" in
  claude-code) install_claude_code "${2:-}" ;;
  codex)       install_codex "${2:-}" ;;
  cursor)      install_cursor "${2:-}" ;;
  openclaw)    install_openclaw "${2:-}" ;;
  all)
    install_claude_code "${2:-}"
    install_codex "${2:-}"
    install_cursor "${2:-}"
    install_openclaw "${2:-}"
    ;;
  *) usage ;;
esac
