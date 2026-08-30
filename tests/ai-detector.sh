#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

cat > "$tmp_dir/curl" <<'EOF'
#!/usr/bin/env bash
call_count=0
if [[ -f "$PANGRAM_TEST_CALL_COUNT" ]]; then
  call_count=$(<"$PANGRAM_TEST_CALL_COUNT")
fi
call_count=$((call_count + 1))
printf '%s' "$call_count" > "$PANGRAM_TEST_CALL_COUNT"

args_file=$PANGRAM_TEST_POLL_ARGS
if [[ "$call_count" -eq 1 ]]; then
  args_file=$PANGRAM_TEST_SUBMIT_ARGS
fi
printf '%s\n' "$@" > "$args_file"

for arg in "$@"; do
  if [[ "$arg" == @/* && -f "${arg#@}" ]]; then
    contents=$(<"${arg#@}")
    printf '%s\n' "$contents" > "${args_file}.header"
  fi
done

if [[ "$call_count" -eq 1 ]]; then
  printf '%s\n' '{"task_id":"task-123"}'
  exit 0
fi

case "${PANGRAM_TEST_MODE:-success}" in
  failed)
    printf '%s\n' '{"stage":"STAGE_FAILED","error":"detector failed"}'
    ;;
  http-retry)
    if [[ "$call_count" -eq 2 ]]; then
      exit 22
    fi
    printf '%s\n' '{"stage":"STAGE_SUCCESS","version":"4.0","windows":[]}'
    ;;
  malformed)
    printf '%s\n' '{"detail":"temporary upstream response"}'
    ;;
  pending)
    printf '%s\n' '{"stage":"STAGE_RUNNING"}'
    ;;
  success)
    printf '%s\n' '{"stage":"STAGE_SUCCESS","version":"4.0","fraction_ai":0,"fraction_ai_assisted":0,"fraction_human":1,"windows":[{"text":"A human sentence.","label":"Human Written","confidence":"High","is_humanized":false,"humanizer_score":0}]}'
    ;;
esac
EOF
chmod +x "$tmp_dir/curl"

assert_positive_flag_value() {
  local args_file=$1
  local flag=$2

  awk -v flag="$flag" '
    previous == flag {
      if ($0 ~ /^[1-9][0-9]*$/) found = 1
    }
    { previous = $0 }
    END { exit(found ? 0 : 1) }
  ' "$args_file"
}

run_case() {
  local mode=$1
  local case_dir=$2
  local input=$3

  mkdir -p "$case_dir"
  PATH="$tmp_dir:$PATH" \
  PANGRAM_API_KEY="test-key" \
  PANGRAM_POLL_INTERVAL_SECONDS="${PANGRAM_TEST_INTERVAL:-0}" \
  PANGRAM_TIMEOUT_SECONDS="${PANGRAM_TEST_TIMEOUT:-300}" \
  PANGRAM_TEST_MODE="$mode" \
  PANGRAM_TEST_CALL_COUNT="$case_dir/call-count" \
  PANGRAM_TEST_SUBMIT_ARGS="$case_dir/submit-args" \
  PANGRAM_TEST_POLL_ARGS="$case_dir/poll-args" \
  "$repo_root/skills/ai-detector/check.sh" "$input"
}

success_dir="$tmp_dir/success"
output=$(run_case success "$success_dir" "A human sentence.")

grep -Fq 'https://text.external-api.pangram.com/task' "$success_dir/submit-args"
grep -Fq '"model": "pangram-4"' "$success_dir/submit-args"
grep -Fq 'https://text.external-api.pangram.com/task/task-123' "$success_dir/poll-args"
grep -Fxq -- '-fsS' "$success_dir/poll-args"
assert_positive_flag_value "$success_dir/submit-args" '--connect-timeout'
assert_positive_flag_value "$success_dir/submit-args" '--max-time'
assert_positive_flag_value "$success_dir/poll-args" '--connect-timeout'
assert_positive_flag_value "$success_dir/poll-args" '--max-time'
grep -Eq '^@/.*$' "$success_dir/submit-args"
grep -Eq '^@/.*$' "$success_dir/poll-args"
! grep -Fq 'test-key' "$success_dir/submit-args"
! grep -Fq 'test-key' "$success_dir/poll-args"
grep -Fxq 'x-api-key: test-key' "$success_dir/submit-args.header"
grep -Fxq 'x-api-key: test-key' "$success_dir/poll-args.header"
grep -Fq '"version": "4.0"' <<< "$output"

retry_dir="$tmp_dir/http-retry"
retry_output=$(run_case http-retry "$retry_dir" "A retry test.")
grep -Fq '"version": "4.0"' <<< "$retry_output"
grep -Fxq '3' "$retry_dir/call-count"

failed_dir="$tmp_dir/failed"
mkdir -p "$failed_dir"
if run_case failed "$failed_dir" "A failed task." >"$failed_dir/stdout" 2>"$failed_dir/stderr"; then
  echo "expected STAGE_FAILED to exit nonzero" >&2
  exit 1
fi
grep -Fq 'task task-123 failed' "$failed_dir/stderr"

malformed_dir="$tmp_dir/malformed"
mkdir -p "$malformed_dir"
if run_case malformed "$malformed_dir" "A malformed response." >"$malformed_dir/stdout" 2>"$malformed_dir/stderr"; then
  echo "expected malformed task response to exit nonzero" >&2
  exit 1
fi
grep -Fq 'invalid task response' "$malformed_dir/stderr"

pending_dir="$tmp_dir/pending"
mkdir -p "$pending_dir"
start_seconds=$SECONDS
if PANGRAM_TEST_INTERVAL=5 PANGRAM_TEST_TIMEOUT=1 \
  run_case pending "$pending_dir" "A pending task." >"$pending_dir/stdout" 2>"$pending_dir/stderr"; then
  echo "expected pending task to time out" >&2
  exit 1
fi
elapsed_seconds=$((SECONDS - start_seconds))
(( elapsed_seconds <= 2 ))
grep -Fq 'did not complete within 1 seconds' "$pending_dir/stderr"

markdown_file="$tmp_dir/draft.md"
cat > "$markdown_file" <<'EOF'
---
title: Test
---
# Heading
A **bold** [link](https://example.com).
EOF
markdown_dir="$tmp_dir/markdown"
run_case success "$markdown_dir" "$markdown_file" >/dev/null
grep -Fq '"text": "Heading\nA bold link."' "$markdown_dir/submit-args"
! grep -Fq '**' "$markdown_dir/submit-args"
! grep -Fq 'https://example.com' "$markdown_dir/submit-args"

echo "ai-detector Pangram 4 request contract passed"
