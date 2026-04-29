# Think

A cognitive toolkit for AI-assisted thinking. Install it in OpenClaw, Claude Code, Codex, or Cursor.

## Contents

- [Why This Exists](#why-this-exists)
- [Quick Start](#quick-start)
- [Skills](#skills)
- [Installation](#installation)
- [Configuration](#configuration)
- [The Pipeline](#the-pipeline)

## Why This Exists

I kept asking AI for serious work and getting plausible work back.

A memo sounded like a memo. A strategy doc had the right shape. A LinkedIn post looked publishable, at least if you squinted. The problem was not that the output was bad. The problem was that I could get all the way to a fluent artifact without doing enough thinking first.

Ines Lee named the trap in ["Think First, AI Second"](https://every.to/p/think-first-ai-second): AI fluency can create the illusion of understanding. You read the answer, it sounds right, and you ship it before you have built your own mental model.

That essay changed how I work. I started using patterns like five questions, devil's advocate, Feynman tests, and structural gap analysis before asking AI to produce anything polished. The result was not just better writing. It was better thinking.

When I ran a job description through `argument-architect`, it did more than tighten the prose. It forced me to clarify how the role would actually work once someone was hired. When I used `devils-advocate` on a strategy memo, it surfaced the objections I would hear in the room before I walked into it.

That is the point of Think: use AI to sharpen judgment, not replace it.

This is for people using AI on work where being plausible is not good enough: managers, engineers, writers, operators, and anyone else making judgment-heavy decisions with a very confident autocomplete machine nearby.

Think first. Then let AI help you execute.

## Quick Start

Clone the repo:

```bash
git clone https://github.com/aboutaaron/think.git
cd think
npm install
```

Install for Claude Code or Codex:

```bash
npx tsx cli.ts install claude-code --dir ~/.claude/commands
npx tsx cli.ts install codex --dir ~/.agents/skills
```

Cursor and OpenClaw installs are below.

Then use a skill by name:

```text
Use argument-architect to stress-test this memo.
```

Or run the full review pipeline:

```text
recall-first -> argument-architect -> devils-advocate -> editorial-review
```

Each step feeds the next. Pause, revise, or skip whenever the work needs it.

## Skills

### Thinking

| Skill | Trigger | What it does |
|---|---|---|
| `recall-first` | "test my recall" | Prove you remember before getting new input. |
| `feynman-test` | "test my understanding" | Explain it simply or you probably do not understand it yet. |
| `five-questions` | "ask before you answer" | Ask five high-leverage questions before producing anything. |

Question pacing is built into `five-questions`, `recall-first`, and `feynman-test`: one question at a time, with reasoning required before moving on.

### Building Arguments

| Skill | Trigger | What it does |
|---|---|---|
| `argument-architect` | "stress-test my argument" | Find gaps and suggest one-sentence fixes. |
| `devils-advocate` | "tear this apart" | Give the three strongest counterarguments, no mercy. |

### Publishing

| Skill | Trigger | What it does |
|---|---|---|
| `style-guide` | "edit this in my voice" | Apply your writing style from `~/.think/style-guide.md`. |
| `source-to-receipt` | "make this a receipt" | Turn an article into one inline citation with link text. |
| `editorial-review` | "would you publish this" | Give a publish, revise, or reject call with concrete feedback. |
| `publish` | "publish this" | Run metadata, OG image, Pangram, boss-check, Buttondown archive, and LinkedIn hook steps. |

### Borrowed Frameworks

| Skill | Trigger | What it does |
|---|---|---|
| `lens` | "evaluate through [X] lens" | Build and apply custom evaluation frameworks from source material, with revision triggers so they do not quietly become dogma. |

Think ships with an example lens built from [Slow Ventures' public investment framework](https://drive.google.com/drive/folders/1UFR7j494QOMYRyE7yC1qcjLH3iocRkQJ). See `skills/lens/examples/slow-ventures.md`.

### Confidence and Knowledge Hygiene

| Skill | Trigger | What it does |
|---|---|---|
| `confidence-check` | "gut check" / "how sure are we" | Separate what you know from what you assume. |
| `stale-check` | "does this contradict anything" | Catch outdated knowledge before saving new learnings. |

### Reflection

| Skill | Trigger | What it does |
|---|---|---|
| `weekly-review` | "weekly review" | Reflect on what shipped, what changed, and what carries forward. |
| `decision-journal` | "log this decision" | Track decisions with expected outcomes, then review them later. |

### House Views

| Skill | Trigger | What it does |
|---|---|---|
| `phv-create` | "create my house views" | Build a Personal House Views document from scratch. |
| `phv-challenge` | "PHV check" | Test new content against your House Views. |

### Publishing Safety

| Skill | Trigger | What it does |
|---|---|---|
| `ai-detector` | "run Pangram" | Check text for AI-generated sections through Pangram Labs. |
| `boss-check` | "vet this for my boss" | Flag language that could land badly with leadership. |

### Networking and Career

| Skill | Trigger | What it does |
|---|---|---|
| `cold-outreach` | "draft an outreach email" | Use the NEXT Careers framework for peer conversation outreach. |
| `elevator-pitch` | "build my pitch" | Draft a personal brand statement and tailored elevator pitch. |
| `negotiate` | "help me negotiate" | Plan compensation negotiation strategy, equity framing, and scripts. |

### Maintenance

| Skill | Trigger | What it does |
|---|---|---|
| `skill-audit` | "audit my skills" | Review each skill monthly: keep, merge, revise, or kill. |
| `bookmark` | "bookmark this" | Capture deferred ideas, tools, links, or concepts. |

## What Are House Views?

House Views are falsifiable positions you hold about the world: named, tracked, and actively challenged. The concept comes from Azeem Azhar's ["The Lantern and the Flame"](https://www.exponentialview.co/p/the-lantern-and-the-flame), where he describes codifying what he already believes so new arguments face challenge rather than confirmation.

Each House View has a position, sources, a "therefore" for decisions, and a revision trigger for what would change your mind. Use `phv-create` to build yours, then `phv-challenge` to test them against what you read.

## Installation

Clone the repo and install dependencies:

```bash
git clone https://github.com/aboutaaron/think.git
cd think
npm install
```

Then install skills for your platform.

### Claude Code

Claude Code slash commands are project-scoped. They are only available in the directory where you install them.

Install globally:

```bash
npx tsx cli.ts install claude-code --dir ~/.claude/commands
```

Install in one project:

```bash
cd ~/my-project
npx tsx ~/path/to/think/cli.ts install claude-code
```

This installs skills as `/think:*` slash commands, such as `/think:five-questions` and `/think:argument-architect`.

### OpenAI Codex

Install globally or in the current project:

```bash
npx tsx cli.ts install codex --dir ~/.agents/skills
npx tsx cli.ts install codex
```

This installs skills with full `SKILL.md` files and references in `.agents/skills/`.

### Cursor

```bash
npx tsx cli.ts install cursor
```

This installs skills as rules in `.cursor/rules/`. Reference them by name in chat: "Use the argument-architect skill on this document."

### OpenClaw

```bash
npx tsx cli.ts install openclaw
```

This installs skills to `~/.openclaw/workspace/skills/think/`. They load automatically on the next session.

### Options

```bash
npx tsx cli.ts install claude-code --dir ./my-project/.claude/commands
npx tsx cli.ts install all
npx tsx cli.ts install all --dry-run
```

## Configuration

### Personal Files at `~/.think/`

Skills that use personal content read from `~/.think/`, outside any git repo, to reduce the chance of committing sensitive material.

```bash
mkdir -p ~/.think
```

The installer creates this directory automatically.

| File | Purpose | Env var override |
|---|---|---|
| `~/.think/profile.md` | Name, role, website, LinkedIn | — |
| `~/.think/style-guide.md` | Personal writing voice | `THINKING_STYLE_FILE` |
| `~/.think/work-style-guide.md` | Work writing voice | `THINKING_STYLE_FILE` |
| `~/.think/house-views.md` | Personal House Views | `THINKING_PHV_FILE` |
| `~/.think/work-house-views.md` | Work House Views | `THINKING_PHV_FILE` |
| `~/.think/lenses/*.md` | Custom evaluation frameworks | — |

If no file exists, `style-guide` and `phv-create` will interview you to create one.

Add env var overrides to your shell profile, such as `.bashrc` or `.zshrc`, to switch between personal and work contexts.

## The Pipeline

The core workflow is simple: remember what you know, build the argument, attack it, then decide whether it is ready.

```text
recall-first -> argument-architect -> devils-advocate -> editorial-review
```

Run it when the output needs to survive contact with a real reader, teammate, or decision.

## Credits and Inspiration

- ["Think First, AI Second"](https://every.to/p/think-first-ai-second) by Ines Lee at Every. The essay that started all of this.
- ["The Lantern and the Flame"](https://www.exponentialview.co/p/the-lantern-and-the-flame) by Azeem Azhar at Exponential View. The House Views framework for falsifiable beliefs.
- [NEXT Careers](https://www.linkedin.com/company/nextcareers/). Its networking, personal branding, and compensation frameworks inform `cold-outreach`, `elevator-pitch`, and `negotiate`.
- [Compound Engineering](https://github.com/cescobarresi/compound-engineering). The OpenClaw plugin architecture and slash command pattern helped shape this project.

Built by [Aaron Williams](https://acwx.net).
