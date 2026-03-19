---
description: 进入先调研后实现的工作流，禁止在用户确认方案前写任何代码
argument-hint: [任务描述]
---

# Research & Plan Mode

进入"先调研后实现"工作流。严格按以下四个阶段执行，**未经用户确认不得写代码**。

---

## 阶段一：调研（Research）

**目标：** 深入理解相关代码，不做任何修改。

- 仔细阅读所有相关文件，理解现有架构、命名约定、设计模式
- 使用 Read、Grep、Glob 工具，**禁止使用 Edit、Write、Bash 写操作**
- 调研完成后，将发现整理写入 `~/.claude/docs/{MM-dd}_{task_name}_research.md`，task_name 用一个适合本次任务的简短名字，不超过4个词，内容包括：
  - 当前代码结构和关键逻辑，关键函数的调用关系要花流程图进行展示，关键数据结构也要罗列出来
  - 与本次任务相关的依赖关系
  - 潜在风险点和需要注意的约定

完成后停下来，等待用户确认可以进入下一阶段。

---

## 阶段二：方案规划（Plan）

**目标：** 基于调研结果，制定详细技术方案。

- 将方案写入 `~/.claude/docs/{MM-dd}_{task_name}_plan.md`，内容包括：
  - 方案说明和技术选型理由
  - 涉及的文件路径和改动内容（附代码片段）
  - 可能的 trade-off
  - 分阶段的 todo checklist（带复选框）
- **禁止在此阶段写任何业务代码**

完成后停下来，等待用户审阅 `~/.claude/docs/{MM-dd}_{task_name}_plan.md`。

---

## 阶段三：批注迭代（Annotation）

**目标：** 用户在 `~/.claude/docs/{MM-dd}_{task_name}_plan.md` 中直接添加批注，Claude 根据批注修订方案。

- 根据用户的批注调整 `~/.claude/docs/{MM-dd}_{task_name}_plan.md` 内容
- 可能多次迭代，直到用户满意为止
- 每次修订后仍然 **不写业务代码**，等待用户明确说"可以开始实现"

---

## 阶段四：实现（Implementation）

**仅在用户明确确认后才进入此阶段。**

- 按 `~/.claude/docs/{MM-dd}_{task_name}_plan.md` 中的 checklist 逐项实现
- 每完成一项，在 `~/.claude/docs/{MM-dd}_{task_name}_plan.md` 中勾选对应任务
- 保持严格类型，持续运行类型检查
- 不添加不必要的注释
- 实现过程中如发现方向错误，立即停止并重新规划，不打补丁

---

## 当前任务

$ARGUMENTS
