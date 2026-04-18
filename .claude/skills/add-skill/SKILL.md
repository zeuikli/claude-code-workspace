---
name: add-skill
description: 建立符合官方規格的 Claude Code skill：蒐集需求、產出正確格式的 SKILL.md、驗證命名與描述規則、套用 Progressive Disclosure 結構。適合在新增 skill 或 slash command 時使用。
disable-model-invocation: true
context: fork
---

# Add Skill — 建立新 Skill

## 執行流程

### Step 1：取得最新官方規格

優先抓取官方文件，確保符合目前規格：

```
WebFetch: https://docs.anthropic.com/en/claude-code/skills
```

若失敗，用 WebSearch：`Claude Code skills SKILL.md format site:docs.anthropic.com`

### Step 2：確認基本資訊

從使用者取得（或直接從 prompt 解析）：

1. **範圍**：全域 skill 或 repo-local skill？
   - **全域** → `~/.claude/skills/{skill-name}/`（所有專案可用）
   - **Repo-local** → `.claude/skills/{skill-name}/`（僅此 repo，git 版控）
2. **名稱**：小寫、僅用連字號（優先動名詞形式：`processing-pdfs`、`testing-code`）
3. **用途**：做什麼？（1-2 句）
4. **觸發條件**：什麼時候用？（關鍵字、場景）
5. **複雜度**：純指令型，還是需要 scripts / references？
6. **自由度**：嚴格步驟型，還是原則指引型？

### Step 3：建立目錄結構

```
{base-path}/skills/{skill-name}/
├── SKILL.md           # 必要：主指令（<500 行）
├── scripts/           # 可選：可執行腳本
│   └── main.py
└── references/        # 可選：詳細文件（只能一層）
    └── examples.md
```

### Step 4：產出 SKILL.md

**必要 frontmatter**（與本 workspace 慣例一致）：

```yaml
---
name: {skill-name}
description: {第三人稱說明，包含「做什麼」和「何時用」}
disable-model-invocation: true
context: fork
---
```

**正文結構**：
```markdown
# {Skill 標題}

## 觸發條件
...

## 執行步驟
...

## 輸出格式
...

## Gotcha（注意事項）
...
```

### Step 5：檢查行數 + Progressive Disclosure

草稿完成後計算行數，若超過 **500 行**：

1. 通知使用者
2. 識別可拆分段落（詳細 reference、長範例、進階功能）
3. 移至 `references/{topic}.md`（只能一層，不能再嵌套）
4. 在 SKILL.md 用摘要 + 連結取代
5. 超過 100 行的 reference 文件加目錄

### Step 6：驗證（見檢查清單）

### Step 7：確認寫入

```bash
ls -la .claude/skills/{skill-name}/
```

---

## 命名規則

- **長度**：1-64 字元
- **格式**：只能用小寫英文、數字、連字號
- **優先動名詞**：`processing-pdfs`、`testing-code`
- **不允許**：以 `-` 開頭/結尾、連續 `--`、保留字（`anthropic`、`claude`）
- **避免**：模糊名稱（`helper`、`utils`、`tools`）
- **必須與資料夾名稱一致**

## 描述規則

- **上限**：1024 字元，不能包含 XML 標籤
- **第三人稱**：「處理 PDF 檔案」，不要「我可以幫你」
- **同時包含**：做什麼 + 何時用
- **具體**：Claude 從 100+ skills 中選擇時靠 description

**好的範例**：
```yaml
description: 從 PDF 提取文字和表格、填寫表單、合併文件。適合在處理 PDF 檔案或使用者提到 PDF、表單、文件提取時使用。
```

**差的範例**：「幫助處理文件」、「處理資料」

---

## 自由度選擇

| 自由度 | 適用時機 | 範例 |
|-------|---------|------|
| **高**（文字指引） | 多種有效做法都可接受 | Code review 指引 |
| **中**（虛擬碼/參數） | 有偏好模式但有彈性 | 報告產出模板 |
| **低**（精確腳本） | 操作脆弱、需一致性 | 資料庫遷移 |

---

## 反模式

- 解釋 Claude 本來就懂的事
- 提供太多工具/函式庫選項（給預設選項加逃生門即可）
- 時效性資訊（舊 API 等）— 用 `<details>` 折疊
- 超過一層的 reference 嵌套
- 假設套件已安裝但不給安裝指令

---

## 驗證清單

### 核心品質
- [ ] 名稱：小寫、只用數字和連字號、1-64 字元、無保留字
- [ ] 描述：第三人稱、具體、包含做什麼和何時用、不超過 1024 字元
- [ ] SKILL.md 本體不超過 500 行
- [ ] 細節放獨立 reference 文件（只能一層）
- [ ] 無時效性資訊
- [ ] 全文術語一致
- [ ] 有具體範例（非抽象說明）
- [ ] Frontmatter 含 `disable-model-invocation: true` 和 `context: fork`

### 腳本（若有）
- [ ] 明確處理錯誤，不把錯誤丟給 Claude
- [ ] 無魔術數字（所有數值都有說明）
- [ ] 列出依賴套件與安裝指令
- [ ] 路徑使用正斜線

### 測試
- [ ] 已在真實場景測試
- [ ] 不同複雜度的 prompt 都能正確觸發

---

## 參考資料

- **官方文件**：[docs.anthropic.com/en/claude-code/skills](https://docs.anthropic.com/en/claude-code/skills)
- **本 workspace 範例**：`.claude/skills/deep-review/SKILL.md`、`.claude/skills/research-best-practices/SKILL.md`
