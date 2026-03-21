---
name: "cmd-think:phv"
description: Map content against Personal House Views — confirm, challenge, or update positions
---

# Think: PHV

<command_purpose>Map content against Personal House Views. Determine whether the source confirms, challenges, or suggests updates to existing positions.</command_purpose>

## Target

<source> #$ARGUMENTS </source>

## Instructions

1. Load and follow the **phv-challenge** skill (loaded from workspace skills)
2. Read the House Views file (configured in `thinking-pipeline.local.md` or at `docs/house-views.md`)
3. Read or fetch the source material
4. Map each relevant claim against existing House Views

## Next Steps

After the PHV challenge, suggest:

> **What next?**
> - (a) Update the House Views file with new positions
> - (b) `/think:receipt` — create a citation receipt from this source
> - (c) `/think:architect` — stress-test any challenged positions
