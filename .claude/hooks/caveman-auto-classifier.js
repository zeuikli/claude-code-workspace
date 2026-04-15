#!/usr/bin/env node
// ============================================
// Claude Code Workspace — Caveman Auto Classifier
// UserPromptSubmit hook: 分析每個 prompt → 自動選擇壓縮等級
// 透過 additionalContext 動態注入，無需使用者手動切換
//
// 啟用方式：設定 CAVEMAN_AUTO_MODE=true 環境變數
// 或在 ~/.config/caveman/config.json 加入 "autoMode": true
//
// 等級選擇邏輯：
//   ultra — 短指令、簡單 Q&A、修錯、狀態查詢
//   lite  — 解釋型、教學型、架構討論、文件撰寫
//   full  — 其他（預設）
//
// 同時追蹤 /caveman 指令（手動覆寫優先）
// ============================================

const fs   = require('fs');
const path = require('path');
const os   = require('os');

let getDefaultMode, getConfigDir;
try {
  ({ getDefaultMode, getConfigDir } = require(path.join(__dirname, 'caveman-config')));
} catch (e) {
  getDefaultMode = () => (process.env.CAVEMAN_DEFAULT_MODE || 'full');
  getConfigDir   = () => path.join(os.homedir(), '.config', 'caveman');
}

const flagPath = path.join(os.homedir(), '.claude', '.caveman-active');

// ── Auto mode 啟用判斷 ────────────────────────────────────────────────────────

function isAutoModeEnabled() {
  // 1. 環境變數
  const env = (process.env.CAVEMAN_AUTO_MODE || '').toLowerCase();
  if (env === 'true' || env === '1') return true;
  if (env === 'false' || env === '0') return false;

  // 2. Config file
  try {
    const configPath = path.join(getConfigDir(), 'config.json');
    const config = JSON.parse(fs.readFileSync(configPath, 'utf8'));
    if (typeof config.autoMode === 'boolean') return config.autoMode;
  } catch (e) { /* no config */ }

  // 3. Flag file check: 若 flag 為 'auto'，啟用
  try {
    const flagContent = fs.readFileSync(flagPath, 'utf8').trim();
    if (flagContent === 'auto') return true;
  } catch (e) { /* no flag */ }

  return false;
}

// ── Prompt 分類器 ─────────────────────────────────────────────────────────────

/**
 * 分析 prompt，回傳建議的 caveman 壓縮等級
 * @param {string} prompt  原始 prompt 文字
 * @returns {'ultra'|'lite'|'full'|null}  null = 不覆寫（保持 session 預設）
 */
