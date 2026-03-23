#!/bin/bash
# AI Detection via Pangram Labs API
# Usage: ./check.sh <file>        — check a file
#        ./check.sh "some text"   — check inline text
#
# Requires PANGRAM_API_KEY in environment or .credentials/pangram.env

set -euo pipefail

# Load API key
if [ -z "${PANGRAM_API_KEY:-}" ]; then
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  CRED_FILE="${SCRIPT_DIR}/../../.credentials/pangram.env"
  if [ -f "$CRED_FILE" ]; then
    source "$CRED_FILE"
  else
    echo "Error: PANGRAM_API_KEY not set and no .credentials/pangram.env found" >&2
    exit 1
  fi
fi

if [ -z "${1:-}" ]; then
  echo "Usage: $0 <file-or-text>" >&2
  exit 1
fi

# Read input — file or inline text
if [ -f "$1" ]; then
  TEXT=$(cat "$1")
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
