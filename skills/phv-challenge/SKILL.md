---
name: phv-challenge
description: Map any article, argument, or idea against Personal House Views (PHVs) to identify what it supports, challenges, or extends. Use when asked to "map this to my house views", "PHV check", "how does this relate to my views", "challenge my views with this", or during morning briefs and article summaries when the content is substantive enough to warrant PHV analysis. Requires a House Views file — use phv-create skill to generate one if you don't have one yet.
---

# PHV Challenge

Map incoming content against your Personal House Views.

## What Are House Views?

House Views are **falsifiable positions you hold about the world** — named, tracked, and actively challenged. The concept comes from [Azeem Azhar's "The Lantern and the Flame"](https://www.exponentialview.co/p/the-lantern-and-the-flame), where he describes codifying what he already believes so that new arguments face *challenge rather than confirmation*.

Each House View has:
- **A position** — a clear, debatable claim
- **Sources** — the evidence and thinking behind it
- **A "therefore"** — what it means for your decisions
- **A revision trigger** — what would make you change your mind

The power of House Views is that they make your assumptions explicit and testable. Without them, you absorb new information passively — nodding along with whatever sounds smart. With them, every new piece of content becomes a test: does this confirm, challenge, or extend what I already believe?

If you don't have a House Views file yet, use the **phv-create** skill to build one.

## Input

Any article, essay, argument, tweet, newsletter, or idea — provided as text, URL, or email content.

## House Views Reference

Read the House Views file (configured via `THINKING_PHV_FILE` env var, or default `docs/house-views.md`).

## Output

### PHV Mapping Table

| PHV | Supports | Challenges | Extends |
|-----|----------|------------|---------|
| 1 | ... | ... | ... |
| 2 | ... | ... | ... |
| ... | ... | ... | ... |

Use "—" for cells with no connection. Not every piece maps to every PHV.

### Revision Trigger Check

If the content meets or approaches a revision trigger from any PHV, flag it explicitly:
> ⚠️ **Revision trigger alert — PHV-X:** [explain what trigger was met and why]

### One-Line Takeaway

One sentence: what does this piece mean for your thinking? Is it confirmation, new evidence, or a reason to update?

## Guidelines

- Only map genuine connections. Don't stretch to fill every cell.
- **Challenges are more valuable than supports.** If something challenges a PHV, give it more space — that's where learning happens.
- **Extends** means the source adds a dimension the PHV doesn't currently cover but should.
- Quote specific passages when claiming support or challenge. No vague "this relates to PHV-2."
- If the content doesn't meaningfully connect to any PHV, say so: "No meaningful PHV connections. Interesting but outside your thesis framework."
