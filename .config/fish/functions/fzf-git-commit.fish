function fzf-git-commit -d "Find a commit using fzf"
  git log --pretty=oneline --abbrev-commit --reverse | fzf --tac --no-sort --exact --preview "git show --color {1}" | awk "{print $1;}" | read -l short_hash; \
    and git show "$short_hash"; \
    and git rev-parse "$short_hash" | read -l long_hash; \
    and echo "Commit: $long_hash"
end
