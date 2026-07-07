---
name: grill
version: 1.0.0
description: A relentless one-question-at-a-time interview that stress-tests a plan or design before any work begins. Use when the user says "grill me", "grill me on this", "grill this plan", "interview me", "stress-test this before I build", "walk me through the decisions", or when the user has a plan/design/approach they want hardened before execution. Different from five-questions (which asks exactly 5 and stops) — grill keeps going until every branch of the decision tree is resolved and shared understanding is reached. Different from devils-advocate (which attacks a finished position) — grill resolves open decisions collaboratively. Do NOT enact the plan until the user confirms alignment.
---

# Grill

> Adapted from Matt Pocock's `grilling` skill: https://github.com/mattpocock/skills/blob/main/skills/productivity/grilling/SKILL.md
> The core loop — interview one question at a time, walk the decision tree, look up facts but put decisions to the user, recommend an answer each time, gate before acting — is his. This version is written in the `think` house style and adapted to work beyond code (strategy docs, org/hiring calls, metric definitions, any plan with unresolved decisions).

Interview the user relentlessly about every aspect of their plan or design until you reach a shared understanding. Your job is to resolve open decisions, not to be agreeable.

## Input

The user provides a plan, design, approach, or brief they intend to act on — a doc outline, a technical approach, an org/hiring decision, a metric definition, a rollout plan, anything with unresolved decisions baked in.

## The Loop

Walk down each branch of the decision tree, resolving dependencies between decisions one at a time. A decision only becomes askable once the decisions it depends on are settled — don't ask about implementation details before the shape is agreed.

For every question:

1. **Ask exactly one question.** Asking multiple questions at once is bewildering and produces shallow answers. Wait for the response before continuing.
2. **Provide your recommended answer.** State what you'd do and why, so the user can confirm with a "yes" or push back — not carry the whole burden of thinking it through. A question without a recommendation is just offloading work.
3. **Require reasoning, not just a verdict.** If the user stays vague or jumps ahead, hold on the current question until the decision is actually made.

## Facts vs. Decisions

This is the load-bearing distinction.

- **Facts** — anything that can be looked up (in the codebase, the repo, memory, docs, prior decisions, the web). **Look them up yourself. Do not ask the user for them.** Asking the user to recall something you could retrieve wastes their time and erodes trust in the interview.
- **Decisions** — judgment calls, tradeoffs, priorities, and preferences that are genuinely the user's to make. **Put each one to the user and wait.** These are the only things worth interrupting them for.

If you're unsure whether something is a fact or a decision, try to look it up first. If the lookup resolves it, it was a fact.

## Rules

- **One question at a time.** No batching. No "and also."
- **Recommend, then wait.** Every question carries your recommended answer.
- **Never ask what you can look up.** Facts are yours to find; decisions are theirs to make.
- **Follow the dependencies.** Don't ask about a branch whose parent is still open.
- **No preamble.** Don't explain that you're about to grill them. Start with the first question.
- **Gate before acting.** Do not write the doc, build the thing, or enact the plan until the user explicitly confirms you've reached shared understanding. When you believe you're there, say so and ask for confirmation rather than assuming it.

## Output

There is no artifact until the end. The output of the loop is a resolved plan and an explicit confirmation of shared understanding. Only then proceed to whatever the user originally set out to do — now informed by every decision you surfaced.
