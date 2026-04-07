---
name: ai-detector
version: 1.0.0
description: Run text through Pangram AI detection before publishing. Use when asked to "check if this sounds AI", "run Pangram", "AI detection check", "does this sound human", or as the final step before publishing any blog post, essay, or LinkedIn post. Flags AI-generated sections so the author can rewrite them in their own voice.
---

# AI Detector (Pangram)

Run text through [Pangram Labs](https://pangramlabs.com) AI detection API and report which sections are flagged.

## When to Use

- Before publishing any blog post, essay, or LinkedIn post
- After the editorial review pipeline but before the boss check
- When the author asks "does this sound like me?"

## Prerequisites

- `PANGRAM_API_KEY` environment variable must be set
- Pangram account must have available credits

### Setting the API key

Set `PANGRAM_API_KEY` in your environment however your platform prefers:

| Platform | How to set |
|---|---|
| **Any shell** | `export PANGRAM_API_KEY=your-key` |
| **Claude Code / Codex** | Add to your project `.env` or shell profile |
| **Cursor** | Add to `.env` in your project root |
| **OpenClaw** | Add to `.credentials/pangram.env` or shell profile |
| **CI / GitHub Actions** | Repository secret → env var in workflow |

The helper script checks `PANGRAM_API_KEY` from the environment. That's it — no platform-specific config files required.

## How to Run

```bash
export PANGRAM_API_KEY=your-key
./skills/ai-detector/check.sh draft.md        # check a file
./skills/ai-detector/check.sh "some text"     # check inline text
```

Or call the API directly:

```bash
curl -s 'https://text.api.pangramlabs.com/v3' \
  -X POST \
  -H 'Content-Type: application/json' \
  -H "x-api-key: ${PANGRAM_API_KEY}" \
  -d "{\"text\": \"your text here\"}"
```

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
