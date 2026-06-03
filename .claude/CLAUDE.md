# CLAUDE.md

- 日本語本文では和文ベタ組みを基本とし、日本語と英数字の間に不要な空白を入れない
- 一時的な処理にPythonスクリプトを使うのはなるべく避ける
- 一時ファイルを作成する際はプロジェクト内の`.__tmp/`ディレクトリを使用する
- コミットメッセージは簡潔に書く
- git worktreeを作成するときは、リポジトリルートで`git worktree add --no-track -b [branch-name] ../[project-name]__[branch-name]`を使う
