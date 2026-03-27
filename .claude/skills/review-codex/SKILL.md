---
name: review-codex
description: copilot CLIを通じてcodexモデルにコードレビューを依頼する
argument-hint: [ファイルパス or なし（差分全体をレビュー）]
allowed-tools: Bash(git diff:*), Bash(git rev-parse:*), Bash(git log:*), Bash(copilot:*)
---

# Codexコードレビュー

## 1. レビュー対象の差分を取得

引数 `$ARGUMENTS` が指定されている場合:
- `git diff HEAD -- $ARGUMENTS` で対象ファイルの差分を取得する

引数が指定されていない場合:
- `git rev-parse --abbrev-ref @{upstream} 2>/dev/null` で追跡ブランチを取得する
- 取得できた場合は `git diff <追跡ブランチ>...HEAD` でコミット済み差分を取得する
- 取得できなかった場合は `git diff HEAD` で未コミット差分を取得する
- 両方の差分を結合する

差分が空の場合はユーザーに「レビュー対象の変更がありません」と伝えて終了する。

## 2. copilotコマンドでcodexモデルにレビューを依頼

以下のBashコマンドを実行する:

```bash
DIFF="<取得した差分>"
copilot --model gpt-5.3-codex -s --no-ask-user -p "以下のコード差分をレビューしてください。セキュリティ、パフォーマンス、可読性、バグの観点で問題点や改善提案を具体的に指摘してください。

$DIFF"
```

## 3. レビュー結果の表示

copilotコマンドの出力をそのままユーザーに表示する。
