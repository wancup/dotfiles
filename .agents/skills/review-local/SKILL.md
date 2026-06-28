---
name: review-local
description: GitHub Issueに対して現在のブランチのローカル実装をレビューする
argument-hint: <Issue番号> [分岐元ブランチ]
allowed-tools: Skill(fallow-review), Read, Glob, Grep, Bash(gh issue view:*), Bash(gh issue list:*), Bash(gh repo view:*), Bash(git rev-parse:*), Bash(git log:*), Bash(git diff:*)
---

# Issue実装レビュー

## 1. 引数の解釈とIssue内容の取得

`$ARGUMENTS` を空白区切りの位置引数として解釈する。第1引数は対象Issue番号、第2引数は任意の分岐元ブランチ名である。

`gh issue view <Issue番号> --json number,title,body,labels,comments,state,url` を実行して、対象Issueの番号・タイトル・本文・ラベル・コメント・状態・URLを取得する。

GitHub上のIssue relationshipでParent issue等が設定されているか確認するため、`gh issue list --state all --search "#<Issue番号>" --json number,parent,subIssues,subIssuesSummary,blocking,blockedBy --jq '.[] | select(.number == <Issue番号>)'` を実行する。Parent issueが存在する場合は、`gh issue view <親Issue番号またはURL> --json number,title,body,labels,comments,state,url` で親Issueの内容も取得する。

以降のレビューでは、対象Issueの要件に加えて、親Issueの目的・制約・スコープも判断材料として参照する。

## 2. 実装差分の取得

### 2.1 分岐元の特定

第2引数に分岐元ブランチ名が指定されている場合は、デフォルトブランチではなくそのブランチを分岐元として扱う。

第2引数が指定されていない場合は、`git rev-parse --abbrev-ref @{upstream}` で現在のブランチの追跡ブランチを取得する。
追跡ブランチが設定されていない場合のみ、`gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'` でデフォルトブランチ名を取得し、`origin/<デフォルトブランチ名>` を分岐元とする。

### 2.2 コミット済みの変更

`git log --oneline <分岐元>..HEAD` でコミット一覧を確認し、`git diff <分岐元>...HEAD` で分岐元からのコミット済み差分を取得。

### 2.3 未コミットの変更

`git diff HEAD` でステージ済み・未ステージの両方を含む未コミット差分を取得。未コミットの変更がある場合は、レビュー結果内で **[未コミット]** と明示すること。

### 2.4 TS/JSプロジェクトの構造チェック

以下のいずれかに該当する場合はTS/JSプロジェクトとして扱う。

- リポジトリに`package.json`、`tsconfig.json`、`jsconfig.json`のいずれかが存在する
- 分岐元からの変更ファイルに`.ts`、`.tsx`、`.js`、`.jsx`、`.mjs`、`.cjs`のいずれかが含まれる

TS/JSプロジェクトの場合は、Skillツールを使用して **fallow-review** スキルを呼び出す。argsにはステップ2.1で特定した **分岐元ref** のみを渡す。

fallow-reviewの結果は意味的レビューとは別の構造チェックとして扱い、指摘事項・総合判定に反映する。fallow-reviewが`要修正`の場合はreview-localの総合判定も原則`要修正`、`要議論`の場合は原則`要議論`以上として扱う。ただし、fallow-reviewの懸念が今回の差分に関係しないことを差分から明確に判断できる場合は、その理由を明記したうえで判定を調整してよい。

## 3. レビューの実施

対象Issueおよび親Issueの要件、実装差分、TS/JSプロジェクトの場合はfallow-reviewの結果を照らし合わせて、以下の観点でレビューする:

- **要件の充足**: 対象Issueで求められている機能・修正がすべて実装されているか
- **実装漏れ**: 対象Issueの要件に対して未対応の項目がないか
- **親Issueとの整合性**: 親Issueの目的・制約・スコープに反する実装になっていないか
- **スコープ逸脱**: 対象Issueおよび親Issueの範囲外の変更が含まれていないか
- **既存コードとの整合性**: 既存の設計・命名・責務分割・エラーハンドリングなどの方針に沿った実装になっているか
- **実装の重複**: 既存実装で代替できる処理や、同一・類似ロジックの重複が追加されていないか
- **コード品質**: バグ、エッジケースの未処理、可読性・保守性上の懸念がないか
- **セキュリティ**: 認証・認可、入力検証、機密情報の取り扱い、依存関係、権限境界などに脆弱性やリスクがないか
- **テスト**: 必要なテストが追加・更新されているか

## 4. レビュー結果の出力

以下のフォーマットで結果をまとめる:

### サマリー

対象Issueの要件に対する実装の全体的な評価を1〜2文で。親Issueを参照した場合は、その観点での評価も含めること。

### 要件チェックリスト

対象Issueの各要件について、対応状況を一覧で示す。親Issueを参照した場合は、親Issue由来の制約・スコープとの整合性も示す。

### 指摘事項

問題や改善提案があれば、該当ファイル・行番号とともに具体的に記載。

### 構造チェック

TS/JSプロジェクトとしてfallow-reviewを実行した場合は、サマリー・構造的な懸念・判定を要約して記載する。実行しなかった場合は、その理由を簡潔に記載する。

### 総合判定

LGTM / 要修正 / 要議論 のいずれかで判定。
