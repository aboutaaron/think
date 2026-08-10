# Publish Mechanics — Current Setup

The volatile companion to the `publish` skill: exact commands, paths, and API calls for the author's current blog setup. When the setup changes, update this file — the workflow in `SKILL.md` stays the same.

## OG image generation

Current tool: `nano-banana-pro` skill (Gemini 3 Pro Image). On machines where it's installed for Codex:

```bash
uv run ~/.codex/skills/nano-banana-pro/scripts/generate_image.py \
  --prompt "[style spec from SKILL.md]" \
  --filename "og-[slug].png" \
  --resolution 2K
```

If that script isn't present, use any available image generation tool with the same style spec.

## Post-processing

```python
from PIL import Image
img = Image.open("og-[slug].png")
img = img.resize((1200, 630), Image.LANCZOS).convert("RGB")
img.save("static/og/[slug].jpg", quality=85, optimize=True)
```

## Blog repo layout

- Posts: `content/blog/[slug].md`
- OG images: `static/og/[slug].jpg` (served at `/og/[slug].jpg`)
- LinkedIn queue: `docs/linkedin-queue.md`

## Commit convention

```bash
git checkout -b post/[slug]
git add content/blog/[slug].md static/og/[slug].jpg
git commit -m "post: [title]"
```

## Buttondown

Create as draft, then set status to `archived`. Current API reference: https://docs.buttondown.com/

```bash
curl -s -X POST "https://api.buttondown.com/v1/emails" \
  -H "Authorization: Token $BUTTONDOWN_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"subject": "[TITLE]", "body": "[MARKDOWN CONTENT]", "status": "draft"}'
```

## LinkedIn queue entry format

```markdown
### [date] — [title]
Source: [url]
Hook: [draft text]
Status: draft
Boss-check: [result]
Pangram: [score]%
```
