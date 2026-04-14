# 官方文件對照表（References）

> 本 workspace 所有設計決策的官方來源。每個 hook / agent / skill / config 的註解都會指向這裡。
> 最後更新：2026-04-14 Session 7

---

## Claude Code 核心文件

| 主題 | 官方 URL | 本 workspace 對應 |
|---|---|---|
| **Hooks 完整事件清單（25+）** | https://code.claude.com/docs/en/hooks | `.claude/hooks/*.sh`、`.claude/settings.json` |
| **Hooks 使用指南** | https://code.claude.com/docs/en/hooks-guide | 同上 |
| **Memory 機制（200 行/25KB 上限）** | https://code.claude.com/docs/en/memory | `memory-archive.sh`、`memory-pull.sh`、`memory-sync.sh`、`Memory.md` |
| **Sub-agents 定義** | https://code.claude.com/docs/en/sub-agents | `.claude/agents/*.md` |
| **Skills 完整 frontmatter** | https://code.claude.com/docs/en/skills | `.claude/skills/*/SKILL.md` |
| **Permissions（permissionMode）** | https://code.claude.com/docs/en/permissions | `implementer.md`、`test-writer.md`、`doc-writer.md` |
| **Settings 設定層級** | https://code.claude.com/docs/en/settings | `.claude/settings.json` |
| **Agent SDK 概覽** | https://code.claude.com/docs/en/agent-sdk/overview | `cost-tracker` Skill、`reviewer.md` |
| **Output Styles** | https://code.claude.com/docs/en/output-styles | — |

## Anthropic API / Claude 平台

| 主題 | 官方 URL | 本 workspace 對應 |
|---|---|---|
| **Context Editing API** | https://platform.claude.com/docs/en/build-with-claude/context-editing | `docs/auto-memory-hybrid.md` |
| **Memory Tool** | https://platform.claude.com/docs/en/agents-and-tools/tool-use/memory-tool | 同上 |
| **Structured Outputs** | https://platform.claude.com/docs/en/build-with-claude/structured-outputs | Hook JSON `additionalContext` 格式 |
| **Prompt Caching** | https://platform.claude.com/docs/en/build-with-claude/prompt-caching | `cost-tracker` 定價表 |
| **Prompting Best Practice（XML tags）** | https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/use-xml-tags | 各 Skill frontmatter 結構 |
| **選擇模型（Haiku/Sonnet/Opus）** | https://claude.com/resources/tutorials/choosing-the-right-claude-model | Advisor Strategy 三層設計 |

## 設計策略來源

| 主題 | 官方 URL | 對應檔案 |
|---|---|---|
| **Advisor Strategy** | https://claude.com/blog/the-advisor-strategy | `docs/advisor-strategy.md`、`.claude/rules/subagent-strategy.md` |
| **Multi-Agent Coordination** | https://claude.com/blog/multi-agent-coordination-patterns | `agent-team` Skill |
| **Improving Frontend Design** | https://claude.com/blog/improving-frontend-design-through-skills | `frontend-design` Skill |
| **Harnessing Claude's Intelligence** | https://claude.com/blog/harnessing-claudes-intelligence | 三層 Agent 分工 |
| **AgentOpt 論文** | https://arxiv.org/html/2604.06296v1 | Advisor Strategy 學理依據 |

## 工具與 Lint

| 工具 | 官方 URL | 對應檔案 |
|---|---|---|
| **ShellCheck wiki（SC 編號）** | https://www.shellcheck.net/wiki/ | CI shellcheck job |
| **ShellCheck SC2086** | https://www.shellcheck.net/wiki/SC2086 | `.claude/hooks/*.sh` |
| **ShellCheck SC2164** | https://www.shellcheck.net/wiki/SC2164 | `memory-pull.sh` |
| **ShellCheck SC2034** | https://www.shellcheck.net/wiki/SC2034 | `memory-sync.sh` |
| **markdownlint 規則** | https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md | `.markdownlint.json` |
| **Mermaid sequenceDiagram** | https://mermaid.ai/open-source/syntax/sequenceDiagram.html | `docs/hook-lifecycle.md` |

## Git 效能參考

| 主題 | 官方 URL | 對應檔案 |
|---|---|---|
| **Git Partial Clone（5MB threshold）** | https://github.blog/open-source/git/get-up-to-speed-with-partial-clone-and-shallow-clone/ | `session-init.sh` |
| **Git Shallow Clone（`--depth 1`）** | https://git-scm.com/docs/git-clone#Documentation/git-clone.txt---depthltdepthgt | 同上 |
| **Git Filter `blob:none`** | https://git-scm.com/docs/partial-clone | 同上 |

## 已知官方 BUG 追蹤

| Issue | 主題 | 影響本 workspace |
|---|---|---|
| [#23478](https://github.com/anthropics/claude-code/issues/23478) | Path-scoped rules `paths:` 只在 Read 觸發 | 暫緩實作 `.claude/rules/*.md` 的 `paths:` frontmatter |
| [#21858](https://github.com/anthropics/claude-code/issues/21858) | User-level `~/.claude/rules/` `paths:` 失效 | 同上 |
| [#17204](https://github.com/anthropics/claude-code/issues/17204) | 部分 YAML 格式解析錯誤 | 同上 |
| [#45224](https://github.com/anthropics/claude-code/issues/45224) | SSE keep-alive heartbeat | 影響 stream timeout，見 `docs/timeout-guide.md` |
| [#46987](https://github.com/anthropics/claude-code/issues/46987) | Stream idle timeout 回歸（v2.1.92）| 同上 |
| [#47252](https://github.com/anthropics/claude-code/issues/47252) | Ultraplan 重複 timeout | 同上 |
| [#47555](https://github.com/anthropics/claude-code/issues/47555) | 大檔案寫入時 timeout | 同上 |

## POSIX / 系統工具

| 主題 | 參考 URL | 對應檔案 |
|---|---|---|
| **flock(2)** | https://man7.org/linux/man-pages/man2/flock.2.html | `memory-sync.sh`（序列化 git push）|
| **flock(1) 命令** | https://man7.org/linux/man-pages/man1/flock.1.html | 同上 |

## 競品借鏡

| 主題 | 官方 URL | 啟發的設計 |
|---|---|---|
| **Cursor Rules (`.mdc`)** | https://cursor.com/docs/rules | `.claude/rules/*.md` 模組化拆分 |
| **Aider Conventions** | https://aider.chat/docs/usage/conventions.html | CONVENTIONS.md 只放 non-obvious 規則 |
| **AGENTS.md 標準** | https://agents.md/ | 跨工具通用的 agent 定義 |
| **awesome-claude-code** | https://github.com/hesreallyhim/awesome-claude-code | 檔案結構範本 |

---

## 維護原則

1. 每次新增 hook / agent / skill / config 時，**優先在此檔加入對應 URL**
2. 檔案內註解只寫「Ref: See .claude/REFERENCES.md 『主題名』」，避免 URL 分散
3. Anthropic 官方 URL 變動時，**只需改這一處**
4. Session 結束時審計此檔是否有過期連結（用 CI job 檢查）
