#!/usr/bin/env node
// ============================================
// Claude Code Workspace — Caveman-style SessionStart Hook
// 基於 JuliusBrussee/caveman 的 standalone hooks 設計移植
//
// 功能：
//   1. 讀取 workspace SKILL.md（單一真實來源）
//   2. 過濾至指定注入模式（full / selective / off）
//   3. 以隱藏系統 context 輸出 → Claude 看見，使用者看不見
//   4. Silent fail — 永不阻塞 session 啟動
//
// 注入模式（CAVEMAN_INJECT_MODE 環境變數）：
//   full      → 完整 SKILL.md（預設，取代全部 CLAUDE.md+rules）
//   selective → 僅注入最小核心規則（SKILL-rules-only.md）
//   off       → 不注入（純用 CLAUDE.md 載入模式）
//
// Ref: https://github.com/JuliusBrussee/caveman
// ============================================

const fs = require('fs');
const path = require('path');
const os = require('os');

// 解析 workspace 目錄
// 優先順序：CLAUDE_PROJECT_DIR env → __dirname 往上兩層 → 環境偵測
function resolveWorkspaceDir() {
  // 1. CLAUDE_PROJECT_DIR（Claude Code 在 hook 執行時會注入此變數）
  if (process.env.CLAUDE_PROJECT_DIR) {
    return process.env.CLAUDE_PROJECT_DIR;
  }
  // 2. 從 hook 檔案位置往上推兩層（hooks/ → .claude/ → workspace root）
  const candidate = path.resolve(__dirname, '..', '..');
  if (fs.existsSync(path.join(candidate, 'CLAUDE.md'))) {
    return candidate;
  }
  // 3. Fallback：雲端 / 本機
  return process.env.CLAUDE_CODE_REMOTE === 'true'
    ? '/tmp/claude-code-workspace'
    : path.join(os.homedir(), 'claude-code-workspace');
}

const WORKSPACE_DIR = resolveWorkspaceDir();

const SKILLS_DIR = path.join(WORKSPACE_DIR, '.claude', 'skills', 'workspace-rules');
const FLAG_PATH  = path.join(os.homedir(), '.claude', '.ws-inject-mode');

// 注入模式解析
const VALID_MODES = ['full', 'selective', 'off'];
const rawMode = (process.env.CAVEMAN_INJECT_MODE || '').toLowerCase().trim();
const mode = VALID_MODES.includes(rawMode) ? rawMode : 'full';

// off 模式 — 不注入，讓 CLAUDE.md 自行載入
if (mode === 'off') {
  try { fs.unlinkSync(FLAG_PATH); } catch (_) {}
  process.stdout.write('[workspace-inject] mode=off — using CLAUDE.md only\n');
  process.exit(0);
}

// 寫入旗標（供 statusline 或其他 hooks 讀取）
try {
  fs.mkdirSync(path.dirname(FLAG_PATH), { recursive: true });
  fs.writeFileSync(FLAG_PATH, mode);
} catch (_) { /* silent fail */ }

// 選擇 SKILL.md 檔案
const skillFile = mode === 'selective'
  ? path.join(SKILLS_DIR, 'SKILL-rules-only.md')
  : path.join(SKILLS_DIR, 'SKILL.md');

let output = '';

try {
  const raw = fs.readFileSync(skillFile, 'utf8');
  // 去除 YAML frontmatter
  const body = raw.replace(/^---[\s\S]*?---\s*/, '');
  output = `[workspace-inject] mode=${mode}\n\n${body.trim()}`;
} catch (_) {
  // Fallback：SKILL.md 找不到時使用硬編碼最小規則集
  output =
    `[workspace-inject] mode=${mode} (fallback)\n\n` +
    `Lang: 中文→繁體中文 | English→English\n` +
    `Agents: delegate to sub agents first (researcher/implementer/test-writer/reviewer)\n` +
    `Git: add→commit→push -u origin after every change; retry 4x on fail\n` +
    `Context: warn at 70%; /deep-review before commit\n`;
}

process.stdout.write(output);
