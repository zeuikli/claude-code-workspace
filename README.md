# Claude Blog Archive

此分支獨立於 `main`，專門用於自動歸檔 [claude.com/blog](https://claude.com/blog) 的文章。

## 運作方式

- **排程**：每天早上 9:00（UTC+8）由 GitHub Action 自動執行
- **手動觸發**：至 Actions 頁面點擊 "Run workflow"
- **歸檔格式**：每篇文章存為獨立 Markdown 檔案
- **索引**：`archive/index.md` 列出所有已歸檔的文章

## 目錄結構

```
blog-archive/
├── .github/workflows/
│   └── fetch-blog.yml      # GitHub Action 排程
├── scripts/
│   └── fetch-blog.sh       # 抓取腳本
├── archive/
│   ├── index.md             # 文章索引
│   └── articles/            # 各篇文章 Markdown
│       ├── article-slug.md
│       └── ...
└── README.md                # 本文件
```

## 注意事項

- 此分支與 `main` 完全獨立（orphan branch），不包含 workspace 設定檔
- 已存在的文章不會重複抓取（增量更新）
- 文章內容為 HTML 轉 Markdown 的近似結果，供後續分析用
