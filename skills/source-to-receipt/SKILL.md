---
name: source-to-receipt
version: 1.0.0
description: Reduce an article or source to a single inline citation ready for LinkedIn or essay writing. Use when asked to "make this a receipt", "reduce this for my post", "give me the one-liner", "how do I cite this inline", or when adding sources to the brainstorm prep doc. Follows the "sources as receipts, not the argument" principle — the source supports Aaron's voice, not the other way around.
---

# Source to Receipt

Turn a full article into a single inline citation for persuasive writing.

## Input

An article, essay, newsletter, or data point — provided as text, URL, or summary.

## Output

### Receipt Card

| Field | Value |
|-------|-------|
| **Claim** | The one specific claim from this source that supports your argument (one sentence) |
| **Link text** | The 3-6 word hyperlink text to use inline (e.g., "the median team is actually getting worse") |
| **Source** | Author, publication, date |
| **URL** | Direct link |
| **Best placement** | Which section of the current post/essay outline this fits in |
| **Sentence draft** | A complete sentence showing how to weave it in, with the link text marked in brackets |

### Example Output

| Field | Value |
|-------|-------|
| **Claim** | Median engineering teams see negative AI impact while top 5% doubled throughput |
| **Link text** | "the median team is actually getting worse" |
| **Source** | Luca Rossi, Refactoring, Mar 4 2026 |
| **URL** | https://refactoring.fm/p/the-new-pyramid-of-software-engineering |
| **Best placement** | Section 2 (What's actually happening) |
| **Sentence draft** | But [the median team is actually getting worse with AI] — more activity on feature branches, less on main, lower success rates. |

## Guidelines

- The link text should be the most compelling phrase — something the reader wants to click on.
- The claim should be factual and verifiable, not the author's opinion restated.
- If the source has multiple usable claims, pick the ONE strongest. If asked, provide alternates.
- The sentence draft should sound like Aaron's voice — direct, no hedging, no "according to."
- If there's an active post outline (check `docs/brainstorm-prep-2026-*.md`), reference specific sections.
