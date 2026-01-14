function fish_prompt
    set -l exit_code $status
    set -lx fish_prompt_pwd_dir_length 0
    set -g VIRTUAL_ENV_DISABLE_PROMPT true

    # VCS
    set -lx __fish_git_prompt_showdirtystate true
    set -lx __fish_git_prompt_showuntrackedfiles true
    set -lx __fish_git_prompt_showupstream informative
    set -lx __fish_git_prompt_showcolorhints true
    set -lx __fish_git_prompt_showstashstate true
    set -lx __fish_git_prompt_char_stateseparator '|'
    set -lx __fish_git_prompt_char_upstream_prefix '|'
    set -lx __fish_git_prompt_color_branch brmagenta --bold

    # Prompt
    set -l prompt_str "(๑╹ω╹๑ )"
    set -l prompt_color brgreen
    if test $exit_code -ne 0
        set prompt_str "(´;ㅿ;｀)"
        set prompt_color brred
    end
    if fish_is_root_user
        set prompt_str (string join prompt_str "!")
    end

    # Dev
    function show_runtime_version
        set_color bryellow
        if test -f "package.json"
            echo -n -s " node:" (node --version)
        else if test -f "Cargo.toml"
            echo -n -s " rust:" (string split " " (rustc --version))[2]
        else if test -n "$VIRTUAL_ENV"
            echo -n -s " " (path basename $VIRTUAL_ENV) ":" (python --version)
        end
    end

    # Information line
    echo
    set_color $prompt_color
    echo -n "┬ "
    set_color brcyan --bold
    echo -n (prompt_pwd)
    set_color normal
    fish_vcs_prompt
    show_runtime_version
    if test $exit_code -ne 0
        set_color $prompt_color
        echo -n (string join "" " [" $exit_code "]")
    end
    set_color brblack
    echo -n -s " " (date +%X)
    echo -n -s "[" (math $CMD_DURATION / 1000) "s]"
    echo

    # Jobs line
    for job in (jobs)
        set_color $prompt_color
        echo -n '│ '
        set_color brblack
        echo $job
    end

    # Prompt line
    set_color $prompt_color
    echo -n -s "└ " $prompt_str " "
end