function classifyPrompt(prompt) {
  const raw = prompt.trim();
  const p   = raw.toLowerCase();
  const words = raw.split(/\s+/).filter(Boolean);
  const wc  = words.length;

  // ── 優先級 1：安全/破壞性操作 → 強制 lite（Auto-Clarity）──────────────────────
  const safetyPatterns = [
    /\b(delete|drop|truncate|rm -rf|destroy|wipe|purge|format|overwrite)\b.*\b(database|table|file|directory|branch|production|prod)\b/i,
    /\b(irreversible|cannot undo|permanent|forever)\b/i,
    /\b(security|vulnerability|exploit|injection|xss|csrf|credentials|password|secret|token leak)\b/i,
  ];
  if (safetyPatterns.some(r => r.test(raw))) return 'lite';

  // ── 優先級 1.5：修 bug 型 how-do → ultra（先於 lite 的 how-do 規則）──────────
  // "how do I fix X", "how can I debug Y" = 調試，非學習
  const fixHowPatterns = [
    /\bhow (do i|can i|should i) (fix|debug|troubleshoot|resolve|solve)\b/i,
  ];
  if (fixHowPatterns.some(r => r.test(raw))) return 'ultra';

  // ── 優先級 2：Lite 信號（先於 ultra short-prompt 規則，避免誤分類）────────────
  // 教學型、解釋型、架構型：即使 prompt 很短也應用 lite
  const litePatterns = [
    /\b(explain|explanation|understand|understanding|clarify)\b/i,
    /\b(why (does|is|do|are|would|should|did)|why (it|this|that))\b/i,
    /\b(how does|how do|how would|how should|how can)\b/i,
    /\b(teach|guide|tutorial|walkthrough|step.?by.?step|in detail|detailed|elaborate|thoroughly)\b/i,
    /\b(document|documentation|readme|write docs?|generate docs?)\b/i,
    /\b(architecture|design pattern|system design|high.?level|overview)\b/i,
    /\b(compare|comparison|difference between|vs\.?|versus|tradeoff|pros?.?cons?|advantages?|disadvantages?)\b/i,
    /\b(best practice|recommendation|should i use|which approach|when to use)\b/i,
    /\b(deep dive|comprehensive|thorough|complete guide)\b/i,
  ];
  if (litePatterns.some(r => r.test(raw))) return 'lite';

  // ── 優先級 2.5：實作/重構任務 → full（避免被短字數 ultra 規則誤判）──────────
  // e.g. "refactor this function", "implement error boundary"
  const implementationPatterns = [
    /^(implement|refactor|build|write|design|architect|structure)\b/i,
    /^(set up|setup|configure|integrate)\b.{8,}/i,
  ];
  if (implementationPatterns.some(r => r.test(raw))) return 'full';

  // ── 優先級 3：Ultra 信號：短指令、簡單任務、Q&A ──────────────────────────────
  const ultraStartPatterns = [
    /^(fix|check|show|list|run|add|remove|delete|update|get|find|print|log|install|uninstall|enable|disable|restart|start|stop)\b/i,
    /^(what is|what's|where is|where's|is it|does it|can i|should i|which|when|who)\b/i,
    /^(convert|rename|move|copy|parse|format|validate|test|lint|build|deploy)\b/i,
  ];
  const ultraBodyPatterns = [
    /\b(error|bug|fail|crash|broken|not working|doesn'?t work|throws?|exception|undefined|null pointer|404|500)\b/i,
    /\b(syntax error|type error|import error|module not found)\b/i,
  ];
  // 短 prompt + 指令式開頭 → ultra
  if (wc <= 20 && ultraStartPatterns.some(r => r.test(raw))) return 'ultra';
  // 極短 prompt（已排除 lite/implementation 信號）→ ultra
  if (wc < 6) return 'ultra';
  // 含錯誤/bug 關鍵詞且 prompt 不太長 → ultra
  if (wc <= 30 && ultraBodyPatterns.some(r => r.test(raw))) return 'ultra';

  // ── 優先級 4：Full（預設）────────────────────────────────────────────────────
  return 'full';
}

// ── 等級描述（注入給 Claude 的提示）────────────────────────────────────────────

const LEVEL_HINTS = {
  ultra:
    'CAVEMAN AUTO: level=ultra. Prompt classified as simple task/Q&A. ' +
    'Use ultra compression this response: abbreviate (DB/auth/config/req/res/fn/impl), ' +
    'arrows for causality (X→Y), one word when enough. Keep code unchanged.',
  lite:
    'CAVEMAN AUTO: level=lite. Prompt classified as explanatory/educational. ' +
    'Use lite compression this response: no filler/hedging, keep articles + full sentences, ' +
    'professional but tight. Full prose for complex explanations.',
  full:
    'CAVEMAN AUTO: level=full. Use standard caveman compression this response: ' +
    'drop articles/filler, fragments OK, short synonyms, technical terms exact.',
};

// ── 主流程 ────────────────────────────────────────────────────────────────────

let input = '';
process.stdin.on('data', chunk => { input += chunk; });
process.stdin.on('end', () => {
  try {
    const data   = JSON.parse(input);
    const prompt = (data.prompt || '').trim();
    const pLower = prompt.toLowerCase();

    // ── 1. 手動 /caveman 指令處理（優先於 auto）──────────────────────────────
    if (pLower.startsWith('/caveman')) {
      const parts = pLower.split(/\s+/);
      const cmd   = parts[0];
      const arg   = parts[1] || '';
      let mode = null;

      if (cmd === '/caveman-commit')   mode = 'commit';
      else if (cmd === '/caveman-review') mode = 'review';
      else if (cmd === '/caveman-compress' || cmd === '/caveman:caveman-compress') mode = 'compress';
      else if (cmd === '/caveman' || cmd === '/caveman:caveman') {
        if (arg === 'lite')         mode = 'lite';
        else if (arg === 'ultra')   mode = 'ultra';
        else if (arg === 'wenyan-lite')  mode = 'wenyan-lite';
        else if (arg === 'wenyan' || arg === 'wenyan-full') mode = 'wenyan';
        else if (arg === 'wenyan-ultra') mode = 'wenyan-ultra';
        else if (arg === 'auto')    mode = 'auto';
        else if (arg === 'off')     mode = 'off';
        else mode = getDefaultMode();
      }

      if (mode && mode !== 'off') {
        try {
          fs.mkdirSync(path.dirname(flagPath), { recursive: true });
          fs.writeFileSync(flagPath, mode);
        } catch (e) {}
      } else if (mode === 'off') {
        try { fs.unlinkSync(flagPath); } catch (e) {}
      }

      // Manual command — no additionalContext override needed, exit silently
      process.exit(0);
    }

    // 停用指令
    if (/\b(stop caveman|normal mode)\b/i.test(pLower)) {
      try { fs.unlinkSync(flagPath); } catch (e) {}
      process.exit(0);
    }

    // ── 2. Auto mode 處理 ────────────────────────────────────────────────────
    if (!isAutoModeEnabled()) {
      // Auto mode 未啟用，靜默退出
      process.exit(0);
    }

    const level = classifyPrompt(prompt);
    if (!level || level === 'full') {
      // full = session 預設，不需額外注入
      if (level === 'full') {
        // 更新 flag 供 statusline 顯示
        try {
          fs.mkdirSync(path.dirname(flagPath), { recursive: true });
          fs.writeFileSync(flagPath, 'auto:full');
        } catch (e) {}
      }
      process.exit(0);
    }

    // 更新 flag（包含 auto: 前綴，供 statusline 顯示 [CAVEMAN:AUTO:ULTRA] 等）
    try {
      fs.mkdirSync(path.dirname(flagPath), { recursive: true });
      fs.writeFileSync(flagPath, 'auto:' + level);
    } catch (e) {}

    // 發出 additionalContext → 注入給 Claude 這個 prompt 的壓縮指令
    const hint = LEVEL_HINTS[level] || LEVEL_HINTS.full;
    const output = JSON.stringify({
      hookSpecificOutput: {
        hookEventName:     'UserPromptSubmit',
        additionalContext: hint,
      },
    });
    process.stdout.write(output);

  } catch (e) {
    // Silent fail — 永不阻塞 prompt
  }
});
