# Think

A cognitive toolkit for AI-assisted thinking — works with OpenClaw, Claude Code, and Cursor.

## Why This Exists

I built these skills because I noticed a pattern: AI makes it easy to produce work, but it also makes it easy to skip thinking. You ask for a memo, you get a memo. You ask for a strategy doc, you get a strategy doc. It's fluent, it's confident, and it's often generic — because *you* didn't do the hard part first.

The turning point was Ines Lee's ["Think First, AI Second"](https://every.to/p/think-first-ai-second), which laid out the problem clearly: AI's fluency creates an illusion of understanding. You read the output, it sounds right, and you ship it — without ever building your own mental model of the argument. The techniques in that essay (five questions before answering, devil's advocate, structural gap analysis) immediately changed how I work.

I started using these patterns for everything — memos at work, job descriptions, LinkedIn posts, even hiring decisions. Running a draft through the argument architect doesn't just find gaps in the document. It forces me to think through how I'm actually arguing my points, anticipate the questions people will ask, and address blind spots before I present ideas to anyone. When I used it on a job description, it didn't just improve the writing — it helped me think through how the role would actually work once someone was hired. The skill improved the *thinking*, not just the artifact.

These tools are for anyone who uses AI and wants the output to reflect genuine thought, not just plausible language. I built them for myself as a manager who writes memos, strategy docs, and plans — but they apply to code, emails, LinkedIn posts, hiring docs, or anything where clarity matters. The common thread: **think first, then let AI help you execute on thinking you've already done.**

## Skills

### 🧠 Thinking
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **recall-first** | "test my recall" | Prove you remember before getting new input |
| **feynman-test** | "test my understanding" | Explain it simply or you don't get it |
| **five-questions** | "ask before you answer" | 5 high-leverage questions before producing anything |

Question pacing is now built into `five-questions`, `recall-first`, and `feynman-test`: one question at a time, with reasoning required before moving on.

### 🏗️ Building Arguments
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **argument-architect** | "stress-test my argument" | Find gaps, suggest one-sentence fixes |
| **devils-advocate** | "tear this apart" | Three strongest counterarguments, no mercy |

### 📝 Publishing
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **style-guide** | "edit this in my voice" | Apply your writing style from `~/.think/style-guide.md` to any draft |
| **source-to-receipt** | "make this a receipt" | Article → one inline citation with link text |
| **editorial-review** | "would you publish this" | Publish/revise/reject with concrete feedback |

### 🔄 Reflection
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **weekly-review** | "weekly review" | Structured reflection — shipped, learned, carry forward |
| **decision-journal** | "log this decision" | Track decisions with expected outcomes, review later |

### 🧭 House Views
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **phv-create** | "create my house views" | Build a Personal House Views document from scratch |
| **phv-challenge** | "PHV check" | Map content against your House Views |

### 🛡️ Publishing Safety
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **ai-detector** | "run Pangram" | Check text for AI-generated sections via Pangram Labs API |
| **boss-check** | "vet this for my boss" | Flag language that could trigger a negative reaction from leadership |

### 🤝 Networking & Career
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **cold-outreach** | "draft an outreach email" | NEXT Careers framework, peer conversation framing |
| **elevator-pitch** | "build my pitch" | Personal brand statement + tailored elevator pitch |
| **negotiate** | "help me negotiate" | Comp negotiation strategy — market value, equity, scripting |

### 🔧 Maintenance
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **skill-audit** | "audit my skills" | Monthly health check — keep, merge, or kill each skill |
| **bookmark** | "bookmark this" | Quick capture for deferred ideas, tools, links, or concepts |

## What Are House Views?

House Views are **falsifiable positions you hold about the world** — named, tracked, and actively challenged. The concept comes from [Azeem Azhar's "The Lantern and the Flame"](https://www.exponentialview.co/p/the-lantern-and-the-flame), where he describes codifying what he already believes so new arguments face *challenge rather than confirmation*.

Each House View has a position, sources, a "therefore" (what it means for your decisions), and a revision trigger (what would change your mind). Use `phv-create` to build yours, then `phv-challenge` to test them against everything you read.

## Installation

Clone the repo and install dependencies:

```bash
git clone https://github.com/aboutaaron/think.git
cd think
npm install
```

Then install skills for your platform:

### Claude Code

Claude Code slash commands are **project-scoped** — they're only available in the directory where you install them. Choose your approach:

**Global (available in every project):**
```bash
npx tsx cli.ts install claude-code --dir ~/.claude/commands
```

**Per-project (available only in that project):**
```bash
cd ~/my-project
npx tsx ~/path/to/think/cli.ts install claude-code
```

Installs skills as `/think:*` slash commands (e.g. `/think:five-questions`, `/think:argument-architect`).

### OpenAI Codex

Same scoping applies — install globally or per-project:

```bash
npx tsx cli.ts install codex --dir ~/.agents/skills   # global
npx tsx cli.ts install codex                           # current project
```

Installs skills with full SKILL.md + reference files in `.agents/skills/`.

### Cursor

```bash
npx tsx cli.ts install cursor
```

Installs skills as rules in `.cursor/rules/`. Reference by name in chat: "Use the argument-architect skill on this document."

### OpenClaw

```bash
npx tsx cli.ts install openclaw
```

Installs skills to `~/.openclaw/workspace/skills/think/`. Auto-loaded on next session.

### Options

```bash
npx tsx cli.ts install claude-code --dir ./my-project/.claude/commands  # custom directory
npx tsx cli.ts install all                                               # all platforms
npx tsx cli.ts install all --dry-run                                     # preview without writing
```

## Configuration

### Personal files at `~/.think/`

Skills that use personal content (style guides, House Views) read from `~/.think/` — outside any git repo to prevent accidental commits of sensitive data.

```bash
mkdir -p ~/.think
```

The installer creates this directory automatically.

| File | Purpose | Env var override |
|---|---|---|
| `~/.think/style-guide.md` | Personal writing voice | `THINKING_STYLE_FILE` |
| `~/.think/work-style-guide.md` | Work writing voice | `THINKING_STYLE_FILE` |
| `~/.think/house-views.md` | Personal House Views | `THINKING_PHV_FILE` |
| `~/.think/work-house-views.md` | Work House Views | `THINKING_PHV_FILE` |

If no file exists, the style-guide and phv-create skills will interview you to create one.

Add env var overrides to your shell profile (`.bashrc`, `.zshrc`) to switch between personal and work contexts.

## The Pipeline

The recommended review sequence for any document:

```
recall-first → argument-architect → devils-advocate → editorial-review
```

Run them in order. Each step's output feeds the next. You can pause, revise, or skip at any point.

## Credits & Inspiration

- **["Think First, AI Second"](https://every.to/p/think-first-ai-second)** by Ines Lee (Every) — the essay that started all of this. Five questions, devil's advocate, Feynman test, and structural gap analysis all trace back here.
- **["The Lantern and the Flame"](https://www.exponentialview.co/p/the-lantern-and-the-flame)** by Azeem Azhar (Exponential View) — the House Views framework for codifying falsifiable beliefs
- **[NEXT Careers](https://www.linkedin.com/company/nextcareers/)** — career accelerator whose networking, personal branding, and compensation frameworks inform the cold-outreach, elevator-pitch, and negotiate skills
- **[Compound Engineering](https://github.com/cescobarresi/compound-engineering)** — the OpenClaw plugin architecture and slash command pattern that the thinking-pipeline plugin is modeled after

Built by [Aaron Williams](https://acwx.net).
