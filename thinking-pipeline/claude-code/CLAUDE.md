# Thinking Pipeline

This project includes thinking tools as slash commands. Use `/think:start` to begin a new thinking project, or invoke individual tools:

## Available Commands

- `/think:start` — Ask 5 high-leverage questions before producing anything
- `/think:recall` — Prove you remember before revisiting a topic
- `/think:architect` — Stress-test reasoning, find gaps, suggest fixes
- `/think:challenge` — Devil's advocate — three strongest counterarguments
- `/think:review` — Editorial review — publish/revise/reject decision
- `/think:pipeline` — Full gauntlet: recall → architect → advocate → review
- `/think:feynman` — Test real understanding — explain it simply
- `/think:receipt` — Reduce article to inline citation
- `/think:phv` — Map content against Personal House Views
- `/think:outreach` — Draft cold outreach email
- `/think:slow` — One question at a time, explain your reasoning

## Setup

Copy `commands/` to your project's `.claude/commands/` directory:

```bash
cp -r commands/ /path/to/your/project/.claude/commands/
```

## Configuration

Set `THINKING_PHV_FILE` environment variable to point to your House Views file if using `/think:phv`.
