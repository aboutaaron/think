# Thinking Pipeline — Cursor Setup

Cursor doesn't support slash commands natively, but you can use these skills via project rules and the `@` mention system.

## Setup

### Option 1: Project Rules (Recommended)

Copy `thinking-pipeline.cursorrules` to your project root as `.cursorrules`:

```bash
cp thinking-pipeline.cursorrules /path/to/your/project/.cursorrules
```

This makes the skills available as instructions Cursor follows when you reference them.

### Option 2: Rules Directory

Copy individual skill files to `.cursor/rules/`:

```bash
mkdir -p /path/to/your/project/.cursor/rules/
cp rules/*.md /path/to/your/project/.cursor/rules/
```

## Usage

In Cursor chat, reference skills by name:

- "Use the argument-architect skill to analyze this document"
- "Play devil's advocate on my thesis"
- "Run an editorial review on this draft"
- "Ask me 5 questions before we start planning"
- "Test my recall on what we discussed yesterday"
