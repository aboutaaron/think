---
name: "cmd-think:architect"
description: Stress-test reasoning — analyze argument structure, find gaps, and suggest fixes
---

# Think: Architect

<command_purpose>Analyze a document's reasoning and produce a structured architecture of the thinking. Stress-test the argument for gaps, assumptions, and logical leaps.</command_purpose>

## Target

<document> #$ARGUMENTS </document>

## Instructions

1. Load and follow the **argument-architect** skill (loaded from workspace skills)
2. Read the target document (file path or provided text)
3. Produce the full four-section analysis: Main Argument, Logical Sequence, Unstated Assumptions, Suggested Fixes

## Next Steps

After the architecture is complete, suggest:

> **What next?**
> - (a) `/think:challenge` — try to destroy the argument from the other side
> - (b) `/think:review` — get an editorial publish/revise/reject decision
> - (c) Revise the document based on the findings
