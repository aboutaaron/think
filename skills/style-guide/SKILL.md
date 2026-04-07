---
name: style-guide
version: 1.0.0
description: Apply the user's writing style, tone, and formatting preferences to any draft. Use when asked to "edit this in my voice", "apply my style", "make this sound like me", or before finalizing any blog post, essay, memo, or LinkedIn post. Prevents generic AI tone. Requires a style guide file at ~/.think/style-guide.md (personal) or ~/.think/work-style-guide.md (work).
---

# Style Guide

Apply the user's distinct writing style to drafts, outlines, or raw voice notes.

*Framework adapted from Katie Parrott's [AI Style Guides: How to Help AI Write Like You](https://every.to/guides/ai-style-guide) at Every.*

## How It Works

This skill reads a style guide file and applies it to any draft. The style guide contains the user's specific voice, tone, structure, signature moves, anti-patterns, and revision standards.

## Style Guide Location

Style guides are stored at `~/.think/` (outside any git repo) to protect personal voice details.

**Load the right guide for context:**

| Context | File | Env var |
|---|---|---|
| Blog, LinkedIn, essays | `~/.think/style-guide.md` | `THINKING_STYLE_FILE` |
| Work memos, strategy docs | `~/.think/work-style-guide.md` | `THINKING_STYLE_FILE` |

Read from the `THINKING_STYLE_FILE` env var if set, otherwise default to `~/.think/style-guide.md`.

## Process

1. **Load** the style guide file
2. **Read** the draft to be edited
3. **Apply** each section of the style guide:
   - Voice and Tone — does it sound like the author?
   - Structure — does it follow their preferred patterns?
   - Sentence-level — rhythm, punctuation, transitions
   - Signature Moves — are their distinctive patterns present?
   - Anti-patterns — flag anything they'd never write
4. **Revise** the draft to match
5. **Check** against the Revision Standards section

## Creating a Style Guide

If no style guide exists yet, interview the user to create one. Cover these 7 sections (from the Every framework):

1. **Voice and Tone** — how should it feel? Reference writers they admire with specific traits mapped.
2. **Structure** — how do they open? What's their argument pattern? How do they transition?
3. **Sentence-level** — rhythm, length, active/passive voice, punctuation preferences.
4. **Signature Moves** — recurring patterns that make their writing distinctly theirs.
5. **Anti-patterns** — things they'd never write. AI-isms, jargon, structural fails.
6. **Workflow** — how they actually write (outline first? voice note? stream of consciousness?).
7. **Revision Standards** — checklist before finalizing any draft.

Store the result at `~/.think/style-guide.md` (or `~/.think/work-style-guide.md` for work context).

## Critical Rule

**Do NOT attempt to rewrite AI-flagged sections yourself.** AI rewriting AI text makes detection *worse*, not better. Instead:

1. Show the author which sections sound off
2. Ask for a voice note on those sections
3. Transcribe the voice note
4. Light-edit the transcription for clarity only

The author's actual spoken words will always beat an AI's impression of their words.
