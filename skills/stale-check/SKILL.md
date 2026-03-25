---
name: stale-check
description: Before saving a new learning, insight, or rule, check if it contradicts or updates something you already know. Use when the user says "stale check", "does this contradict anything", "update my knowledge", or automatically during any compound/learning-save step. Prevents knowledge rot by catching outdated beliefs. Inspired by Every's compound knowledge plugin.
---

# Stale Check

You are a knowledge auditor. Your job is to catch contradictions before they compound.

## When to Use

- Before saving a new learning or insight to any knowledge base
- After a correction or "actually, that's wrong" moment
- During periodic knowledge maintenance
- When new information directly contradicts a prior assumption

## Process

1. **State the new learning.** One sentence. What did we just learn?

2. **Search for contradictions.** Look through:
   - Project-specific knowledge files (docs/knowledge/, docs/solutions/, self-improving/)
   - Memory files (MEMORY.md, memory/*.md)
   - Any relevant skill files or configuration
   - Prior learnings saved in the same session

3. **Report findings.** Three possible outcomes:

   **No conflict:** "This is new knowledge. No existing entries contradict it. Safe to save."

   **Updates existing knowledge:** "This updates [file:line] which previously said [old thing]. The old entry should be revised to reflect [new thing]." — Then revise it.

   **Contradicts existing knowledge:** "This contradicts [file:line] which says [old thing]. We need to decide which is correct." — Present both, ask the user, then update the winner and archive or delete the loser.

4. **Save and clean.** If saving, write the new knowledge. If updating, revise the old entry in place. If contradicting, resolve first, then save.

## Rules

- **Always search before saving.** No exceptions. Even if you're "pretty sure" it's new.
- **Quote the contradiction.** Don't summarize — show the exact conflicting text.
- **Don't silently overwrite.** If something contradicts, surface it. Let the human decide.
- **Keep it fast.** This is a check, not a research project. Search, compare, report, move on.
- **Scope appropriately.** Only search files relevant to the domain. Don't scan everything every time.

## Output Format

```
## Stale Check

**New learning:** [one sentence]

**Search scope:** [which files/dirs checked]

**Finding:** [no conflict | updates existing | contradicts existing]

[If updates/contradicts:]
**Existing entry:** [file:line] — "[exact text]"
**Resolution:** [what to change and why]
```
