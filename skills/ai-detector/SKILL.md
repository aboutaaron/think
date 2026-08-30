---
name: ai-detector
version: 1.0.1
description: Run text through Pangram AI detection before publishing. Use when asked to "check if this sounds AI", "run Pangram", "AI detection check", "does this sound human", or as the final step before publishing any blog post, essay, or LinkedIn post. Flags AI-generated sections so the author can rewrite them in their own voice.
---

# AI Detector (Pangram)

Run text through the [Pangram 4](https://www.pangram.com/blog/pangram-4-migration-guide) AI detection API and report which sections are flagged.

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

Pangram 4's REST API is asynchronous: direct integrations submit a task, then poll the returned task ID until it reaches `STAGE_SUCCESS` or `STAGE_FAILED`. Use the helper so polling, deadlines, and credential handling stay consistent. For another integration, follow Pangram's [migration guide](https://www.pangram.com/blog/pangram-4-migration-guide) and keep the API key out of command arguments.

**Note:** The helper script handles polling and automatically strips markdown (frontmatter, links, bold, headers) before sending to the API. Raw markdown inflates AI scores — always send clean prose.

## Interpreting Results

The API returns segment-level classifications:

- **AI-Generated** — 🔴 Must rewrite. Author should do a voice note on this section.
- **AI-Assisted** — 🟡 Review. Consider a voice note pass, especially for high-confidence segments.
- **Human Written** — 🟢 Good to go.

Pangram 4 also returns `is_humanized` and `humanizer_score` for each segment. Treat a humanized segment as a review signal, not proof of intent.

## Output Format

After running detection, report:

1. **Overall score** — % classified as AI-generated or AI-assisted
2. **Flagged sections** — quote each flagged segment with its label and confidence level
3. **Recommendation** — which sections need a voice note rewrite

## Critical Rule

**Do NOT attempt to rewrite flagged sections yourself.** AI rewriting AI text makes detection *worse*, not better (tested 2026-03-23: 35% → 71% after "humanization" attempt). Instead:

1. Show the author which sections are flagged
2. Ask for a voice note on those sections
3. Transcribe the voice note
4. Light-edit the transcription for clarity only

The author's actual spoken words will always beat an AI's impression of their words.
