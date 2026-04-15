---
name: workspace-rules-selective
description: >
  Minimal workspace rules — only the most critical operating constraints.
  Used for Rules.md selective injection mode. Strips examples and rationale,
  keeps only actionable directives.
---

# Critical Rules

Lang: 中文→繁體中文 | English→English
Agents: delegate first; researcher/implementer/test-writer/security-reviewer/reviewer
Git: add→commit→push -u origin (retry 4x) after every change
Context: warn at 70%; on compact preserve files+todos+decisions
Commit guard: /deep-review before commit
Quality: run single test after change; healthcheck.sh for workspace
