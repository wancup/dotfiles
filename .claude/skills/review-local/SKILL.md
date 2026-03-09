---
name: review-local
description: GitHub Issueに対して現在のブランチのローカル実装をレビューする
argument-hint: <issue-number>
allowed-tools: Read, Glob, Grep, Bash(gh issue view:*), Bash(gh repo view:*), Bash(git rev-parse:*), Bash(git log:*), Bash(git diff:*)
---

# Issue実装レビュー

## 1. Issue内容の取得

`gh issue view $ARGUMENTS --json title,body,labels,comments` を実行して、Issueのタイトル・本文・ラベル・コメントを取得してください。

## 2. 実装差分の取得

### 2.1 分岐元の特定

`git rev-parse --abbrev-ref @{upstream}` で現在のブランチの追跡ブランチを取得してください。
追跡ブランチが設定されていない場合は、`gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'` でデフォルトブランチ名を取得し、`origin/<デフォルトブランチ名>` を分岐元としてください。

### 2.2 コミット済みの変更

`git log --oneline <分岐元>..HEAD` でコミット一覧を確認し、`git diff <分岐元>...HEAD` で分岐元からのコミット済み差分を取得。

### 2.3 未コミットの変更

`git diff HEAD` でステージ済み・未ステージの両方を含む未コミット差分を取得。未コミットの変更がある場合は、レビュー結果内で **[未コミット]** と明示すること。

## 3. レビューの実施

Issueの要件と実装差分を照らし合わせて、以下の観点でレビューしてください:

- **要件の充足**: Issueで求められている機能・修正がすべて実装されているか
- **実装漏れ**: Issueの要件に対して未対応の項目がないか
- **スコープ逸脱**: Issueの範囲外の変更が含まれていないか
- **コード品質**: バグ、エッジケースの未処理、セキュリティ上の懸念がないか
- **テスト**: 必要なテストが追加・更新されているか

## 4. レビュー結果の出力

以下のフォーマットで結果をまとめてください:

### サマリー

Issueの要件に対する実装の全体的な評価を1〜2文で。

### 要件チェックリスト

Issueの各要件について、対応状況を一覧で示す。

### 指摘事項

問題や改善提案があれば、該当ファイル・行番号とともに具体的に記載。

### 総合判定

LGTM / 要修正 / 要議論 のいずれかで判定。
