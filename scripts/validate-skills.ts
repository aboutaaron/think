// CI validation for skills/ — enforces the contract in AGENTS.md:
//   - every skills/<dir>/SKILL.md has YAML frontmatter with name + description
//   - frontmatter name matches the directory name (the installer keys off both)
//   - description stays inside the word budget (warn > 50, fail > 80)
//   - README.md and skills/ stay in sync, both directions
// Run: npx tsx scripts/validate-skills.ts

import { readFileSync, readdirSync, existsSync } from "node:fs";
import { join, dirname, relative } from "node:path";
import { fileURLToPath } from "node:url";

const REPO_ROOT = dirname(dirname(fileURLToPath(import.meta.url)));
const SKILLS_DIR = join(REPO_ROOT, "skills");
const README = join(REPO_ROOT, "README.md");

const WARN_WORDS = 50;
const FAIL_WORDS = 80;

let errors = 0;
let warnings = 0;

function error(file: string, msg: string): void {
  errors++;
  console.log(`::error file=${relative(REPO_ROOT, file)}::${msg}`);
  console.log(`  ERROR ${relative(REPO_ROOT, file)}: ${msg}`);
}

function warn(file: string, msg: string): void {
  warnings++;
  console.log(`::warning file=${relative(REPO_ROOT, file)}::${msg}`);
  console.log(`  WARN  ${relative(REPO_ROOT, file)}: ${msg}`);
}

function parseFrontmatter(content: string): Record<string, string> | null {
  const lines = content.split("\n");
  if (lines[0]?.trim() !== "---") return null;
  const end = lines.findIndex((line, i) => i > 0 && line.trim() === "---");
  if (end === -1) return null;

  const fields: Record<string, string> = {};
  for (const line of lines.slice(1, end)) {
    const match = line.match(/^([A-Za-z_-]+):\s*(.*)$/);
    if (match) fields[match[1]] = match[2].replace(/^["']|["']$/g, "").trim();
  }
  return fields;
}

const readme = readFileSync(README, "utf-8");
const dirs = readdirSync(SKILLS_DIR, { withFileTypes: true })
  .filter((entry) => entry.isDirectory())
  .map((entry) => entry.name)
  .sort();

for (const dir of dirs) {
  const skillFile = join(SKILLS_DIR, dir, "SKILL.md");
  if (!existsSync(skillFile)) {
    error(join(SKILLS_DIR, dir), `skills/${dir}/ has no SKILL.md`);
    continue;
  }

  const content = readFileSync(skillFile, "utf-8");
  const fm = parseFrontmatter(content);
  if (!fm) {
    error(skillFile, "missing or unclosed YAML frontmatter");
    continue;
  }

  if (!fm.name) {
    error(skillFile, "frontmatter has no `name`");
  } else if (fm.name !== dir) {
    error(skillFile, `frontmatter name "${fm.name}" does not match directory "${dir}"`);
  }

  if (!fm.description) {
    error(skillFile, "frontmatter has no `description`");
  } else {
    const words = fm.description.split(/\s+/).filter(Boolean).length;
    if (words > FAIL_WORDS) {
      error(skillFile, `description is ${words} words (max ${FAIL_WORDS}; target under ${WARN_WORDS})`);
    } else if (words > WARN_WORDS) {
      warn(skillFile, `description is ${words} words (target under ${WARN_WORDS})`);
    }
  }

  // README must match reality: every skill appears in the README.
  if (!readme.includes(`\`${dir}\``)) {
    error(README, `skill \`${dir}\` is not mentioned in README.md`);
  }
}

// Reverse direction: every skill named in a README table row must exist.
for (const match of readme.matchAll(/^\|\s*`([a-z0-9-]+)`\s*\|/gm)) {
  const name = match[1];
  if (!dirs.includes(name)) {
    error(README, `README table lists \`${name}\` but skills/${name}/ does not exist`);
  }
}

console.log(
  `\nChecked ${dirs.length} skills: ${errors} error(s), ${warnings} warning(s)`
);
process.exit(errors > 0 ? 1 : 0);
