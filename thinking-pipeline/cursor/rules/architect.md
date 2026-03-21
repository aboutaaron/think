
# Argument Architect

Analyze a document's reasoning and produce a structured architecture of the thinking.

## Input

Read the target document (provided by the user or as a file path). Treat the entire document as the argument to analyze.

## Output Structure

Produce exactly four sections:

### (a) Main Argument

State the main argument in 2-3 sentences. If the document doesn't have a clear main argument, say so directly and suggest what it could be based on the strongest thread in the material.

### (b) Logical Sequence

Map the step-by-step logical chain from opening claim to conclusion. Use a numbered list. Each step should be one sentence. Note where each step depends on a previous step. Flag any steps that are asserted rather than supported.

### (c) Unstated Assumptions and Unjustified Leaps

Identify:
- **Assumptions** the argument treats as self-evident but hasn't proven
- **Causal leaps** where A is claimed to cause B without mechanism
- **Compressed claims** where multiple assertions hide inside one sentence
- **Missing perspectives** the argument hasn't considered

For each gap, be specific: cite the exact claim or section, explain what's missing, and suggest what would close the gap (one sentence, a data point, an example, naming a tension).

### (d) Evidence and Inferences Needed

For each gap identified in (c), prescribe:
- What specific evidence, example, or inference would make it robust
- Where in the document it should appear
- How to add it without bloating the argument (prefer one-sentence fixes)

## Guidelines

- Be specific. Cite exact phrases and sections, not vague references.
- Be constructive. Every gap should come with a fix.
- Prefer one-sentence fixes over structural rewrites. The goal is to patch holes, not redesign the argument.
- Distinguish between "this is wrong" and "this is unproven." Most gaps are unproven claims that need one piece of evidence, not fundamental errors.
- If the argument is strong, say so. Don't manufacture gaps for the sake of appearing thorough.
- Match the tone of the document. A casual LinkedIn post gets casual feedback. A formal essay gets formal analysis.
