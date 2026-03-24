#!/bin/bash
# AI Detection via Pangram Labs API
# Usage: ./check.sh <file>        — check a file
#        ./check.sh "some text"   — check inline text
#
# Requires PANGRAM_API_KEY environment variable

set -euo pipefail

if [ -z "${PANGRAM_API_KEY:-}" ]; then
  echo "Error: PANGRAM_API_KEY environment variable not set." >&2
  echo "  export PANGRAM_API_KEY=your-key-here" >&2
  exit 1
fi

if [ -z "${1:-}" ]; then
  echo "Usage: $0 <file-or-text>" >&2
  exit 1
fi

# Read input — file or inline text
if [ -f "$1" ]; then
  TEXT=$(cat "$1")
  # Strip markdown artifacts that skew AI detection scores
  TEXT=$(python3 -c "
import re, sys
text = sys.stdin.read()
# Remove YAML frontmatter
text = re.sub(r'^---\n.*?\n---\n', '', text, count=1, flags=re.DOTALL)
# Remove markdown links but keep link text: [text](url) → text
text = re.sub(r'\[([^\]]+)\]\([^)]+\)', r'\1', text)
# Remove bold/italic markers
text = re.sub(r'\*\*([^*]+)\*\*', r'\1', text)
text = re.sub(r'\*([^*]+)\*', r'\1', text)
# Remove heading markers
text = re.sub(r'^#+\s+', '', text, flags=re.MULTILINE)
print(text.strip())
" <<< "$TEXT")
else
  TEXT="$1"
fi

# Escape for JSON
JSON_TEXT=$(printf '%s' "$TEXT" | python3 -c 'import sys,json; print(json.dumps(sys.stdin.read()))')

RESPONSE=$(curl -s 'https://text.api.pangramlabs.com/v3' \
  -X POST \
  -H 'Content-Type: application/json' \
  -H "x-api-key: ${PANGRAM_API_KEY}" \
  -d "{\"text\": ${JSON_TEXT}}")

# Check for errors
if echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); sys.exit(0 if 'error' not in d else 1)" 2>/dev/null; then
  echo "$RESPONSE" | python3 -m json.tool
else
  echo "Error from Pangram API:" >&2
  echo "$RESPONSE" | python3 -m json.tool >&2
  exit 1
fi
