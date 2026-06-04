function git_worktree_add -d "Create a git worktree from the current worktree root and cd into it"
    function show_help
        echo -e "
USAGE:
\tgit_worktree_add [OPTIONS] <new-branch> <base-branch>

OPTIONS:
\t-h, --help\t Show this help

WORKTREE PATH:
\t../[project-name]__[new-branch-with-/-replaced-by-_]
"
    end

    argparse h/help -- $argv
    or return 1

    if set -ql _flag_help
        show_help
        return 0
    end

    if test (count $argv) -ne 2
        show_help
        return 1
    end

    git rev-parse --is-inside-work-tree >/dev/null 2>/dev/null
    or begin
        echo "Please run this command inside a git repository" >&2
        return 1
    end

    set -l current_worktree_root (git rev-parse --show-toplevel)
    if test "$PWD" != "$current_worktree_root"
        echo "Please run this command in a worktree root" >&2
        return 1
    end

    set -l common_git_dir (git rev-parse --path-format=absolute --git-common-dir)
    or return 1

    set -l repo_root (dirname "$common_git_dir")
    set -l new_branch $argv[1]
    set -l base_branch $argv[2]
    set -l repo_name (basename "$repo_root")
    set -l safe_branch (string replace -a / _ -- "$new_branch")
    set -l repo_parent (dirname "$repo_root")
    set -l target_dir "$repo_parent/"$repo_name"__"$safe_branch

    git -C "$repo_root" worktree add --no-track -b "$new_branch" "$target_dir" "$base_branch"
    or return 1

    cd "$target_dir"
end
