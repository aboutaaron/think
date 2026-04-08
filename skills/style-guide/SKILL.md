---
name: style-guide
version: 2.0.0
description: Apply a personal writing style guide to any draft. Looks for a style guide file at ~/.think/style-guide.md (or a path specified by the user). Use when asked to "edit this in my voice", "apply my style", "make this sound like me", or before finalizing any written piece.
---

# Style Guide Skill

This skill applies a **personal writing style guide** to drafts, outlines, or raw voice notes. It does not ship a style guide — you build your own.

## How It Works

1. **Load the style guide** from `~/.think/style-guide.md` (default path). If no file exists, prompt the user to create one.
2. **Read the draft** being reviewed.
3. **Check the draft** against the style guide's rules — voice, tone, structure, anti-patterns, signature moves.
4. **Report violations** with specific quotes and suggested fixes.
5. **Do not rewrite** unless asked. The skill is a reviewer, not a ghostwriter.

## Building Your Style Guide

A good style guide covers:

### Voice & Tone
- How should the writing *feel*? (Conversational? Academic? Dry humor?)
- Which writers do you admire and want to draw from stylistically?
- What's your register? (Warm-but-skeptical? Direct-and-unapologetic? Measured-and-precise?)

### Structure
- How do you open pieces? (Scene first? Thesis first? Quote then pivot?)
- What's your section flow pattern?
- How do you handle transitions? (Structural? Verbal crutches?)
- What do your section headers sound like?

### Sentence-Level
- Sentence length and rhythm preferences
- Active vs passive voice
- Punctuation signatures (em-dashes, semicolons, parentheticals)
- How you use italics, bold, etc.

### Signature Moves
- Your recurring rhetorical patterns. Examples:
  - The reframe ("Not X — Y")
  - The qualification ("I believe X, and I'm willing to be wrong, but...")
  - The authority quote setup (blockquote from expert → "I tested this")
  - The concrete absurdity (embarrassing personal details as evidence)
  - The imperative close (two-sentence mic drop)
- These should be observed from your actual writing, not aspirational.

### Anti-Patterns
- What you never want to sound like
- AI writing tropes to catch (see [tropes.fyi](https://tropes.fyi))
- Verbal crutches, jargon, filler transitions
- Formatting tells (bold-first bullets, unicode arrows, etc.)

### Revision Checklist
- What to verify before publishing (opening, flow, tone, ending, mobile readability)

## Tips

- **Start from your existing writing.** Pull 3-5 pieces you're proud of and extract the patterns. Don't invent a style — document the one you already have.
- **Update it after every major piece.** Your style evolves. The guide should too.
- **Katie Parrott's framework** is a good starting point: [AI Style Guides: How to Help AI Write Like You](https://every.to/guides/ai-style-guide)
- **Keep it private.** Your style guide is your competitive advantage — it's what makes AI-assisted writing sound like *you* instead of generic. Don't ship it in a public repo.

## File Location

Default: `~/.think/style-guide.md`

Override by telling the skill where to look: "apply style guide from `path/to/my-guide.md`"
