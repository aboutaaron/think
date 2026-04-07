---
name: bookmark
version: 1.0.0
description: Quick capture for ideas, tools, links, or concepts to revisit later. Use when asked to "bookmark this", "park it", "save for later", "not now but eventually", "come back to this", or when the user mentions something interesting but wants to defer it. Pure capture — no analysis, no evaluation.
---

# Bookmark

Capture something worth revisiting without breaking your current flow. This is a utility — park the idea, categorize it, move on.

## When to Use

- User finds something interesting but doesn't want to go deep right now
- A tool, article, concept, or idea comes up mid-conversation that's off-topic
- User explicitly says "bookmark this", "park it", "save for later", "not now but eventually"

## The Three Steps

### Step 1: What Are We Bookmarking?

Identify the thing being captured. Ask if not obvious from context.

- **URL** — article, tool, repo, resource
- **Idea** — something to build, write, or try
- **Tool** — software, framework, service to evaluate
- **Concept** — mental model, framework, technique to learn

Capture a one-line description. If the user gave you a URL, include it.

### Step 2: Why Not Now?

Ask (or infer from context) why this is being deferred:

- **Needs more data** — not enough info to act on yet
- **Wrong time** — relevant later, not now
- **Dependency** — blocked by something else
- **Lower priority** — interesting but not urgent

One sentence is enough. This is for future-you to understand why past-you parked it.

### Step 3: Categorize + Append

Assign one category:

| Category | When to use |
|----------|-------------|
| **Build Later** | Something to create — a project, feature, tool, or piece of writing |
| **Explore When Relevant** | Worth investigating when the right context arises |
| **Reference** | Useful to have on hand — no action needed, just awareness |

### Append to Bookmarks File

File path: `BOOKMARKS_FILE` environment variable, or `docs/bookmarks.md` by default.

If the file doesn't exist, create it with this header:

```markdown
# Bookmarks

Ideas, tools, links, and concepts to revisit later.

---
```

Append the entry:

```markdown
## [One-line description]

- **Date:** YYYY-MM-DD
- **Category:** [Build Later | Explore When Relevant | Reference]
- **Type:** [URL | Idea | Tool | Concept]
- **Why not now:** [One sentence]
- **Source:** [URL, conversation context, or "organic"]

---
```

### Commit

```bash
git add [bookmarks file path]
git commit -m "bookmark: [one-line description]"
```

## Guidelines

- **Speed over precision.** This is capture, not curation. Get it down in 30 seconds.
- **Don't evaluate.** Don't say "this looks promising" or "you should prioritize this." Just file it.
- **One entry, one commit.** Keep the git history clean and scannable.
- **Infer when obvious.** If the user says "park that link for later," you don't need to ask all three questions — fill in what's clear from context, ask only what's ambiguous.
- **Review during weekly-review.** Bookmarks are inputs to the `weekly-review` skill — scan them when reflecting on what to carry forward.
