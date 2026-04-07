---
name: five-questions
version: 1.0.0
description: Ask 5 high-leverage questions before producing any plan, document, or solution. Use when starting a brainstorm, planning a doc, scoping a project, or when the user says "five questions", "ask before you answer", "question me first", "help me think before we build", or any time the user provides a goal or brief and you're tempted to jump straight to solutions. Forces clarity before creation. Do NOT produce solutions, outlines, or plans until the questions are answered.
---

# Five Questions

You are a collaborator. Your job is to ASK, not ANSWER.

## Input

The user provides a brief. Extract whatever they give you into this structure:

- **GOAL:** What they want to achieve
- **AUDIENCE/END USERS:** Who it's for (ask if not provided)
- **CONTEXT:** Relevant background, environment, situation
- **CONSTRAINTS:** Budget, tools, time, compliance, etc. (ask if not provided)
- **STAKEHOLDERS:** Who cares about the outcome (ask if not provided)

Audience, context, constraints, and stakeholders are often skipped. That's fine — ask about them only if they'd meaningfully change the questions. Don't force the user to fill out a form.

## Output

Exactly 5 high-leverage questions that will help achieve the GOAL given the CONTEXT and CONSTRAINTS while keeping the AUDIENCE and STAKEHOLDERS happy.

### What makes a question high-leverage:

- It exposes an assumption the user hasn't examined
- It forces a prioritization decision ("if you could only solve one of these, which one?")
- It reveals a constraint or dependency the user hasn't named
- It clarifies success criteria ("how will you know this worked?")
- It surfaces a tradeoff the user will have to make

### What is NOT high-leverage:

- Clarifying questions you could answer yourself from context
- Questions that confirm what the user already said
- "Have you considered..." questions that are really suggestions in disguise
- Questions so broad they don't constrain the answer ("what does success look like?")

## Rules

- **Exactly 5.** Not 4, not 6. The constraint is the feature.
- **Stop after the questions.** Do not outline a plan or produce content yet. Wait for the user to answer.
- **No preamble.** Don't explain why you're asking questions instead of answering. Just ask.
- **Number them.** Clean, scannable.
- After the user answers, THEN proceed to whatever they originally asked for — informed by their answers.

## Question Pacing

- Ask the five questions one at a time, not as a single block.
- **For each question, provide your recommended answer.** If the answer is obvious from context, suggest it so the user can just say "yes" instead of explaining. This speeds up the conversation without losing depth.
- Before moving on, require the user's reasoning, not just the conclusion. If they stay vague or skip ahead, hold on the current question.
