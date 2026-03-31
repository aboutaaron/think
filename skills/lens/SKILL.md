---
name: lens
description: Build and apply custom evaluation frameworks from any source material. Use when asked to "evaluate through [X] lens", "build a lens from [source]", "apply [framework] to this", or when the user wants to think through someone else's framework deliberately. Two modes — build (distill source material into a reusable lens) and apply (run a lens against something being evaluated).
---

# Lens

Think through someone else's framework, deliberately.

A lens is a reusable evaluation framework distilled from source material — tweets, essays, podcasts, investment theses, or any coherent body of thinking. Unlike a generic system prompt, a lens includes **revision triggers** so it stays falsifiable and doesn't silently age into dogma.

## Setup

Lenses are stored at `~/.think/lenses/`. Create the directory if it doesn't exist:

```
mkdir -p ~/.think/lenses
```

## Mode 1: Build a Lens

**Trigger:** "build a lens from [source]" or "create a [name] lens"

### Process

1. **Gather source material.** The user provides URLs, text, files, or descriptions of how a person/firm/framework thinks.

2. **Distill into principles.** Extract 4-8 core evaluation principles. Each principle needs:
   - A clear name
   - What it means (one paragraph)
   - A **test** — the specific question this principle asks of whatever is being evaluated
   - A **red flag** — what a failure looks like
   - At least one direct quote from the source material with attribution

3. **Add revision triggers.** For each principle, define what would make it obsolete or wrong. This is what separates a lens from a static prompt. Examples:
   - "Revise if enterprise SaaS multiples recover above 15x for two consecutive quarters"
   - "Revise if open-source LLMs consistently match frontier models within 3 months of release"
   - "Revise if the regulatory landscape changes to favor X"

4. **Define the evaluation output format.** What sections should the evaluation produce? Typically 4-6 structured checks plus a one-liner summary.

5. **Write the lens file** to `~/.think/lenses/[name].md` using this template:

```markdown
# [Name] Lens
*Source: [attribution and links]*
*Built: [date] · Revision: [date or "initial"]*

## Principles

### 1. [Principle Name]
[What it means — one paragraph]

> "[Direct quote from source]"
> — [Attribution, link]

**Test:** [The question this principle asks]
**Red flag:** [What failure looks like]
**Revise when:** [What would make this principle wrong or outdated]

### 2. [Next Principle]
...

## Evaluation Format

When applying this lens, produce:

**[Check Name 1]**
- [What to assess]

**[Check Name 2]**
- [What to assess]

...

**The One-Liner**
- [Blunt summary in the voice of the framework's source]

## Voice
[How the source actually communicates — direct, academic, irreverent, etc. This shapes the tone of evaluations.]
```

6. **Confirm with the user** before saving. Read back the principles and ask if anything is missing or wrong.

## Mode 2: Apply a Lens

**Trigger:** "evaluate this through [X] lens" or "apply [name] lens to this"

### Process

1. **Load the lens** from `~/.think/lenses/[name].md`. If it doesn't exist, offer to build it first.

2. **Check revision triggers.** Before applying, scan the revision triggers. If any are clearly met based on current knowledge, flag it: "Note: this lens was built [date] and the revision trigger for [principle] may have been met. Consider updating before relying on this evaluation."

3. **Take the input.** The user provides what's being evaluated — a pitch, strategy doc, blog draft, product idea, argument, or any artifact.

4. **Run each principle** against the input. For each one:
   - Apply the **test** question
   - Check for the **red flag**
   - Be specific — cite the exact part of the input that passes or fails

5. **Produce the evaluation** in the lens's defined output format.

6. **End with the one-liner** — a blunt summary in the voice of the framework's source.

## Guidelines

- **Attribution always.** Every lens must credit its source. These are borrowed frameworks, not original thinking. Link to the original material.
- **Falsifiable > confident.** The revision triggers are the most important part. A lens without them is just a system prompt with a shelf life.
- **Don't mix lenses.** Apply one lens at a time. If the user wants multiple perspectives, run them sequentially — "Here's how [X] would see this. Now here's how [Y] would see it."
- **The user's judgment is final.** A lens is a tool for thinking, not a verdict. After the evaluation, ask: "Does this match your read, or did the lens miss something?"
- **Keep lenses small.** 4-8 principles max. If a framework needs more, it's probably two lenses.
- **Update, don't accumulate.** When a revision trigger fires, update the lens — don't just add a caveat. Old principles get replaced, not footnoted.
