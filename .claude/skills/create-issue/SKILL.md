---
name: create-issue
description: 対話的にGitHub Issueを作成する。要件をヒアリングし、内容を確認した上で作成する。
argument-hint:
allowed-tools: AskUserQuestion
---

# GitHub Issue作成ワークフロー

## 1. 要件のヒアリング

AskUserQuestionツールを使用して、作成するIssueの内容をヒアリングしてください:

- Issueの目的・背景（何を解決したいか）
- 具体的な要件や期待する動作
- ラベルやアサインなどの付加情報（任意）

不明点や曖昧な点がある場合は、追加でAskUserQuestionを使って確認してください。
一度にすべてを聞こうとせず、対話的に要件を明確にしていくこと。

## 2. Issue内容の確認

ヒアリング結果をもとに、以下の形式でIssue内容を整理してユーザーに提示してください:

```
タイトル: <Issueタイトル>
ラベル: <ラベル（あれば）>

本文:
<Issue本文のプレビュー>
```

AskUserQuestionツールで以下を確認:
- この内容でIssueを作成してよいか
- 修正したい箇所はあるか

ユーザーから修正の指示があった場合は内容を修正し、再度確認を求めること。
**承認を得るまでIssueは作成しないこと。**

## 3. Issueの作成

ユーザーの承認を得たら、`gh issue create` でIssueを作成してください。

作成後、Issue番号とURLをユーザーに報告してください。
