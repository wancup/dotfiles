function find_git_worktree -d "Select a git worktree with fzf and cd into it"
    git rev-parse --is-inside-work-tree >/dev/null 2>/dev/null
    or begin
        echo "Please run this command inside a git repository" >&2
        return 1
    end

    set -l selection (
        git worktree list --porcelain \
            | grep -E '^(worktree |branch |detached$)' \
            | paste - - \
            | sed -E \
                -e 's/^worktree //' \
                -e 's/\tbranch refs\/heads\//\t/' \
                -e 's/\tdetached$/\t(detached HEAD)/' \
            | fzf --delimiter='\t' \
                --with-nth=2,1 \
                --preview='git -C {1} status --short --branch --untracked-files=no; echo; git -C {1} log --oneline --decorate -n 20' \
                --preview-window='right:60%'
    )

    test -n "$selection"; or return

    set -l worktree_path (string split \t -- "$selection")[1]
    cd "$worktree_path"
end
