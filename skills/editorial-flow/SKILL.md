---
name: editorial-flow
description: End-to-end blog post pipeline from concept to publish. Ensures the author genuinely understands what they're writing about before drafting, then runs structural, stylistic, and readiness checks. Use when starting a new blog post, resuming a draft, or when asked "let's write", "editorial flow", "start the blog pipeline", or "let's get this post ready."
---

# Editorial Flow — Blog Post Pipeline

A seven-phase pipeline that produces blog posts grounded in real understanding, not accumulated AI notes. The key insight: if the author can't explain it from memory, it shouldn't be in the post.

## Phase 0: The Interview (Motivation & Stakes)

**Goal:** Draw out *why* the author cares about this topic right now, before testing whether they can explain it.

Ask open-ended questions:
- "Why is this on your mind?"
- "What's the friction for you personally here?"
- "What do you want readers to walk away thinking about?"
- "What's the thing you keep coming back to that nobody else is saying?"

Let the author talk. Voice notes are ideal — they produce rawer, more honest material than typed answers. Don't correct, don't structure, just collect.

**Why this exists:** The Feynman test (Phase 1) checks *knowledge*. This phase captures *motivation* and *emotional stake* — the difference between a post that's technically correct and one that has a pulse. Skipping this produces drafts that are competent but flat.

**Output:** Raw material about why this piece exists and what the author actually cares about.

## Phase 1: Feynman Test (Knowledge Check)

**Goal:** Verify the author can explain the core concepts from memory.

Run the `feynman-test` skill on the key concepts of the post. One concept at a time. Push on "why" questions. Don't accept parroting back language from drafts or prior conversations.

**Output:** The author's explanations in their own words.

## Phase 2: Gap Analysis

**Goal:** Compare what the author knows (from Phases 0-1) against collected material (drafts, notes, research, brainstorm docs).

Lay out:
- Where the author's understanding is strong
- Where there are gaps between their explanations and the drafted material
- Where the draft has ideas the author didn't mention (these may be AI-generated ideas the author hasn't internalized)
- Where the author's motivation (Phase 0) doesn't match what the outline says the post is about — this usually means the thesis needs rewriting

**Output:** A clear map of gaps — things the author needs to own before they go in the post.

## Phase 3: Concept Drilling

**Goal:** Close the gaps from Phase 2.

Drill on the specific gaps. Teach if needed. Re-test until the author can explain each concept clean. If they can't get there, the concept gets cut from the post.

**Output:** The author owns every idea in the post.

## Phase 3.5: Outline Negotiation

**Goal:** Ensure the structure reflects the author's argument, not the AI's.

Present an outline based on Phases 0-3. The author should push back — move sections, cut beats that feel thin, add things the AI didn't think of, challenge the ordering. Never ship the first outline. Treat it as a negotiation, not a proposal.

Common things to catch:
- Sections that exist because the AI thinks they "should" be there (e.g., a forced counterargument section, a "what this means for builders" listicle)
- Structure that front-loads the thesis instead of earning it through a scene
- Missing sections the author mentioned in Phase 0 that the outline dropped

**Output:** An outline the author has actively shaped, not just approved.

## Phase 4: True First Draft

**Goal:** Produce a draft built from the author's actual understanding, not accumulated notes.

Combine the author's interview material and Feynman explanations with the strongest material from research and notes. Cut anything the author can't explain. Write in their voice (use style guide if available).

**Output:** Draft 1 — grounded in real understanding.

## Phase 5: Editorial Panel (Draft 2)

**Goal:** Structural, argumentative, and editorial quality — reviewed from multiple angles simultaneously.

Run these as a **panel** (parallel, not sequential):
- `editorial-review` — structure, voice, publish/revise/reject verdict
- `argument-architect` — is the argument earning each step? Are counterarguments addressed?
- `boss-check` — would this hold up if the author's leadership read it?

Collect all feedback, then address it in a single revision pass. This prevents the draft from ping-ponging between reviewers.

**Why a panel:** A single editorial review catches surface issues but misses argument gaps. A single argument review misses voice problems. Running them together produces feedback that's more useful than either alone.

**Output:** Draft 2 — structurally sound, argument stress-tested, boss-checked.

## Phase 6: Refinement & Voice Pass (Draft 3 → Final)

**Goal:** Polish, verify readiness, and fix any remaining AI-voice flatness.

Run these checks (in order):
1. **Style guide pass** — voice, tone, anti-patterns, AI writing trope detection
2. **AI detection check** (`ai-detector` skill) — does it read as human-written?
3. **Roughening pass** — identify sections that read "too clean" or personality-flat. Have the author voice-note over those specific sections, then rewrite from their phrasing. This is the most effective de-AI-ification step.
4. **Final editorial review** — publish/revise/reject on the polished draft

**Output:** Final draft — ready to publish.

## Phase 7: Publish

**Goal:** Ship it.

Run the `publish` skill pipeline (Pangram, boss-check, OG image, newsletter archive, LinkedIn hook).

**Output:** Live post.

---

## Guidelines

- **Never skip Phase 0 or Phase 1.** The interview captures why the author cares. The Feynman test captures what they know. Together they're the foundation — everything downstream depends on them.
- **Phase 2 is where honesty lives.** Drafts accumulate ideas over weeks — some from the author, some from the AI. The gap analysis separates "things I know" from "things my AI told me."
- **The outline (Phase 3.5) is a negotiation, not a handoff.** If the author just says "looks good" to the first outline, push them. Ask "what would you move? What feels forced?"
- **The true first draft (Phase 4) will be shorter than the accumulated notes.** That's correct. Cutting is the point.
- **Phase 5 runs critics as a panel, not a gauntlet.** Parallel feedback, single revision pass. Don't make the author address three rounds of sequential feedback on the same draft.
- **Phase 6 roughening pass is critical.** The most persistent AI-voice problem isn't word choice — it's sections that are technically correct but have zero personality. The fix isn't more editing rules. It's having the author re-record those sections in their own words and rewriting from the transcript.
- **Phases 5-6 can loop.** If editorial review says "revise and resubmit," go back and revise. Don't loop more than twice — if it's not landing after two passes, the problem is usually in Phase 0-3 (understanding/motivation), not Phase 5-6 (polish).
