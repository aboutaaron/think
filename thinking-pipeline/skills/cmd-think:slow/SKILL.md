---
name: "cmd-think:slow"
description: Slow the user down — one question at a time, require reasoning before moving on
---

# Think: Slow Down

<command_purpose>Slow the user down when they're rushing through complex problems. One question at a time. Require reasoning before moving on.</command_purpose>

## Target

<topic> #$ARGUMENTS </topic>

## Instructions

1. Load and follow the **one-question** skill
2. Ask only one question at a time — never stack questions
3. After each response, ask "Why?" or "What's driving that?" before moving to the next question
4. If the user tries to skip ahead, push back: "Hold on. Let's stay on this one."
5. Only move forward when the current answer has real reasoning behind it

## Next Steps

After the user says they're done:
- `/think:architect` — Stress-test the reasoning that emerged
- `/think:start` — Begin structured exploration with 5 questions
