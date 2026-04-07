---
name: feynman-test
version: 1.0.0
description: Test real understanding by asking the user to explain concepts in their own words. Use when the user says "feynman test me", "test my understanding", "do I actually understand this", "quiz me on what we discussed", or after a long learning/brainstorm session to verify comprehension. Also trigger proactively after extended explanations or research sessions where the user has consumed a lot of information but hasn't articulated their own understanding. Based on Feynman's principle — if you can't explain it simply, you don't really understand it.
---

# Feynman Test

Test whether the user has genuinely internalized what they've been learning — not just consumed explanations.

## How It Works

Pick a key concept, insight, or decision from the current conversation or a referenced document. Ask the user to explain it as if teaching someone who knows nothing about the topic.

## The Prompt

Ask one concept at a time:

> **Feynman check:** Explain [specific concept] to me like I know nothing about this topic. No jargon, no referencing what I told you earlier — just your own understanding.

## Evaluation

After the user responds:

- **If they explain it clearly and simply:** Confirm, then push deeper — ask a follow-up "why" question that tests the layer underneath.
- **If they're vague, circular, or fall back on jargon:** Point out the specific gap gently. "You said [X] but didn't explain *why* that's the case. That's usually where the real understanding lives. Try again?"
- **If they freeze or say "I don't know":** That's a valuable signal, not a failure. Identify what's missing and offer to rebuild that specific piece together.

## Guidelines

- One concept at a time. Don't stack questions.
- Pick the concept that matters most, not the easiest one.
- The goal is learning, not gotcha. Be encouraging but honest.
- Don't accept the user parroting back language from the conversation. The test is whether they can explain it in *their own* words, from their own mental model.
- If used after a brainstorm or research session, focus on the core thesis or the most important decision that was made — that's where illusion of understanding is most dangerous.

## Question Pacing

- Stay on one question at a time, including follow-up "why" checks.
- Do not move to the next concept until the user has shown real reasoning, not just jargon or a memorized conclusion.

## Proactive Use

After extended sessions involving heavy reading, research synthesis, or brainstorming (e.g., analyzing multiple newsletter sources, building argument outlines, reviewing House Views), suggest a Feynman check before moving to the next phase:

> We just covered a lot of ground. Before we move on — quick Feynman check. Can you explain [the key insight] in your own words?

### Language Learning

During language lessons (e.g., Japanese practice), use Feynman checks after teaching new grammar or vocabulary. Ask the user to explain the *rule* or *pattern* in English — not just repeat the Japanese. This catches the gap between "I can mimic this" and "I understand how this works."

Example after teaching い-adjective past tense:
> Feynman check: How do you turn a Japanese い-adjective into past tense? Explain the rule to me.
