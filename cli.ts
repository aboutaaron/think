#!/usr/bin/env npx tsx
import meow from "meow";
import {
  installClaudeCode,
  installCodex,
  installCursor,
  installOpenClaw,
  type Platform,
} from "./scripts/install.js";

const cli = meow(
  `
  Usage
    $ think install <platform> [--dir <path>]

  Platforms
    claude-code    Slash commands in .claude/commands/
    codex          Agent skills in .agents/skills/
    cursor         Rules in .cursor/rules/
    openclaw       Skills in ~/.openclaw/workspace/skills/think/
    all            All platforms at once

  Options
    --dir, -d      Override the default install directory
    --dry-run      Show what would be installed without writing files

  Examples
    $ think install claude-code
    $ think install codex --dir ./my-project/.agents/skills
    $ think install all
`,
  {
    importMeta: import.meta,
    flags: {
      dir: {
        type: "string",
        shortFlag: "d",
      },
      dryRun: {
        type: "boolean",
        default: false,
      },
    },
  }
);

const PLATFORMS = ["claude-code", "codex", "cursor", "openclaw", "all"] as const;

const installers: Record<Platform, (dir?: string, dryRun?: boolean) => void> = {
  "claude-code": installClaudeCode,
  codex: installCodex,
  cursor: installCursor,
  openclaw: installOpenClaw,
};

function run(): void {
  const [command, platform] = cli.input;

  if (command !== "install") {
    cli.showHelp(0);
    return;
  }

  if (!platform || !PLATFORMS.includes(platform as (typeof PLATFORMS)[number])) {
    console.error(
      `Error: Unknown platform "${platform}". Choose from: ${PLATFORMS.join(", ")}`
    );
    process.exit(1);
  }

  const dir = cli.flags.dir || undefined;
  const dryRun = cli.flags.dryRun;

  if (platform === "all") {
    for (const p of Object.keys(installers) as Platform[]) {
      installers[p](dir, dryRun);
    }
  } else {
    installers[platform as Platform](dir, dryRun);
  }
}

run();
