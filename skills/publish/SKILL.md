---
name: publish
description: End-to-end publishing checklist for blog posts. Generates OG image, sets metadata, runs AI detection and boss-check, archives to Buttondown, drafts LinkedIn hook, and clears social caches. Use when asked to "publish this", "ship this post", "get this ready to publish", or when a blog post draft is finalized.
---

# Publish

End-to-end publishing pipeline for blog posts. Ensures nothing gets missed between "draft is done" and "post is live and promoted."

## Prerequisites

- Blog post markdown file with YAML frontmatter (`title`, `date`, `summary`)
- Credentials:
  - `PANGRAM_API_KEY` — for AI detection
  - `BUTTONDOWN_API_KEY` — for newsletter archival
- Access to image generation tool

## Pipeline

Run each step in order. Gate on failures — don't skip steps.

### Step 1: Pre-flight checks

Read the post. Verify:
- [ ] Title is set in frontmatter
- [ ] Date is set
- [ ] Summary is set (100+ characters for LinkedIn OG compliance)
- [ ] Post reads complete — no TODOs, no placeholder sections

If summary is under 100 characters, expand it before proceeding.

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

Generate an editorial illustration for the post:

**Prompt template:**
```
Minimalist editorial illustration for a blog post titled "[TITLE]".
[SUMMARY context]. Warm cream/parchment background. Abstract geometric
composition. Muted color palette — amber, charcoal, warm cream. No text,
no people, no photos. Clean, sophisticated, editorial magazine style.
```

**Processing:**
1. Generate at 1536x1024
2. Resize to 1200x630 (LinkedIn/Twitter OG standard)
3. Convert to JPG at 85% quality (target: under 100KB)
4. Save to blog repo at `static/og/[slug].jpg`

### Step 5: Set Metadata

Update the post's YAML frontmatter:
```yaml
ogImage: "/og/[slug].jpg"
```

Verify the summary is 100+ characters (LinkedIn requirement).

### Step 6: Commit and Deploy

```bash
git checkout -b post/[slug]
git add content/blog/[slug].md static/og/[slug].jpg
git commit -m "post: [title]"
```

Create PR. Merge after author approval. Wait for deploy.

### Step 7: Verify Social Previews

After deploy, check:
- **LinkedIn:** https://www.linkedin.com/post-inspector/ — paste the post URL, verify title, description, image render correctly
- **Twitter:** https://cards-dev.twitter.com/validator — same check

If previews are cached with old/missing data, re-inspect to clear cache.

### Step 8: Buttondown Archive

Create the post as an archived email in Buttondown so it appears in the newsletter archive (subscribers who join later can browse past posts):

```bash
curl -s -X POST "https://api.buttondown.com/v1/emails" \
  -H "Authorization: Token $BUTTONDOWN_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"subject": "[TITLE]", "body": "[MARKDOWN CONTENT]", "status": "draft"}'
```

Then set status to `archived` (not `sent` — the RSS feed handles delivery to current subscribers).

### Step 9: Draft LinkedIn Hook

Draft a LinkedIn post promoting the essay. Follow the style guide (`~/.think/style-guide.md`).

**Requirements:**
- Run boss-check on the hook
- Run Pangram on the hook
- Append to `docs/linkedin-queue.md` if not posting immediately

**Format:**
```markdown
### [date] — [title]
Source: [url]
Hook: [draft text]
Status: draft
Boss-check: [result]
Pangram: [score]%
```

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
