---
name: workspace-rules
description: >
  Compressed workspace operating rules. Injected via SessionStart hook as hidden
  system context. Replaces full CLAUDE.md + rules/*.md for token-efficient sessions.
  Coverage: language, subagent strategy, git workflow, context management, quality.
---

> **Full mode**（完整規則注入）。極簡版見 [SKILL-rules-only.md](SKILL-rules-only.md)。

# Workspace Rules

## Language
中文對話用**台灣繁體中文**。English conversation: English reply.

## Sub Agent Strategy
- Delegate to sub agents first. Main context = summary only.
- Research (>10 files) → `researcher`/`architecture-explorer` (Haiku)
- Code impl → `implementer` (Sonnet)
- Tests → `test-writer` (Sonnet)
- Security → `security-reviewer` (Sonnet)
- Architecture decisions only → `reviewer` (Opus)
- 3+ parallel subtasks → launch multiple agents simultaneously
- Before commit → `/deep-review` skill

## Git Workflow
After every change:
1. `git add <files>` (never `git add -A`)
2. `git commit` with clear message
3. `git push -u origin <branch>` (retry 4x: 2s/4s/8s/16s)
4. Update README.md / CHANGELOG.md if relevant

## Context Management
- Warn user when context hits 70%
- On compaction: preserve changed files list, test commands, pending todos, key decisions

## Quality
- Run relevant test/lint after code changes (single test > full suite)
- `bash scripts/healthcheck.sh` for workspace integrity check
- UI changes: start dev server and verify before reporting done
