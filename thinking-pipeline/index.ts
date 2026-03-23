// Thinking Pipeline — OpenClaw plugin entry point
// Registers /think:* slash commands that load corresponding SKILL.md files
import { promises as fs } from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const skills: Record<string, string> = {};

async function loadSkills() {
  const skillsDir = path.join(__dirname, "skills");
  try {
    const entries = await fs.readdir(skillsDir, { withFileTypes: true });
    for (const entry of entries) {
      if (!entry.isDirectory()) continue;
      const skillPath = path.join(skillsDir, entry.name, "SKILL.md");
      try {
        const content = await fs.readFile(skillPath, "utf8");
        // Strip frontmatter
        const body = content.replace(/^---[\s\S]*?---\n*/, "");
        skills[entry.name.replace(/^cmd-/, "")] = body.trim();
      } catch {
        // Skill file not found, skip
      }
    }
  } catch {
    // Skills directory not found
  }
}

export default async function register(api) {
  await loadSkills();

  api.registerCommand({
    name: "think:start",
    description:
      "Start a new thinking project — ask 5 high-leverage questions before producing anything",
    acceptsArgs: true,
    requireAuth: false,
    handler: (ctx) => ({
      text:
        skills["think:start"] ??
        "Command think:start not found. Check skills directory.",
    }),
  });

  api.registerCommand({
    name: "think:recall",
    description:
      "Prove you remember before revisiting a topic — recall thesis, evidence, and concerns from memory",
    acceptsArgs: true,
    requireAuth: false,
    handler: (ctx) => ({
      text:
        skills["think:recall"] ??
        "Command think:recall not found. Check skills directory.",
    }),
  });

  api.registerCommand({
    name: "think:architect",
    description:
      "Stress-test reasoning — analyze argument structure, find gaps, and suggest fixes",
    acceptsArgs: true,
    requireAuth: false,
    handler: (ctx) => ({
      text:
        skills["think:architect"] ??
        "Command think:architect not found. Check skills directory.",
    }),
  });

  api.registerCommand({
    name: "think:challenge",
    description:
      "Play devil's advocate — generate the strongest counterarguments to destroy the argument",
    acceptsArgs: true,
    requireAuth: false,
    handler: (ctx) => ({
      text:
        skills["think:challenge"] ??
        "Command think:challenge not found. Check skills directory.",
    }),
  });

  api.registerCommand({
    name: "think:review",
    description:
      "Editorial review — publish/revise/reject decision with concrete feedback",
    acceptsArgs: true,
    requireAuth: false,
    handler: (ctx) => ({
      text:
        skills["think:review"] ??
        "Command think:review not found. Check skills directory.",
    }),
  });

  api.registerCommand({
    name: "think:pipeline",
    description:
      "Run the full thinking gauntlet: recall → architect → devil's advocate → editorial review",
    acceptsArgs: true,
    requireAuth: false,
    handler: (ctx) => ({
      text:
        skills["think:pipeline"] ??
        "Command think:pipeline not found. Check skills directory.",
    }),
  });

  api.registerCommand({
    name: "think:feynman",
    description:
      "Test real understanding — explain the concept in your own words",
    acceptsArgs: true,
    requireAuth: false,
    handler: (ctx) => ({
      text:
        skills["think:feynman"] ??
        "Command think:feynman not found. Check skills directory.",
    }),
  });

  api.registerCommand({
    name: "think:receipt",
    description:
      "Reduce an article or source to a compact inline citation receipt",
    acceptsArgs: true,
    requireAuth: false,
    handler: (ctx) => ({
      text:
        skills["think:receipt"] ??
        "Command think:receipt not found. Check skills directory.",
    }),
  });

  api.registerCommand({
    name: "think:phv",
    description:
      "Map content against Personal House Views — confirm, challenge, or update positions",
    acceptsArgs: true,
    requireAuth: false,
    handler: (ctx) => ({
      text:
        skills["think:phv"] ??
        "Command think:phv not found. Check skills directory.",
    }),
  });

  api.registerCommand({
    name: "think:outreach",
    description:
      "Draft a cold outreach email using the NEXT Careers networking framework",
    acceptsArgs: true,
    requireAuth: false,
    handler: (ctx) => ({
      text:
        skills["think:outreach"] ??
        "Command think:outreach not found. Check skills directory.",
    }),
  });
}
