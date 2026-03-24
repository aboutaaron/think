import { readFileSync, writeFileSync, mkdirSync, readdirSync, existsSync, copyFileSync, statSync } from "node:fs";
import { join, basename, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { homedir } from "node:os";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const REPO_ROOT = dirname(__dirname);
const SKILLS_DIR = join(REPO_ROOT, "skills");

export type Platform = "claude-code" | "codex" | "cursor" | "openclaw";

// ── Helpers ──────────────────────────────────────────────────────────

function stripFrontmatter(content: string): string {
  const lines = content.split("\n");
  if (lines[0]?.trim() !== "---") return content;

  let endIndex = -1;
  for (let i = 1; i < lines.length; i++) {
    if (lines[i]?.trim() === "---") {
      endIndex = i;
      break;
    }
  }

  if (endIndex === -1) return content;
  return lines.slice(endIndex + 1).join("\n").trimStart();
}

function getSkillName(content: string): string | null {
  const match = content.match(/^name:\s*["']?(.+?)["']?\s*$/m);
  return match?.[1] ?? null;
}

export interface SkillEntry {
  name: string;
  dir: string;
  skillFile: string;
  content: string;
  extras: string[]; // reference dirs, scripts, etc.
}

export function discoverSkills(): SkillEntry[] {
  const skills: SkillEntry[] = [];

  for (const entry of readdirSync(SKILLS_DIR)) {
    const dir = join(SKILLS_DIR, entry);
    const skillFile = join(dir, "SKILL.md");

    if (!existsSync(skillFile)) continue;

    const content = readFileSync(skillFile, "utf-8");
    const name = getSkillName(content) ?? entry;

    // Find extra files (references/, scripts/, *.sh)
    const extras: string[] = [];
    for (const item of readdirSync(dir)) {
      if (item === "SKILL.md") continue;
      extras.push(join(dir, item));
    }

    skills.push({ name, dir, skillFile, content, extras });
  }

  return skills.sort((a, b) => a.name.localeCompare(b.name));
}

function copyRecursive(src: string, dest: string): void {
  const stat = statSync(src);
  if (stat.isDirectory()) {
    mkdirSync(dest, { recursive: true });
    for (const item of readdirSync(src)) {
      copyRecursive(join(src, item), join(dest, item));
    }
  } else {
    mkdirSync(dirname(dest), { recursive: true });
    copyFileSync(src, dest);
  }
}

function green(text: string): string {
  return `\x1b[32m${text}\x1b[0m`;
}

// ── Platform Installers ──────────────────────────────────────────────

export function installClaudeCode(skills: SkillEntry[], dir?: string, dryRun = false): void {
  const target = dir || ".claude/commands";

  if (!dryRun) mkdirSync(target, { recursive: true });

  for (const skill of skills) {
    const filename = `think:${skill.name}.md`;
    const stripped = stripFrontmatter(skill.content);

    if (dryRun) {
      console.log(`  would write ${join(target, filename)}`);
    } else {
      writeFileSync(join(target, filename), stripped);
    }
  }

  console.log(
    `${green("✓")} ${dryRun ? "[dry-run] " : ""}Installed ${skills.length} Claude Code commands in ${target}/`
  );
  console.log("  Usage: /think:five-questions, /think:argument-architect, etc.");
}

export function installCodex(skills: SkillEntry[], dir?: string, dryRun = false): void {
  const target = dir || ".agents/skills";

  if (!dryRun) mkdirSync(target, { recursive: true });

  for (const skill of skills) {
    const dest = join(target, basename(skill.dir));

    if (dryRun) {
      console.log(`  would copy ${basename(skill.dir)}/ → ${dest}/`);
    } else {
      mkdirSync(dest, { recursive: true });
      copyFileSync(skill.skillFile, join(dest, "SKILL.md"));

      for (const extra of skill.extras) {
        const extraDest = join(dest, basename(extra));
        copyRecursive(extra, extraDest);
      }
    }
  }

  console.log(
    `${green("✓")} ${dryRun ? "[dry-run] " : ""}Installed ${skills.length} Codex skills in ${target}/`
  );
  console.log("  Usage: Reference skill names in your prompts or AGENTS.md");
}

export function installCursor(skills: SkillEntry[], dir?: string, dryRun = false): void {
  const target = dir || ".cursor/rules";

  if (!dryRun) mkdirSync(target, { recursive: true });

  for (const skill of skills) {
    const filename = `${basename(skill.dir)}.md`;
    const stripped = stripFrontmatter(skill.content);

    if (dryRun) {
      console.log(`  would write ${join(target, filename)}`);
    } else {
      writeFileSync(join(target, filename), stripped);
    }
  }

  console.log(
    `${green("✓")} ${dryRun ? "[dry-run] " : ""}Installed ${skills.length} Cursor rules in ${target}/`
  );
  console.log('  Usage: Reference by name in chat — "Use the argument-architect skill"');
}

export function installOpenClaw(skills: SkillEntry[], dir?: string, dryRun = false): void {
  const target = dir || join(homedir(), ".openclaw/workspace/skills/think");
  const skillsTarget = join(target, "skills");

  if (!dryRun) mkdirSync(skillsTarget, { recursive: true });

  for (const skill of skills) {
    const dest = join(skillsTarget, basename(skill.dir));

    if (dryRun) {
      console.log(`  would copy ${basename(skill.dir)}/ → ${dest}/`);
    } else {
      mkdirSync(dest, { recursive: true });
      copyFileSync(skill.skillFile, join(dest, "SKILL.md"));

      for (const extra of skill.extras) {
        const extraDest = join(dest, basename(extra));
        copyRecursive(extra, extraDest);
      }
    }
  }

  console.log(
    `${green("✓")} ${dryRun ? "[dry-run] " : ""}Installed ${skills.length} OpenClaw skills in ${skillsTarget}/`
  );
  console.log("  Skills are auto-loaded by OpenClaw on next session.");
}
