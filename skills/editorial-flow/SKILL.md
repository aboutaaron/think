---
name: editorial-flow
description: End-to-end blog post pipeline from concept to publish. Ensures the author genuinely understands what they're writing about before drafting, then runs structural, stylistic, and readiness checks. Use when starting a new blog post, resuming a draft, or when asked "let's write", "editorial flow", "start the blog pipeline", or "let's get this post ready."
---

# Editorial Flow — Blog Post Pipeline

A seven-phase pipeline that produces blog posts grounded in real understanding, not accumulated AI notes. The key insight: if the author can't explain it from memory, it shouldn't be in the post.

## Phase 1: Feynman Test (Knowledge Check)

**Goal:** Verify the author can explain the core concepts from memory.

Run the `feynman-test` skill on the key concepts of the post. One concept at a time. Push on "why" questions. Don't accept parroting back language from drafts or prior conversations.

**Output:** The author's explanations in their own words.

## Phase 2: Gap Analysis

**Goal:** Compare what the author knows (from Phase 1) against collected material (drafts, notes, research, brainstorm docs).

Lay out:
- Where the author's understanding is strong
- Where there are gaps between their explanations and the drafted material
- Where the draft has ideas the author didn't mention (these may be AI-generated ideas the author hasn't internalized)

**Output:** A clear map of gaps — things the author needs to own before they go in the post.

## Phase 3: Concept Drilling

**Goal:** Close the gaps from Phase 2.

Drill on the specific gaps. Teach if needed. Re-test until the author can explain each concept clean. If they can't get there, the concept gets cut from the post.

**Output:** The author owns every idea in the post.

## Phase 4: True First Draft

**Goal:** Produce a draft built from the author's actual understanding, not accumulated notes.

Combine the author's Feynman explanations with the strongest material from research and notes. Cut anything the author can't explain. Write in their voice (use style guide if available).

**Output:** Draft 1 — grounded in real understanding.

## Phase 5: Editorial Pipeline (Draft 2)

**Goal:** Structural and editorial quality.

- Run `editorial-review` skill — get a publish/revise/reject verdict with specific feedback
- Check structure against style guide (opening, transitions, signature moves)
- Address feedback, fix structural gaps

**Output:** Draft 2 — structurally sound, editorially reviewed.

## Phase 6: Refinement & Checks (Draft 3 → Final)

**Goal:** Polish and verify readiness.

Run these checks (in order):
1. **Style guide pass** — voice, tone, anti-patterns, AI writing trope detection
2. **AI detection check** (`ai-detector` skill) — does it read as human-written?
3. **Boss check** (`boss-check` skill) — would this hold up if the author's leadership read it?
4. **Final editorial review** — publish/revise/reject on the polished draft

**Output:** Final draft — ready to publish.

## Phase 7: Publish

**Goal:** Ship it.

Run the `publish` skill pipeline (Pangram, boss-check, OG image, newsletter archive, LinkedIn hook).

**Output:** Live post.

---

## Guidelines

- **Never skip Phase 1.** The Feynman test is what makes this pipeline different from "AI writes a blog post." If the author can't explain it, it doesn't ship.
- **Phase 2 is where honesty lives.** Drafts accumulate ideas over weeks — some from the author, some from the AI. The gap analysis separates "things I know" from "things my AI told me."
- **The true first draft (Phase 4) will be shorter than the accumulated notes.** That's correct. Cutting is the point.
- **Phases 5-6 can loop.** If editorial review says "revise and resubmit," go back and revise. Don't loop more than twice — if it's not landing after two passes, the problem is usually in Phase 1-3 (understanding), not Phase 5-6 (polish).
