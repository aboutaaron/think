# Skill Writing Review — 2026-08-10

A review of every skill in this repo against the lessons in PostHog's
["What nobody tells you about writing agent skills"](https://newsletter.posthog.com/p/what-nobody-tells-you-about-writing)
(Product for Engineers, 2026-08-03).

## The article's five lessons, compressed

1. **Master progressive disclosure.** Skills are routers. The name and
   description are the only part always in context, so they should say *when
   to reach for the skill*, not just what it is. Too many skills or too-long
   descriptions degrade routing. Inside the skill, sections should route to
   references rather than inline everything.
2. **Skills aren't just code.** Be **precise** about the goal (what "done"
   looks like, how to self-verify), constraints, and context the agent can't
   derive. Be **ambiguous** about steps, failure handling, and runtime
   specifics (paths, counts, versions, file lists). Over-specification strips
   the intelligence you're paying for.
3. **Skills rot — prevent it.** Split durable structure from volatile
   content. Point to a single source of truth (docs, URLs) instead of copying
   content in. Regenerate from a stable base instead of piling on patches.
4. **Ask the agent questions.** The agent knows which tools it has and what
   broke last run. Ask it before and after writing a skill.
5. **Not everything deserves a skill.** Write skills for work that is
   repeated, that agents do badly by default, that needs context models don't
   have, or that can run on autopilot.

## What this repo already does well

Calibration first: most of these skills are in good shape by the article's
standards, and several of its recommendations are already house style here.

- **Trigger-phrase descriptions.** Nearly every description includes quoted
  activation phrases ("grill me", "boss check", "make this a receipt"). This
  is exactly the router behavior lesson 1 asks for.
- **Cross-skill disambiguation.** `devils-advocate` vs `argument-architect`,
  `grill` vs `five-questions` vs `devils-advocate`, `recall-first` vs
  `feynman-test` — the descriptions explicitly contrast with their neighbors,
  which is the main defense against wrong-skill routing in a 25-skill
  toolkit.
