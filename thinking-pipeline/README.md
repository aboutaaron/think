# Thinking Pipeline

A cognitive toolkit for AI-assisted thinking — works with OpenClaw, Claude Code, and Cursor.

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
| **source-to-receipt** | "make this a receipt" | Article → one inline citation with link text |
| **phv-challenge** | "PHV check" | Map content against House Views |
| **editorial-review** | "would you publish this" | Publish/revise/reject with concrete feedback |

### 🤝 Networking
| Skill | Trigger | What it does |
|-------|---------|-------------|
| **cold-outreach** | "draft an outreach email" | NEXT Careers framework, peer conversation framing |

## Installation

### OpenClaw

The `thinking-pipeline/` directory is an OpenClaw plugin. Registers `/think:*` slash commands.

### Claude Code

Copy the commands to your project:

```bash
mkdir -p .claude/commands
cp claude-code/commands/* .claude/commands/
cp claude-code/CLAUDE.md .  # Optional — adds skill descriptions to project context
```

Commands are available as `/think:start`, `/think:architect`, etc.

### Cursor

**Option A — .cursorrules (recommended):**
```bash
cp cursor/thinking-pipeline.cursorrules /path/to/project/.cursorrules
```

**Option B — Individual rules:**
```bash
mkdir -p .cursor/rules
cp cursor/rules/* .cursor/rules/
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
