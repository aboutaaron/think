---
name: boss-check
description: Vet any public-facing content for language that could trigger a negative reaction from your manager or leadership. Use when asked to "boss check", "vet this for my boss", "check for hotspots", "is this safe to post", or before publishing anything on LinkedIn, a blog, Twitter, or any public platform where your employer might see it. Flags specific phrases that could be read as airing internal problems, criticizing company decisions, or revealing non-public information.
---

# Boss Check

Vet content for language that could get you in trouble with your manager or company leadership.

## Input

The draft to check — blog post, LinkedIn post, tweet, or any public-facing writing. If available, also provide:
- Who your boss is and what they care about
- Any prior feedback they've given on your public writing
- What's sensitive at your company right now (layoffs, reorgs, product issues)

## Analysis

For each potential hotspot, evaluate:

### 🔴 High Risk — Change Before Publishing
- **Names your company + a problem** — implies your employer hasn't figured something out
- **References internal processes, metrics, or decisions** — even vaguely, if someone who works there could identify it
- **Could be read as commenting on company strategy** — layoffs, reorgs, hiring freezes, product pivots
- **Reveals non-public information** — even if it seems obvious from the outside
- **Internal tool or product names in external-facing content** — names like internal dashboards, platforms, services, or codenames that an outside reader wouldn't recognize. These leak org structure and internal architecture to candidates, competitors, or the public. Replace with generic descriptions (e.g., "ProjectX and DataTool" → "dashboards, BI tools, and reporting surfaces")

### 🟡 Medium Risk — Consider Changing
- **"At my company" or "where I work"** — creates a direct link even when the observation is general
- **Specific examples that map to your actual work** — even without naming the company
- **Commentary adjacent to known company controversies** — guilt by proximity
- **Implying a problem by framing a solution** — phrases like "X isn't just an internal concern" or "as we scale, Y becomes critical" confirm the problem existed even when the intent is forward-looking. Watch for "not just," "no longer," "isn't merely," "used to be" constructions — they all anchor on a past or current deficiency. Reframe around the opportunity or the product vision instead of the gap being closed.
- **Specifics about internal AI/technical strategy in external content** — even forward-looking language like "we're building toward X" or "we're exploring how Y can be made available to Z" reveals strategic direction to competitors and may not be sanctioned by leadership. Genericize to the category of investment ("We're investing in how AI can accelerate X") without describing the specific approach, architecture, or implementation. When in doubt, check with recruiting or comms — different teams approach AI positioning differently and what feels innocuous to eng may be sensitive to the business.

### 🟢 Low Risk — Probably Fine
- **Industry-wide observations** with no company fingerprints
- **Personal philosophy** that doesn't reference internal context
- **Citing external sources** — other people's data, not yours

## Output

For each hotspot found:
1. Quote the exact phrase
2. Rate it: 🔴 🟡 🟢
3. Explain how it could be read by a skeptical manager
4. Suggest a specific fix that preserves the argument

## Guidelines

- **Assume your boss reads everything you publish.** Because they might.
- **The test isn't "is this true?" — it's "how could this be read?"** True statements about internal problems are often the most dangerous to publish.
- **Genericize, don't delete.** Most hotspots can be fixed by removing company-specific details while keeping the insight. This includes internal tool names — replace with descriptions of what they do, not what they're called.
- **Scan for internal jargon in external docs.** If the content will be read by candidates, customers, or the public, flag any internal product name, platform name, or codename that wouldn't appear on the company's public website. The reader test: would someone with no context understand this sentence?
- **When in doubt, remove the personal reference.** "At most companies" is almost always safer than "at my company" and usually makes the argument stronger anyway (broader claim = broader audience).
- **Prior feedback is gold.** If the user shares what their boss flagged before, weight similar patterns heavily.
