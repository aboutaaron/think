# Think

A cognitive toolkit for AI-assisted thinking — works with OpenClaw, Claude Code, and Cursor.

## Skills

### 🧠 Thinking
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **one-question** | "slow me down" | One question at a time, explain your reasoning |
| **recall-first** | "test my recall" | Prove you remember before getting new input |
| **feynman-test** | "test my understanding" | Explain it simply or you don't get it |
| **five-questions** | "ask before you answer" | 5 high-leverage questions before producing anything |

### 🏗️ Building Arguments
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **argument-architect** | "stress-test my argument" | Find gaps, suggest one-sentence fixes |
| **devils-advocate** | "tear this apart" | Three strongest counterarguments, no mercy |

### 📝 Publishing
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **source-to-receipt** | "make this a receipt" | Article → one inline citation with link text |
| **editorial-review** | "would you publish this" | Publish/revise/reject with concrete feedback |

### 🧭 House Views
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **phv-create** | "create my house views" | Build a Personal House Views document from scratch |
| **phv-challenge** | "PHV check" | Map content against your House Views |

### 🤝 Networking
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **cold-outreach** | "draft an outreach email" | NEXT Careers framework, peer conversation framing |

## What Are House Views?

House Views are **falsifiable positions you hold about the world** — named, tracked, and actively challenged. The concept comes from [Azeem Azhar's "The Lantern and the Flame"](https://www.exponentialview.co/p/the-lantern-and-the-flame), where he describes codifying what he already believes so new arguments face *challenge rather than confirmation*.

Each House View has a position, sources, a "therefore" (what it means for your decisions), and a revision trigger (what would change your mind). Use `phv-create` to build yours, then `phv-challenge` to test them against everything you read.

## Installation

### OpenClaw

The `thinking-pipeline/` directory is an OpenClaw plugin. Registers `/think:*` slash commands.

### Claude Code

Copy the commands to your project:

```bash
mkdir -p .claude/commands
cp thinking-pipeline/claude-code/commands/* .claude/commands/
```

Commands are available as `/think:start`, `/think:architect`, etc.

### Cursor

**Option A — .cursorrules (recommended):**
```bash
cp thinking-pipeline/cursor/thinking-pipeline.cursorrules /path/to/project/.cursorrules
```

**Option B — Individual rules:**
```bash
mkdir -p .cursor/rules
cp thinking-pipeline/cursor/rules/* .cursor/rules/
```

Reference skills by name in Cursor chat: "Use the argument-architect skill on this document."

## Configuration

Set `THINKING_PHV_FILE` to point to your House Views file for `/think:phv`:

```bash
export THINKING_PHV_FILE=docs/house-views.md
```

## The Full Pipeline

`/think:pipeline` runs all four review skills in sequence:

```
recall-first → argument-architect → devils-advocate → editorial-review
```

Each step gates the next. Available as a single command or run individually.

## Credits

House Views framework inspired by [Azeem Azhar](https://www.exponentialview.co/p/the-lantern-and-the-flame). Feynman Test based on [Richard Feynman's learning technique](https://fs.blog/feynman-technique/). NEXT Careers networking framework from [NEXT Careers](https://next-careers.circle.so/).
