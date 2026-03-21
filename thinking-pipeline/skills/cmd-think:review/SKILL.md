---
name: "cmd-think:review"
description: Editorial review — publish/revise/reject decision with concrete feedback
---

# Think: Review

<command_purpose>Review any piece of writing as a top editor at a major publication. Deliver a publish/revise/reject decision with specific feedback and next steps.</command_purpose>

## Target

<document> #$ARGUMENTS </document>

## Instructions

1. Load and follow the **editorial-review** skill (loaded from workspace skills)
2. Read the target document (file path or provided text)
3. Deliver the editorial verdict: PUBLISH, REVISE, or REJECT with concrete reasoning

## Next Steps

Based on the verdict:

> **If PUBLISH:** Done! 🎉 The piece is ready.
>
> **If REVISE:**
> - (a) `/think:architect` — rebuild the argument structure with the feedback
> - (b) Revise directly based on the editorial notes
>
> **If REJECT:**
> - (a) `/think:start` — start over with fresh five questions
> - (b) Discuss what went wrong and reframe the approach
