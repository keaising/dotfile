---
description: 生成规范的 commit message
---

遵循语义化 commit message 提交规范为当前暂存区更改生成提交 message，根据改动内容自动推断 feat/fix/chore 之类的标签
如 feat(server):xxxx / fix(app): xxx

1. 获取 unstage/stage area 完整变更作为依据
2. 要符合本项目里之前 commit 的一般习惯
3. 简洁的 PR 标题（4-6 个单词，不要超过70个字符）

如果当前目录中带有 workspace 字样，还需

1. 生成结构化描述：

- Summary（1-3 个要点）
- Why：本次改动的原因，为什么要有这次改动
- Test plan：受本次改动影响的、需要测试的点

2. 默认情况下，在 description 的最后一行加上 [deploy staging]
   如果我给你的提示词里包含 deploy test main 字样，在 description 的最后一行还要额外加上 [deploy test main]
   commit message 中不要添加 Co-Authored-By 行

如果是其他目录则不用管

生成后直接执行 git commit，不要 push。
