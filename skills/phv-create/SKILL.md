---
name: phv-create
description: Generate a Personal House Views document from scratch. Use when asked to "create my house views", "build my PHVs", "start my house views", "what do I believe", or when the user wants to formalize their positions on their industry, career, or domain. Based on Azeem Azhar's House Views framework from "The Lantern and the Flame."
---

# PHV Create

Build a Personal House Views document — your falsifiable positions about the world.

## What Are House Views?

House Views are a framework from [Azeem Azhar's "The Lantern and the Flame"](https://www.exponentialview.co/p/the-lantern-and-the-flame) for codifying what you believe so that new information faces challenge rather than passive absorption. They turn vague opinions into testable positions.

## Process

### Step 1: Surface Beliefs

Ask the user one question at a time to surface their strongest opinions about their domain:

1. "What's something you believe about your industry that most people get wrong?"
2. "What trend do you think everyone is overreacting to? Underreacting to?"
3. "If you had to bet your career on one prediction about the next 3 years, what would it be?"
4. "What's a common practice in your field that you think is fundamentally broken?"
5. "What skill or capability do you think will be dramatically more valuable in 3 years?"

Don't rush. Let each answer breathe. Follow up with "Why?" before moving to the next question.

### Step 2: Formalize Each View

For each strong position that emerged, structure it as a House View:

```markdown
## PHV-N: [One-sentence position]

[2-3 paragraphs explaining the position with evidence and reasoning]

Sources: [What informed this view — articles, books, experience, data]

Therefore: [What this means for your decisions — career, strategy, what you build, how you prioritize]

I'd revise this if: [Specific, observable conditions that would make you change your mind]
```

### Step 3: Add the Challenge Protocol

After all views are written, add:

```markdown
## Challenge Protocol

1. When reading new content: identify which PHVs it supports, challenges, or extends
2. When making a decision: test against PHVs — if inconsistent, revise the view or the decision
3. Review quarterly. Update immediately when a revision trigger is met.
```

### Step 4: Add a Reading List

Ask: "Who are the writers, thinkers, or sources that most influence your thinking?"

Add as an Active Reading List section — these are the inputs that feed the views.

## Output

Write the complete House Views document to the path specified by the `THINKING_PHV_FILE` env var.

**Default location:** `~/.think/house-views.md`

House Views contain personal strategic positions and potentially sensitive work context. They must be stored **outside any git repository** to prevent accidental commits. Never write PHVs to a repo's `docs/` folder or any tracked directory.

```bash
mkdir -p ~/.think
# Set in your shell profile:
export THINKING_PHV_FILE=~/.think/house-views.md
```

For work-specific PHVs, use a separate file:
```bash
export THINKING_PHV_FILE=~/.think/work-house-views.md
```

## Guidelines

- **3-7 views is the sweet spot.** Fewer than 3 means you haven't thought hard enough. More than 7 means some aren't really views — they're observations.
- **Each view must be falsifiable.** "AI will change everything" is not a view. "AI will commoditize code but not judgment" is.
- **The revision trigger is the most important part.** Without it, a view is just an opinion. With it, it's a testable hypothesis.
- **Don't manufacture views.** If the user only has 3 strong positions, stop at 3. Padding weakens the whole document.
- **Use the user's voice.** These should sound like them, not like a framework template.
- **The "therefore" must be specific to their life.** Not "therefore companies should..." but "therefore I should prioritize X in my team's roadmap."

## Next Steps

After creation, suggest:
- Use **phv-challenge** to test views against new content
- Set a quarterly review reminder
- Share with trusted peers for adversarial feedback
