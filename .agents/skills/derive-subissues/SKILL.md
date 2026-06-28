---
name: derive-subissues
description: GitHub Issueを親Issueとしてタスク分解し、子Issueを作成する。
argument-hint: <親Issue番号>
disable-model-invocation: true
allowed-tools: AskUserQuestion, Agent, Read, Glob, Grep, Bash(gh issue view:*), Bash(gh repo view:*), Bash(gh issue create:*), Bash(gh issue edit:*)
---

# 親Issueからのタスク分解ワークフロー

## 1. 親Issue内容の取得

以下を**並列で**実行する:

- `gh issue view $ARGUMENTS --json number,title,body,labels,comments,url` で親Issueの内容を取得
- `gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'` でデフォルトブランチ名を取得

## 2. コードベースの調査

親Issueの内容を踏まえ、Agentツール（subagent_type: Explore）を使用してコードベースを調査する。
調査の目的は、タスク分解の粒度と内容を適切に判断するためである。

## 3. 方針の確認

親Issueの内容やコードベースの調査結果をもとに、実装方針や分解の方向性について不明点・疑問点がある場合は、AskUserQuestionツールで開発者に確認する。

確認すべき例:

- 技術的なアプローチの選択肢がある場合、どちらを採用するか
- Issueの要件に曖昧な部分がある場合の解釈
- スコープの判断が難しい場合の優先度

**不明点がない場合でも**、分解の方向性をユーザーに簡潔に伝え、認識が合っているか確認すること。

## 4. タスクの分解

親Issueの要件を実装可能な適切な単位に分解する。分解の指針:

- 各タスクは独立して実装・レビュー・マージできる粒度にする
- タスク間の依存関係がある場合は明記する
- 各タスクには明確な完了条件を含める
- 作成予定の子Issue同士を参照する必要がある場合、暫定IDとして`#1`のようなGitHub Issue参照形式を使わない。意図しない既存Issueへのリンクを避けるため、作成前の参照は`TASK-A`や`<作成後にIssue番号を反映>`のようなリンク化されない表記にする

## 5. 子Issue内容の確認

分解したタスク一覧を以下の形式でユーザーに提示する:

```markdown
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

ユーザーの承認を得たら、子Issueを1件ずつ作成する。

各子Issueを作成する直前に、実際に登録する内容を以下の形式でユーザーに提示する:

```markdown
作成予定の子Issue <現在番号>/<総数>
タイトル: <タイトル>
ラベル: <ラベル>

本文:
<gh issue createに渡す本文全文>
```

AskUserQuestionツールで、その子Issueを実際に登録してよいかを1件ずつ確認する。

- 承認された場合のみ、その子Issueを `gh issue create` で作成する
- 修正指示があった場合は内容を修正し、修正後の内容を再提示して再度確認する
- 作成不要と判断された場合は、その子Issueの作成をスキップする
- 承認を得ていない子Issueは作成しない

各子Issueの本文には以下を含めること:

- タスクの詳細な説明
- 完了条件（Acceptance Criteria）
- 依存関係がある場合はその旨

作成する子Issueの本文内で、他の作成予定の子Issueを参照する場合:

- 作成前・確認時点では`#1`のようなGitHub Issue参照形式を使わない
- 参照先Issueがすでに作成済みの場合のみ、実際のIssue番号（例: `#123`）またはURLで参照する
- 参照先Issueが未作成の場合は、いったんリンク化されない表記（例: `TASK-A`、`<作成後にIssue番号を反映>`）で作成し、参照先Issueの作成後に `gh issue edit` で本文を更新して実際のIssue番号に置き換える
- Issue番号の置き換えが必要なIssueは記録しておき、すべての子Issue作成後に漏れなく更新する

各子Issueを作成したら、GitHub CLIで親Issueと関連付ける。
子Issueは `gh issue create` の戻り値URLを指定し、親Issueは手順1で取得した親Issue番号または `$ARGUMENTS` を指定する。

```bash
gh issue edit '<子IssueのURL>' --parent '<親Issue番号またはURL>'
```

## 7. 結果の報告

以下をユーザーに報告する:

- 作成した子Issueの一覧（番号・タイトル・URL）
- 各子Issueに親Issueが設定され、sub-issue relationship として関連付けられたこと
