# CLAUDE.md

- 一時的な処理にPythonスクリプトを使うのはなるべく避ける
- 一時ファイルを作成する際はプロジェクト内の`.__tmp/`ディレクトリを使用する
- コミットメッセージは簡潔に書く
- git worktreeを作成するときは、リポジトリルートで`git worktree add -b [branch-name] ../[project-name]__[branch-name]`を使う
