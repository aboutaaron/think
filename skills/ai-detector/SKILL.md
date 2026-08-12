---
name: ai-detector
version: 1.1.0
description: Run text through Pangram AI detection before publishing. Use when asked to "check if this sounds AI", "run Pangram", "AI detection check", "does this sound human", or as the final step before publishing any blog post, essay, or LinkedIn post. Flags AI-generated sections so the author can rewrite them in their own voice.
---

# AI Detector (Pangram)

Run text through [Pangram Labs](https://pangramlabs.com) AI detection API and report which sections are flagged.

## When to Use

- Before publishing any blog post, essay, or LinkedIn post
- After the editorial review pipeline but before the boss check
- When the author asks "does this sound like me?"

## Prerequisites

- `PANGRAM_API_KEY` set in the environment (shell profile, project `.env`, or CI secret — the helper script only reads the env var, no platform-specific config needed)
- Pangram account must have available credits

## How to Run

```bash
./skills/ai-detector/check.sh draft.md        # check a file
./skills/ai-detector/check.sh "some text"     # check inline text
```

The script is the source of truth for calling the API. If it's unavailable, call the API directly per [Pangram's docs](https://www.pangramlabs.com/) rather than guessing at the current endpoint or payload shape.

**Note:** The helper script automatically strips markdown (frontmatter, links, bold, headers) before sending to the API. Raw markdown inflates AI scores — always send clean prose.

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
