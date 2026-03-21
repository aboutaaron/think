---
name: "cmd-think:challenge"
description: Play devil's advocate — generate the strongest counterarguments to destroy the argument
---

# Think: Challenge

<command_purpose>Brutally honest counterargument generation. Actively try to DEFEAT the argument by steelmanning the opposing side.</command_purpose>

## Target

<document> #$ARGUMENTS </document>

## Instructions

1. Load and follow the **devils-advocate** skill (loaded from workspace skills)
2. Read the target document (file path or provided text)
3. Generate the three strongest counterarguments that could defeat the argument

## Next Steps

After the challenge is complete, suggest:

> **What next?**
> - (a) `/think:review` — editorial review to decide if it's ready to publish
> - (b) `/think:architect` — rebuild the argument architecture with these counterarguments addressed
> - (c) Revise the document to address the strongest counterarguments
