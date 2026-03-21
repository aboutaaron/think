---
name: "cmd-think:pipeline"
description: Run the full thinking gauntlet — recall → architect → devil's advocate → editorial review
---

# Think: Pipeline

<command_purpose>Run the full thinking pipeline sequentially with gates between each step. Each step's output feeds the next.</command_purpose>

## Target

<document> #$ARGUMENTS </document>

## Pipeline Steps

Execute in order. Each step must complete before the next begins. The user can pause, revise, or exit at any gate.

### Step 1: Recall

Load and follow the **recall-first** skill (loaded from workspace skills).

- User must recall thesis, evidence, and open concerns from memory
- If they can't recall enough, pause and rebuild before continuing
- **Gate:** User confirms they're ready to proceed

### Step 2: Architect

Load and follow the **argument-architect** skill (loaded from workspace skills).

- Analyze: main argument, logical sequence, gaps, fixes
- Present the full four-section analysis
- **Gate:** User reviews and accepts or revises before continuing

### Step 3: Challenge

Load and follow the **devils-advocate** skill (loaded from workspace skills).

- Generate the three strongest counterarguments
- User decides which counterarguments to address
- **Gate:** User confirms how to handle the challenges

### Step 4: Editorial Review

Load and follow the **editorial-review** skill (loaded from workspace skills).

- Deliver PUBLISH / REVISE / REJECT verdict
- **If REVISE:** Return to Step 2 with specific fixes
- **If PUBLISH:** Pipeline complete 🎉

## State Management

Track pipeline state throughout. At each gate, present:

> **Pipeline Progress:** Step X/4 — [step name]
> - (a) Continue to next step
> - (b) Revise and re-run current step
> - (c) Exit pipeline
