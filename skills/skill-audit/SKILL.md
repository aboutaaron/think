---
name: skill-audit
version: 1.0.0
description: Monthly audit of all thinking skills — are they helping or getting in the way? Use when asked to "audit my skills", "skill health check", "review my toolkit", "which skills should I keep", or on the first of the month. Produces a report with keep/merge/kill recommendations.
---

# Skill Audit

Monthly checklist to evaluate whether your thinking skills are earning their place.

## When to Run

- First of the month, or whenever the toolkit feels bloated
- After adding new skills
- When a skill feels like it's slowing you down instead of helping

## The Audit

### Step 1: Inventory

Build a table of every skill in the repo. For each one, fill in:

| Skill | Category | Purpose (one line) | Last Used | Used This Month? |
|-------|----------|--------------------|-----------|-----------------|

- **Last Used:** Check `memory/` files and recent chat history. "Unknown" is fine — that's a signal too.
- **Used This Month:** Yes / No / Unknown

### Step 2: Evaluate Each Skill

For every skill, answer three questions:

1. **Is it being used?** — If not, why? Forgotten, situational, or actually not useful?
2. **Is it redundant?** — Does another skill do the same thing? Could two skills merge without losing value?
3. **Is it constraining?** — Does it force a pattern that doesn't fit how you actually work? Does it add friction without adding clarity?

### Step 3: Recommend

For each skill, assign one label:

- **Keep** — Actively useful. No changes needed.
- **Merge** — Overlaps with another skill. Combine them.
- **Kill** — Not used, not useful, or actively harmful. Remove it.
- **Watch** — Not enough data yet. Revisit next month.

### Step 4: Flag Autoresearch Candidates

If any skill is used frequently but feels like it could be sharper, flag it:

> **Autoresearch candidate:** [skill-name] — [why it might benefit from prompt optimization]

Only flag when there's real usage data. No speculative optimization.

### Step 5: Write the Report

Save to `docs/audits/YYYY-MM-DD-skill-audit.md`:

```markdown
# Skill Audit — [date]

## Inventory

| Skill | Category | Purpose | Last Used | Recommendation |
|-------|----------|---------|-----------|---------------|
| ... | ... | ... | ... | Keep/Merge/Kill/Watch |

## Recommendations

### Kill
- [skill]: [reason]

### Merge
- [skill A] + [skill B]: [reason]

### Keep
- [skill]: [why it's earning its place]

### Watch
- [skill]: [what data would change the recommendation]

## Autoresearch Candidates
- [skill]: [what to optimize]

## Summary
- Total skills: X
- Keep: X | Merge: X | Kill: X | Watch: X
- Next audit: [date + 1 month]
```

## Guidelines

- **Be honest, not protective.** Sunk cost doesn't justify keeping a skill around.
- **"I forgot this existed" is a kill signal.** If you never reach for it, it's not helping.
- **Redundancy isn't always bad.** Two skills can overlap if they serve different moments (e.g., argument-architect vs devils-advocate). Only merge if the overlap creates confusion.
- **Compare against the last audit.** If a skill was "Watch" last month and still has no usage, that's a stronger kill signal.
- **Keep it under 20 minutes.** This is a checklist, not a research project.
