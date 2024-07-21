function fzf_gh_co_pr -d "Search pull requests with fzf and then gh co"
    gh pr list | fzf | awk "{print \$1;}" | read -l id
        and gh co "$id"
end
