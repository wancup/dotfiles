---
name: implement-issue
description: GitHub Issue番号と任意の分岐元ブランチ名を受け取り、実装方針策定・ブランチ作成・TDD実装・コードレビュー修正ループを一連で実行する
argument-hint: <issue番号> [分岐元ブランチ名]
disable-model-invocation: true
allowed-tools: Skill(sketch), Skill(tdd), Skill(review-local), AskUserQuestion, Agent, Read, Edit, Write, Glob, Grep, Bash(gh issue view:*), Bash(gh issue list:*), Bash(gh repo view:*), Bash(git branch:*), Bash(git fetch:*), Bash(git switch:*), Bash(git diff:*)
---

# Issue実装ワークフロー

以下の手順を実行してください。各ステップの結果を次のステップに引き継ぐこと。

## 1. Issue内容の取得とブランチ準備

最初に `$ARGUMENTS` を解析し、先頭の値を **Issue番号**、2つ目の値があれば **分岐元ブランチ名** として扱ってください。分岐元ブランチ名が未指定の場合は、デフォルトブランチを分岐元として使用します。

以下のコマンドのうち、必要なものを **並列で実行**してください:

- `gh issue view <Issue番号> --json number,title,body,labels,comments,state,url` でIssueの番号・タイトル・本文・ラベル・コメント・状態・URLを取得
- `git branch -a` で既存ブランチの命名規則を確認
- 分岐元ブランチ名が未指定の場合のみ、`gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'` でデフォルトブランチ名を取得

GitHub上のIssue relationship（Parent issue、Sub-issues、依存関係など）が設定されているか確認するため、`gh issue list --state all --limit 1000 --json number,title,state,url,parent,subIssues,blockedBy,blocking --jq '.[] | select(.number == <Issue番号>)'` を実行してください。relationshipが設定されている場合は、該当するIssueも `gh issue view <Issue番号またはURL> --json number,title,body,labels,comments,state,url` で取得してください。取得した親Issue・関連Issueについても同じ `gh issue list --state all --limit 1000 --json number,title,state,url,parent,subIssues,blockedBy,blocking --jq '.[] | select(.number == <Issue番号>)'` でGitHub上のrelationshipを確認し、実装判断に必要な範囲で同様に取得してください。

以降のステップでは、指定された分岐元ブランチ名があればそれを、未指定であれば取得したデフォルトブランチ名を **分岐元ブランチ名** として扱ってください。

取得した対象Issue・親Issue・関連Issueの内容を以降のステップで参照できるよう、Issue間の関係と要件を整理してまとめてください。

## 2. ブランチの作成

### 2.1 分岐元ブランチの最新を取得

`git fetch origin <分岐元ブランチ名>` を実行してください。

### 2.2 ブランチを作成してチェックアウト

既存ブランチの命名規則に従い、Issueの内容に基づいた適切なブランチ名を決定し、`git switch -c <ブランチ名> --no-track origin/<分岐元ブランチ名>` で新しいブランチを作成してください。

## 3. 実装方針の策定

Skillツールを使用して **sketch** スキルを呼び出し、実装方針を策定してください。

argsには以下を含めること:

- 取得した対象Issue・親Issue・関連Issueの全内容（番号・タイトル・本文・ラベル・コメント・状態・URL）
- 「このIssueを実装するための実装方針を策定してください」という指示
- コードベースの調査も含めて、変更が必要なファイル・関数・処理の特定を依頼
- 以下の観点を含めること:
  - 設計方針: アーキテクチャ上の判断、採用するパターン、既存コードとの整合性
  - 変更対象: 変更・追加が必要なファイルと各ファイルでの変更概要
  - 影響範囲: 変更による既存機能への影響と対処方法

sketchスキルが確認事項を返した場合は、その内容をユーザーと一問一答で詰めながら、最終的な実装方針まで収束させてください。

### 3.1 ユーザー承認

策定した実装方針（設計方針・変更対象・影響範囲）をユーザーに提示し、AskUserQuestionツールで承認を求めてください。
ユーザーからフィードバックがあった場合は、実装方針を修正して再度承認を求めてください。

## 4. TDD実装の実行

Skillツールを使用して **tdd** スキルを呼び出してください。

argsには以下の情報をすべて含めてください:

- 取得した対象Issue・親Issue・関連Issueの全内容
- ステップ3で承認された実装方針の全文

## 5. コードレビューと修正ループ

以下のレビュー・修正サイクルを、指摘事項がなくなるまで繰り返してください。

### 5.1 コードレビュー

Skillツールを使用して **review-local** スキルを呼び出してください。argsには、`$ARGUMENTS` から解析した **Issue番号のみ** を渡してください。

レビュー結果の総合判定を確認し、「要議論」の場合は「要修正」として扱ってください。

### 5.2 修正（総合判定が「要修正」の場合）

総合判定が「要修正」の場合、Agentツールを使用して **general-purpose** のサブエージェントを起動し、指摘事項の修正を行ってください。

サブエージェントへのプロンプトには以下を含めること:

- 取得した対象Issue・親Issue・関連Issueの全内容（修正の方向性を正しく判断するため）
- コードレビューの指摘事項の全文
- 「以下のコードレビューの指摘事項をすべて修正してください」という指示
- 修正後にプロジェクトで定義されているテストコマンド（例: `npm run test`, `make test`, `task test` など）を使用してテストを実行し、既存テストが壊れていないことを確認すること。

### 5.3 ループ継続判定

- 修正完了後、ステップ5.1に戻って再度コードレビューを実施する
- 総合判定が「LGTM」になるまでこのループを繰り返す
- ただし、ループは最大3回までとし、3回を超えた場合は現状の指摘事項をユーザーに報告して終了する

## 6. 結果の報告

すべてのステップが完了したら、以下をユーザーに報告してください:

- 作成したブランチ名
- 分岐元ブランチ名
- 実装の概要（TDDサイクルで作成したテストと実装の一覧）
- コードレビューの最終結果（総合判定・ループ回数）
- 残存する指摘事項があればその内容
