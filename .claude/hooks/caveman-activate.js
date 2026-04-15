#!/usr/bin/env node
// ============================================
// Claude Code Workspace — Caveman Activation Hook (SessionStart)
// Adapted from: https://github.com/JuliusBrussee/caveman (standalone hooks)
//
// 功能：
//   1. 讀取 workspace skills/caveman/SKILL.md（單一真實來源）
//   2. 過濾至當前 intensity level（lite/full/ultra/wenyan-*）
//   3. 以隱藏 SessionStart context 輸出 → Claude 看見，使用者看不見
//   4. 寫入旗標 ~/.claude/.caveman-active（供 statusline + mode-tracker 讀取）
//   5. Silent fail — 永不阻塞 session 啟動
//
// 設定：CAVEMAN_DEFAULT_MODE env var（預設 full）
// ============================================

const fs = require('fs');
const path = require('path');
const os = require('os');

// Try to load config from same hooks dir
let getDefaultMode;
try {
  ({ getDefaultMode } = require(path.join(__dirname, 'caveman-config')));
} catch (e) {
  getDefaultMode = () => (process.env.CAVEMAN_DEFAULT_MODE || 'full');
}

const claudeDir = path.join(os.homedir(), '.claude');
const flagPath  = path.join(claudeDir, '.caveman-active');

// Resolve workspace root
function resolveWorkspaceDir() {
  if (process.env.CLAUDE_PROJECT_DIR) return process.env.CLAUDE_PROJECT_DIR;
  const candidate = path.resolve(__dirname, '..', '..');
  if (fs.existsSync(path.join(candidate, 'CLAUDE.md'))) return candidate;
  return process.env.CLAUDE_CODE_REMOTE === 'true'
    ? '/tmp/claude-code-workspace'
    : path.join(os.homedir(), 'claude-code-workspace');
}

const WORKSPACE_DIR = resolveWorkspaceDir();
const SKILL_PATH = path.join(WORKSPACE_DIR, '.claude', 'skills', 'caveman', 'SKILL.md');

const mode = getDefaultMode();

// "off" mode — skip activation
if (mode === 'off') {
  try { fs.unlinkSync(flagPath); } catch (e) {}
  process.stdout.write('[caveman] mode=off');
  process.exit(0);
}

// Write flag file
try {
  fs.mkdirSync(path.dirname(flagPath), { recursive: true });
  fs.writeFileSync(flagPath, mode);
} catch (e) { /* silent fail */ }

// Independent modes (commit/review/compress) use their own skill files
const INDEPENDENT_MODES = new Set(['commit', 'review', 'compress']);
if (INDEPENDENT_MODES.has(mode)) {
  process.stdout.write('CAVEMAN MODE ACTIVE — level: ' + mode + '. Behavior defined by /caveman-' + mode + ' skill.');
  process.exit(0);
}

const modeLabel = mode === 'wenyan' ? 'wenyan-full' : mode;

// Read SKILL.md
let skillContent = '';
try {
  skillContent = fs.readFileSync(SKILL_PATH, 'utf8');
} catch (e) { /* fallback below */ }

let output;

if (skillContent) {
  // Strip YAML frontmatter
  const body = skillContent.replace(/^---[\s\S]*?---\s*/, '');

  // Filter intensity table: keep only active level row
  const filtered = body.split('\n').reduce((acc, line) => {
    const tableRowMatch = line.match(/^\|\s*\*\*(\S+?)\*\*\s*\|/);
    if (tableRowMatch) {
      if (tableRowMatch[1] === modeLabel) acc.push(line);
      return acc;
    }
    const exampleMatch = line.match(/^- (\S+?):\s/);
    if (exampleMatch) {
      if (exampleMatch[1] === modeLabel) acc.push(line);
      return acc;
    }
    acc.push(line);
    return acc;
  }, []);

  output = 'CAVEMAN MODE ACTIVE — level: ' + modeLabel + '\n\n' + filtered.join('\n');
} else {
  // Minimal fallback ruleset
  output =
    'CAVEMAN MODE ACTIVE — level: ' + modeLabel + '\n\n' +
    'Respond terse like smart caveman. All technical substance stay. Only fluff die.\n\n' +
    'ACTIVE EVERY RESPONSE. Off only: "stop caveman" / "normal mode".\n\n' +
    'Drop: articles, filler, pleasantries, hedging. Fragments OK. Technical terms exact.\n' +
    'Pattern: `[thing] [action] [reason]. [next step].`';
}

process.stdout.write(output);
