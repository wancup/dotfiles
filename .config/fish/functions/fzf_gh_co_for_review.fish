function fzf_gh_co_for_review -d "Search pull requests requested for review with fzf and then gh co"
  gh for-review | fzf | awk "{print \$1;}" | read -l id; \
    and gh co "$id"
end
