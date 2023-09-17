function fzf-git-checkout -d "Checkout a branch using fzf"
  git branch --all | grep -v HEAD | string trim | fzf --preview "git log --graph --color {1}" | read -l branch_name; \
    and git switch (echo "$branch_name" | sed "s#remotes/[^/]*/##")
end
