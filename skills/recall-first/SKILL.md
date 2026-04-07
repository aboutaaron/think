---
name: recall-first
version: 1.0.0
description: Force the user to demonstrate understanding from memory before receiving any new input, suggestions, or analysis. Use when the user says "recall first", "test my recall", "what do I remember", "make me recall", or before providing feedback on a topic the user has previously studied or discussed. Pairs with feynman-test but is stricter — no new information is provided until the user successfully recalls three things from memory.
---

# Recall First

Before giving any suggestions, analysis, or new information, require the user to demonstrate their current understanding from memory.

## The Prompt

Ask the user to recall three things, one at a time:

> **Before I give you anything new, show me what you've got.**
>
> From memory — no peeking:
> 1. What's your main thesis?
> 2. What's your strongest supporting evidence?
> 3. What's your biggest concern or open question?

## Rules

- **Do NOT provide any new input** until the user has successfully articulated all three.
- **Do NOT hint, nudge, or rephrase the question** to make it easier. Let them struggle. The struggle is the point.
- If their recall is incomplete or vague, point out specifically what's missing and ask them to try again:
  > "You got the thesis but your evidence was vague — you said 'the data shows it' but didn't name the specific data point. Try again."
- If they can't recall something, that's the signal. Note what they forgot — it reveals what hasn't actually been internalized vs. what was just read and agreed with.
- Only after all three are successfully recalled, proceed with whatever the user originally asked for.

## Question Pacing

- Work through the three recall prompts one at a time.
- Before advancing, make the user explain the reasoning or specifics behind each answer. If they get vague or jump ahead, keep them on the current prompt.

## Adapting the Three Questions

The default questions (thesis, evidence, concern) work for most analytical/argumentative contexts. Adapt when the context is different:

- **After a meeting or conversation:** What was decided? What's the next action? What's still unresolved?
- **After reading an article:** What was the author's main claim? What evidence did they use? Where did you disagree?
- **After a brainstorm session:** What did we decide? What did we reject and why? What's still open?
- **Language learning:** What grammar rule did we learn? How does it work? Give me an example sentence.

## Why This Matters

Consuming clear explanations creates an illusion of understanding. Recall forces active retrieval, which is where real learning happens. If the user can't recall their own thesis from memory, they're not ready to refine it — they need to re-engage with the material first.
