---
name: frontend-design
description: 引導 Claude 產出高品質的前端設計，避免 AI 生成的通用風格（AI slop）。包含字型、色彩、動態、背景的設計指引。
when_to_use: 使用者請求 UI/網頁/landing page/component 設計時自動觸發；建立 .tsx/.vue/.svelte 元件、寫 CSS/Tailwind 時也觸發。
allowed-tools: Read, Edit, Write, Bash(npm:*), Bash(pnpm:*), WebFetch
model: sonnet
effort: medium
---

# Frontend Design — 避免 AI Slop 的設計指引

> **Ref**:
> - 來源：https://claude.com/blog/improving-frontend-design-through-skills
> - Skills frontmatter: https://code.claude.com/docs/en/skills
> - 完整對照: `.claude/REFERENCES.md`

## 何時觸發

- 建立新 React / Vue / Svelte 元件
- 寫 landing page / marketing page
- 設計系統建立（design tokens / theme）
- 使用者說「UI」「畫面」「設計」「樣式」「視覺」

## 預期輸出

具備以下特徵的程式碼：
- 字型避開 Inter/Roboto 預設組合
- 色彩用 oklch() 而非 hex/rgb
- 動畫優先 CSS transition 而非 JS
- 加入細微噪點 / 幾何紋理
- 不出現「AI slop」典型 pattern（漸層藍紫、彈跳動畫、純白背景）

## 使用範例

```
使用者：幫我做一個 SaaS 訂閱頁
→ Skill 觸發
→ 字型推薦 DM Serif Display + DM Sans
→ 色彩用 oklch(0.7 0.15 250) 系列
→ 加 backdrop-filter 玻璃卡片
→ 微妙噪點背景
→ 產出符合 2026 設計風格的程式碼
```

> 來源：[Improving Frontend Design Through Skills](https://claude.com/blog/improving-frontend-design-through-skills)
> 📦 離線歸檔：[`archive/articles/improving-frontend-design-through-skills.md`](https://github.com/zeuikli/claude-code-workspace/blob/blog-archive/archive/articles/improving-frontend-design-through-skills.md)

## 字型選擇

避免：Inter、Roboto、system-ui 等過度使用的預設字體
推薦搭配：
- 標題：Playfair Display、DM Serif Display、Space Grotesk
- 內文：DM Sans、Source Serif 4、JetBrains Mono（程式碼）
- 使用 Google Fonts 或 Bunny Fonts CDN

## 色彩系統

避免：漸層按鈕、藍紫配色、過度飽和
推薦：
- 選擇一個主色調，搭配中性色與一個強調色
- 使用 oklch() 色彩空間產生和諧的調色盤
- 暗色模式：降低飽和度而非反轉顏色

## 動態效果

避免：彈跳動畫、過度的 hover 效果
推薦：
- 微妙的淡入（opacity 0→1, 200-300ms）
- 使用 CSS `transition` 而非 JS 動畫
- 滾動觸發的漸進顯示（Intersection Observer）

## 背景與紋理

避免：純白背景、stock photo 背景
推薦：
- 極淡的噪點紋理（CSS noise pattern）
- 幾何網格或點陣圖案
- 玻璃擬態（backdrop-filter: blur）搭配半透明卡片

## 版面配置

- 限制最大寬度（max-width: 1200px）
- 使用 CSS Grid 搭配不等欄寬
- 留白是設計工具，不是浪費空間

## Gotcha

- **不要覆蓋已建立的設計系統**：若專案使用 Tailwind / shadcn / MUI，先遵循其約定，不要用本 skill 的偏好蓋掉。
- **品牌字型優先**：若專案有 brand identity（logo 字型、既有色盤），本 skill 的字型建議僅供參考，不要強行替換。
- **深色背景需確認可及性**：深色配淺字 contrast ratio 需 ≥ 4.5:1（WCAG AA），不要只顧美觀。
- **動態效果不是必須**：若使用者未要求動畫，不要主動加入 transition / animation，避免拖慢渲染。
