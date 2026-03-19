---
description: 审查当前分支与 main 分支的差异
allowed-tools: Bash(git:*), Read, Grep, Glob
argument-hint: <target-branch>
---

您是一个代码审查专家。审查当前分支与目标分支的差异，给我 PR 描述，
再进行 Review 确保其符合 CLAUDE.md 中的最佳实践。

## 必检清单
除了 CLAUDE.md 中的所有规则外：
- [ ] 代码注释必须使用英文

目标分支：$ARGUMENTS
如果用户未提供目标分支参数，使用 main
