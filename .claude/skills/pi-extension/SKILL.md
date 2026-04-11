---
name: pi-extension
description: piコーディングエージェントのextensionを作成する
argument-hint: <extensionの機能説明>
allowed-tools: Bash, Read, Edit, Write, Glob, Grep
---

# pi extension作成ワークフロー

以下の手順を順番に実行してください。

作成するextension: `$ARGUMENTS`

## 1. ドキュメントの読み込み

Bashツールで以下のコマンドを実行し、extensions.mdのパスを取得してください:

```bash
dotfiles_dir="$(dirname "$(dirname "$(realpath "$XDG_CONFIG_HOME/fish")")")"
echo "$dotfiles_dir/npm/node_modules/@mariozechner/pi-coding-agent/docs/extensions.md"
```

取得したパスをReadツールで読み込み、APIの仕様（イベント、ツール登録、コマンド登録、UI操作など）を把握してください。

## 2. 要件分析と設計

`$ARGUMENTS` をもとに以下を決定してください:

1. **使用するAPI** — イベント (`pi.on`)、カスタムツール (`pi.registerTool`)、コマンド (`pi.registerCommand`)、ショートカット (`pi.registerShortcut`) のうち何が必要か
2. **extension構成** — 単一ファイル (`.ts`) / ディレクトリ (`index.ts`) / パッケージ (`package.json`) のどれが適切か
3. **配置場所** — グローバル (`~/.pi/agent/extensions/`) またはプロジェクトローカル (`.pi/extensions/`)
4. **状態管理** — セッションをまたいで状態を保持する必要があるか

## 3. 実装

以下の注意点に従いextensionを実装してください:

- TypeScriptで記述し、コンパイル不要（jitiで実行される）
- `import type { ExtensionAPI } from "@mariozechner/pi-coding-agent"` でAPIをインポート
- `import { Type } from "@sinclair/typebox"` でスキーマ定義
- string enumは `StringEnum` (@mariozechner/pi-aiから) を使う（Google API互換のため）
- ツールの出力は50KB / 2000行を超えないよう truncateHead / truncateTail でトランケートする
- ファイルを変更するツールは `withFileMutationQueue` でラップする
- エラーを示す場合は return ではなく throw を使う

## 4. 結果の報告

以下のフォーマットで報告してください:

### 作成したextension

| 項目 | 内容 |
|------|------|
| ファイルパス | ... |
| 機能概要 | ... |
| 使用API | ... |

### 使い方

extensionの起動方法や使用方法の簡潔な説明。
