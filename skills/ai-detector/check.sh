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

API_BASE='https://text.external-api.pangram.com'
POLL_INTERVAL_SECONDS=${PANGRAM_POLL_INTERVAL_SECONDS:-0.5}
TIMEOUT_SECONDS=${PANGRAM_TIMEOUT_SECONDS:-300}
CURL_CONNECT_TIMEOUT_SECONDS=10

if ! [[ "$POLL_INTERVAL_SECONDS" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  echo "Error: PANGRAM_POLL_INTERVAL_SECONDS must be a non-negative number." >&2
  exit 1
fi

if ! [[ "$TIMEOUT_SECONDS" =~ ^[1-9][0-9]*$ ]]; then
  echo "Error: PANGRAM_TIMEOUT_SECONDS must be a positive integer." >&2
  exit 1
fi

POLL_INTERVAL_MILLISECONDS=$(python3 -c 'import sys; print(int(float(sys.argv[1]) * 1000))' "$POLL_INTERVAL_SECONDS")

HEADER_FILE=$(mktemp)
chmod 600 "$HEADER_FILE"
trap 'rm -f "$HEADER_FILE"' EXIT
printf 'x-api-key: %s\n' "$PANGRAM_API_KEY" > "$HEADER_FILE"

DEADLINE=$((SECONDS + TIMEOUT_SECONDS))
REQUEST_TIMEOUT_SECONDS=$((DEADLINE - SECONDS))
if (( REQUEST_TIMEOUT_SECONDS < 1 )); then
  echo "Error: Pangram task submission exceeded the ${TIMEOUT_SECONDS}-second deadline." >&2
  exit 1
fi
CONNECT_TIMEOUT_SECONDS=$CURL_CONNECT_TIMEOUT_SECONDS
if (( REQUEST_TIMEOUT_SECONDS < CONNECT_TIMEOUT_SECONDS )); then
  CONNECT_TIMEOUT_SECONDS=$REQUEST_TIMEOUT_SECONDS
fi

if ! SUBMIT_RESPONSE=$(curl -fsS "${API_BASE}/task" \
  --connect-timeout "$CONNECT_TIMEOUT_SECONDS" \
  --max-time "$REQUEST_TIMEOUT_SECONDS" \
  -X POST \
  -H 'Content-Type: application/json' \
  -H "@${HEADER_FILE}" \
  -d "{\"text\": ${JSON_TEXT}, \"model\": \"pangram-4\"}"); then
  echo "Error: Pangram task submission failed." >&2
  exit 1
fi

if ! TASK_ID=$(printf '%s' "$SUBMIT_RESPONSE" | python3 -c '
import json, sys
data = json.load(sys.stdin)
task_id = data.get("task_id") if isinstance(data, dict) else None
if not isinstance(task_id, str) or not task_id:
    raise SystemExit(1)
print(task_id)
'); then
  echo "Error from Pangram API:" >&2
  printf '%s' "$SUBMIT_RESPONSE" | python3 -m json.tool >&2 || printf '%s\n' "$SUBMIT_RESPONSE" >&2
  exit 1
fi

COMPLETED=0
RESPONSE=''

sleep_before_retry() {
  local remaining_seconds=$((DEADLINE - SECONDS))
  local remaining_milliseconds
  local sleep_milliseconds=$POLL_INTERVAL_MILLISECONDS
  local sleep_seconds

  (( remaining_seconds > 0 )) || return 1
  remaining_milliseconds=$((remaining_seconds * 1000))
  if (( sleep_milliseconds > remaining_milliseconds )); then
    sleep_milliseconds=$remaining_milliseconds
  fi
  (( sleep_milliseconds > 0 )) || return 0

  printf -v sleep_seconds '%d.%03d' \
    "$((sleep_milliseconds / 1000))" \
    "$((sleep_milliseconds % 1000))"
  sleep "$sleep_seconds"
}

while (( SECONDS < DEADLINE )); do
  REQUEST_TIMEOUT_SECONDS=$((DEADLINE - SECONDS))
  (( REQUEST_TIMEOUT_SECONDS > 0 )) || break
  CONNECT_TIMEOUT_SECONDS=$CURL_CONNECT_TIMEOUT_SECONDS
  if (( REQUEST_TIMEOUT_SECONDS < CONNECT_TIMEOUT_SECONDS )); then
    CONNECT_TIMEOUT_SECONDS=$REQUEST_TIMEOUT_SECONDS
  fi

  if ! RESPONSE=$(curl -fsS "${API_BASE}/task/${TASK_ID}" \
    --connect-timeout "$CONNECT_TIMEOUT_SECONDS" \
    --max-time "$REQUEST_TIMEOUT_SECONDS" \
    -H 'Content-Type: application/json' \
    -H "@${HEADER_FILE}"); then
    sleep_before_retry || break
    continue
  fi

  if ! STAGE=$(printf '%s' "$RESPONSE" | python3 -c '
import json, sys
data = json.load(sys.stdin)
stage = data.get("stage") if isinstance(data, dict) else None
if not isinstance(stage, str):
    raise SystemExit(1)
print(stage)
'); then
    echo "Error from Pangram API: invalid task response." >&2
    printf '%s' "$RESPONSE" | python3 -m json.tool >&2 || printf '%s\n' "$RESPONSE" >&2
    exit 1
  fi

  case "$STAGE" in
    STAGE_SUCCESS)
      COMPLETED=1
      break
      ;;
    STAGE_FAILED)
      echo "Error from Pangram API: task ${TASK_ID} failed." >&2
      printf '%s' "$RESPONSE" | python3 -m json.tool >&2
      exit 1
      ;;
    *)
      sleep_before_retry || break
      ;;
  esac
done

if [[ "$COMPLETED" -ne 1 ]]; then
  echo "Error: Pangram task ${TASK_ID} did not complete within ${TIMEOUT_SECONDS} seconds." >&2
  exit 1
fi

# Check for errors and format successful output in one parse
if FORMATTED_RESPONSE=$(printf '%s' "$RESPONSE" | python3 -c '
import json, sys
data = json.load(sys.stdin)
if "error" in data:
    raise SystemExit(1)
json.dump(data, sys.stdout, indent=4)
print()
' 2>/dev/null); then
  printf '%s\n' "$FORMATTED_RESPONSE"
else
  echo "Error from Pangram API:" >&2
  echo "$RESPONSE" | python3 -m json.tool >&2
  exit 1
fi
