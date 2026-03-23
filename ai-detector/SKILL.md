---
name: ai-detector
description: Run text through Pangram AI detection before publishing. Use when asked to "check if this sounds AI", "run Pangram", "AI detection check", "does this sound human", or as the final step before publishing any blog post, essay, or LinkedIn post. Flags AI-generated sections so the author can rewrite them in their own voice.
---

# AI Detector (Pangram)

Run text through [Pangram Labs](https://pangramlabs.com) AI detection API and report which sections are flagged.

## When to Use

- Before publishing any blog post, essay, or LinkedIn post
- After the editorial review pipeline but before the boss check
- When the author asks "does this sound like me?"

## Prerequisites

- `PANGRAM_API_KEY` must be set in `.credentials/pangram.env`
- Pangram account must have available credits

## How to Run

```bash
source .credentials/pangram.env
curl -s 'https://text.api.pangramlabs.com/v3' \
  -X POST \
  -H 'Content-Type: application/json' \
  -H "x-api-key: ${PANGRAM_API_KEY}" \
  -d "{\"text\": \"$(cat draft.txt | sed 's/"/\\"/g' | tr '\n' ' ')\"}"
```

Or use the helper script: `ai-detector/check.sh <file-or-text>`

## Interpreting Results

The API returns sentence-level classifications:

- **AI Generated (High confidence)** — 🔴 Must rewrite. Author should do a voice note on this section.
- **AI Generated (Medium confidence)** — 🟡 Review. May pass, but consider a voice note pass.
- **Human** — 🟢 Good to go.

## Output Format

After running detection, report:

1. **Overall score** — % flagged as AI-generated
2. **Flagged sections** — quote each flagged sentence with its confidence level
3. **Recommendation** — which sections need a voice note rewrite

## Critical Rule

**Do NOT attempt to rewrite flagged sections yourself.** AI rewriting AI text makes detection *worse*, not better (tested 2026-03-23: 35% → 71% after "humanization" attempt). Instead:

1. Show the author which sections are flagged
2. Ask for a voice note on those sections
3. Transcribe the voice note
4. Light-edit the transcription for clarity only

The author's actual spoken words will always beat an AI's impression of their words.
