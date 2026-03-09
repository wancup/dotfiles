---
name: breakdown-issue
description: GitHub Issueを親Issueとしてタスク分解し、子Issueを作成する。
argument-hint: <親Issue番号>
allowed-tools: AskUserQuestion, Agent, Read, Glob, Grep, Bash(gh issue view:*), Bash(gh repo view:*)
---

# 親Issueからのタスク分解ワークフロー

## 1. 親Issue内容の取得

以下を**並列で**実行してください:

- `gh issue view $ARGUMENTS --json title,body,labels,comments` で親Issueの内容を取得
- `gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'` でデフォルトブランチ名を取得

## 2. コードベースの調査

親Issueの内容を踏まえ、Agentツール（subagent_type: Explore）を使用してコードベースを調査してください。
調査の目的は、タスク分解の粒度と内容を適切に判断するためです。

## 3. 方針の確認

親Issueの内容やコードベースの調査結果をもとに、実装方針や分解の方向性について不明点・疑問点がある場合は、AskUserQuestionツールで開発者に確認してください。

確認すべき例:
- 技術的なアプローチの選択肢がある場合、どちらを採用するか
- Issueの要件に曖昧な部分がある場合の解釈
- スコープの判断が難しい場合の優先度

**不明点がない場合でも**、分解の方向性をユーザーに簡潔に伝え、認識が合っているか確認すること。

## 4. タスクの分解

親Issueの要件を実装可能な適切な単位に分解してください。分解の指針:

- 各タスクは独立して実装・レビュー・マージできる粒度にする
- タスク間の依存関係がある場合は明記する
- 各タスクには明確な完了条件を含める

## 5. 子Issue内容の確認

分解したタスク一覧を以下の形式でユーザーに提示してください:

```
親Issue: #<番号> <タイトル>

子Issue一覧:
1. <タイトル1>
   内容: <概要>
   ラベル: <ラベル>

2. <タイトル2>
   内容: <概要>
   ラベル: <ラベル>

...
```

AskUserQuestionツールで以下を確認:
- タスクの分解粒度は適切か
- 追加・削除・修正したいタスクはあるか
- この内容で子Issueを作成してよいか

ユーザーから修正の指示があった場合は内容を修正し、再度確認を求めること。
**承認を得るまで子Issueは作成しないこと。**

## 6. 子Issueの作成

ユーザーの承認を得たら、各子Issueを `gh issue create` で作成してください。

各子Issueの本文には以下を含めること:
- 親Issue: #<番号> への参照リンク
- タスクの詳細な説明
- 完了条件（Acceptance Criteria）
- 依存関係がある場合はその旨

## 7. 親Issueの更新

すべての子Issueを作成したら、親Issueの本文にタスク一覧（子Issueへのリンク付き）を**追記**してください。
`gh issue edit` を使用し、既存の本文は削除せず末尾に追加すること。

追記する形式:
```markdown

## タスク分解

- [ ] #<子Issue番号1> <タイトル1>
- [ ] #<子Issue番号2> <タイトル2>
...
```

## 8. 結果の報告

以下をユーザーに報告してください:
- 作成した子Issueの一覧（番号・タイトル・URL）
- 親Issueが更新されたこと