- **Explicit output formats and exit criteria.** Most skills define the
  artifact ("exactly four sections", "three counterarguments maximum",
  publish/revise/reject verdicts, gates like "do not act until the user
  confirms alignment"). Lesson 2's "precise about the goal" is largely
  satisfied.
- **Constraint-style protocols, not step scripts.** The interview skills
  (`five-questions`, `grill`, `recall-first`, `feynman-test`) prescribe
  constraints (one question at a time, recommend an answer, require
  reasoning) rather than steps. That's the right kind of precision.
- **`~/.think/` as a single source of truth** for personal context (profile,
  style guides, house views, lenses), with env-var overrides. Lesson 3
  in practice.
- **`skill-audit` exists** and implements lesson 5 (keep/merge/kill on a
  schedule, "I forgot this existed is a kill signal").
- **Skills invoke each other by name** (`editorial-flow` and `publish`
  orchestrate `ai-detector`, `boss-check`, `editorial-review`) instead of
  duplicating their content — progressive disclosure across skills.

## Recommended modifications

Ordered by priority. P1 items are rot or breakage already present; P2 items
are drift the article predicts; P3 items are polish.

### P1 — Fix rot that already bites

**1. `publish` is the biggest over-specification and rot risk in the repo.**
It hardcodes runtime specifics the article says to leave ambiguous, and
volatile external facts it says to link instead of copy:

- `uv run ~/.codex/skills/nano-banana-pro/scripts/generate_image.py` — a
  machine-specific path to a skill that isn't in this repo. Breaks for any
  other install. Rephrase as a goal: "generate the OG image with whatever
  image-generation tool is available" and keep the style prompt (that prompt
  *is* context the model can't derive — keep it).
- `https://cards-dev.twitter.com/validator` — the Twitter card validator was
  shut down years ago. Dead link shipped as a checklist step.
- Blog-repo layout (`static/og/[slug].jpg`, `content/blog/`,
  `docs/linkedin-queue.md`) and the "summary must be 100+ characters for
  LinkedIn" rule are volatile external/runtime facts. Move the site-specific
  paths and the exact Buttondown `curl` into
  `skills/publish/references/` (durable workflow in SKILL.md, volatile
  mechanics in references), and link Buttondown/LinkedIn requirements to
  their docs rather than restating them.

The 10-step gated pipeline itself is fine — publishing is a checklist by
nature — but each step should state the goal and gate, not the exact command.

**2. De-personalize `cold-outreach` and `source-to-receipt`.**
Both hardcode "Aaron" ("what Aaron and this person have in common", "sound
like Aaron's voice", "unless Aaron specifies"). The repo already has the
right abstraction — `~/.think/profile.md` and `~/.think/style-guide.md` —
so these should say "the user (per `~/.think/profile.md`)" and "the user's
voice (per the style guide)". This is both a reusability bug for a public
toolkit and a lesson-3 violation (personal context duplicated into skills
instead of pointed at).

**3. `source-to-receipt` references `docs/brainstorm-prep-2026-*.md`.**
A dated glob for one workspace — the definition of a runtime specific.
Replace with "if there's an active outline or prep doc in the current
project, reference its sections."

### P2 — Drift the article predicts

**4. `stale-check` hardcodes another system's layout.** The search list
(`docs/knowledge/`, `docs/solutions/`, `self-improving/`, `MEMORY.md`,
`memory/*.md`) is inherited from compound-engineering conventions and won't
match most projects. Per lesson 2, make the step ambiguous: "find where this
project stores knowledge/memory (memory files, knowledge dirs, CLAUDE.md /
AGENTS.md) and search there," with the current list demoted to examples.

**5. `ai-detector`'s platform table and API snippet are volatile.** The
five-row "how to set an env var per platform" table will drift and adds
little (setting an env var is not something agents do badly by default).
Collapse to one line. Keep the `check.sh` usage; for the raw API, link to
Pangram's docs as the source of truth rather than pinning the `v3` payload
shape inline.

**6. `boss-check` and `editorial-review` are accreting patches.** The git
history shows the pattern the article warns about: very specific learned
bullets grafted on over time ("implying a problem by framing a solution"
watch-phrases in boss-check; abstraction-level coherence and
parallel-section drift in editorial-review). The content is genuinely good —
it's earned, incident-derived context. But per "regenerate, don't patch":
next time either skill needs an addition, rewrite the section from scratch
so the rubric stays coherent (durable structure = the risk tiers / review
dimensions; volatile content = the learned phrase patterns). If the learned
patterns keep growing, move them to `references/learned-patterns.md`.

**7. Trim the longest descriptions.** Twenty-five descriptions at 40–100
words each is roughly 1,500 words permanently in context — the exact failure
mode PostHog hit ("effectiveness declined as skill descriptions filled the
context window"). Keep the trigger phrases and the disambiguation contrasts
(those do routing work); cut restated body content. Worst offenders: `grill`
(~100 words — the Matt Pocock attribution and the double contrast can live
in the body), `argument-architect`, `boss-check`, `feynman-test`. Target:
under ~50 words each, "when first, what last" per the article's
name/description pattern.

### P3 — Polish and process

**8. Encode the article's rules in AGENTS.md.** The highest-leverage change
is durable structure: add a "Writing a new skill" checklist to AGENTS.md so
future skills inherit the lessons —
(a) description says *when*, under ~50 words, disambiguates from neighbors;
(b) precise about goal/constraints/non-derivable context, ambiguous about
steps/failures/runtime specifics; (c) volatile content goes in `references/`
or a URL, never inline; (d) before adding, ask "would the agent get this
wrong without a skill?" and "have I done this three times, will I do it
three more?"

**9. Add lesson 4 to `skill-audit`.** The audit evaluates skills from usage
history but never asks the agent. Add a step: "For each Keep/Watch skill,
ask: based on recent runs, what broke, what was missing, what would you
change?" That's the article's cheapest improvement loop, and it feeds the
existing "autoresearch candidates" section.

**10. Flag `recall-first` + `feynman-test` as merge candidates.** They share
a purpose (verify understanding before proceeding), pacing rules, and
adjacent triggers. The descriptions disambiguate well, so this isn't urgent —
but per lesson 5's context-cost framing, note them for the next `skill-audit`
run as a possible single skill with a strict mode.

## What NOT to change

Worth stating, because the article could be over-applied:

- **Don't loosen the interview skills.** "Exactly 5", "one question at a
  time", "do not act until confirmed" look like over-specification but are
  constraints on interaction, not steps — the article explicitly endorses
  precision about constraints. The constraint is the feature.
- **Don't strip the personal-taste content.** The OG-image style prompt, the
  NEXT Careers frameworks, the Pangram thresholds, boss-check's learned
  phrase patterns — all "context the model can't derive." That's exactly
  what skills are for.
- **Don't split small skills into references.** Progressive disclosure inside
  a skill matters at PostHog's scale (26 schema files). At 32–164 lines,
  single-file skills load fine; only `publish` clears the bar for a
  references split.
