---
name: publish
version: 2.0.0
description: Use when a blog post draft is finalized and it's time to ship — "publish this", "ship this post", "get this ready to publish". Runs a gated pipeline: pre-flight, AI detection, boss-check, OG image, metadata, deploy, social previews, Buttondown archive, LinkedIn hook.
---

# Publish

End-to-end publishing pipeline for blog posts. Ensures nothing gets missed between "draft is done" and "post is live and promoted."

Each step below states a goal and a gate. The exact commands, paths, and API calls for the author's current setup live in [`references/mechanics.md`](references/mechanics.md) — read that file when a step needs them. When the setup changes (new blog layout, new image tool, new API shape), update the reference file, not this workflow.

## Prerequisites

- Blog post markdown file with YAML frontmatter (`title`, `date`, `summary`)
- Credentials: `PANGRAM_API_KEY` (AI detection), `BUTTONDOWN_API_KEY` (newsletter archive)
- An image generation tool for the OG image

## Pipeline

Run each step in order. Gate on failures — don't skip steps.

### Step 1: Pre-flight checks

Read the post. Verify:
- [ ] Title, date, and summary are set in frontmatter
- [ ] Post reads complete — no TODOs, no placeholder sections
- [ ] Summary is long enough for link previews (LinkedIn currently requires 100+ characters)

If the summary is too short, expand it before proceeding.

### Step 2: AI Detection (Pangram)

Run the post through the `ai-detector` skill.

- **0-20% AI:** ✅ Proceed
- **20-40% AI:** 🟡 Flag sections. Ask the author if they want to voice-note the flagged parts.
- **40%+ AI:** 🔴 Stop. The author needs to voice-note the flagged sections. Do NOT attempt to rewrite — AI rewriting AI makes detection worse.

### Step 3: Boss Check

Run the post through the `boss-check` skill.

- **All 🟢:** Proceed
- **Any 🟡:** Flag for author review. Proceed if author approves.
- **Any 🔴:** Stop. Author must revise before publishing.

### Step 4: Generate OG Image

Goal: an editorial illustration in the site's style, resized to the 1200x630 OG standard as a JPG under 100KB, saved where the blog serves OG images (path in the mechanics reference).

Use whatever image generation tool is available in the current environment (the author's current tool is noted in the mechanics reference). Style spec:

```
Editorial geometric illustration on warm cream parchment background.
A minimalist visual metaphor for "[TITLE]" — [SUMMARY context].
Rendered in thin precise black lines on a subtle grid, with elements
fragmenting into scattered geometric shapes — sharp triangles, thin
hexagon outlines, angular fragments. Predominantly monochrome — black
lines, charcoal fills, light gray tones on cream background. Single
accent color: deep muted indigo blue, used sparingly on key geometric
fragments. Thin precise linework throughout, like technical drawing or
Bloomberg terminal aesthetics. No cartoon style. No thick strokes.
Sharp, editorial, sophisticated. No text, no people.
```

### Step 5: Set Metadata

Point the post's frontmatter at the saved image:
```yaml
ogImage: "/og/[slug].jpg"
```

### Step 6: Commit and Deploy

Branch, commit the post and image (commit convention in the mechanics reference), open a PR. Merge after author approval. Wait for deploy.

### Step 7: Verify Social Previews

After deploy, paste the live URL into the [LinkedIn Post Inspector](https://www.linkedin.com/post-inspector/) and verify title, description, and image render correctly. Re-inspect to clear a stale cache. If the author plans to share on other platforms, spot-check with that platform's current preview/debug tool.

### Step 8: Buttondown Archive

Create the post as an email in Buttondown and set its status to `archived` — not `sent`; the RSS-to-email automation handles delivery to current subscribers. Archiving makes the post browsable to subscribers who join later. API details: [Buttondown's API docs](https://docs.buttondown.com/) plus the mechanics reference.

### Step 9: Draft LinkedIn Hook

Draft a LinkedIn post promoting the essay, in the author's voice (`~/.think/style-guide.md`).

**Requirements:**
- Run boss-check and Pangram on the hook
- If not posting immediately, append it to the LinkedIn queue (location and entry format in the mechanics reference)

### Step 10: Summary

Report:
```
✅ Published: [title]
   URL: [url]
   Pangram: [score]% AI
   Boss-check: [result]
   OG Image: [path]
   Buttondown: archived
   LinkedIn hook: [queued/posted]
   Social previews: [verified/pending]
```

## Notes

- **RSS handles newsletter delivery.** Buttondown's RSS-to-email automation sends new posts to subscribers automatically. The manual Buttondown step is just for archival.
- **OG image style should match the site.** Warm cream/parchment palette, geometric, editorial. No stock photos, no AI faces, no generic tech imagery.
- **LinkedIn hooks are separate from the post.** They promote the *idea*, not summarize the post. The hook should make someone curious, not give away the argument.
