function setup
    function show_help
        echo -e "
USAGE:
\tsetup [OPTIONS]

OPTIONS:
\t-f, --force\t Force regenerate cache and reload setup
"
    end

    argparse h/help f/force -- $argv
    if set -ql _flag_help
        show_help
        return 0
    end

    if test "$(uname)" = Linux
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    end
    if test "$(uname)" = Darwin
        eval (/opt/homebrew/bin/brew shellenv)
    end

    set -l cache_dir "$XDG_CACHE_HOME/fish"
    set -l cache_file "$cache_dir/setup.fish"
    if not test -f "$cache_file"; or set -ql _flag_force
        mkdir -p $cache_dir
        aqua completion fish >~/.config/fish/completions/aqua.fish
        fnm completions --shell fish >~/.config/fish/completions/fnm.fish

        echo "" >$cache_file
        zoxide init fish >>$cache_file
        fzf --fish >>$cache_file
        fnm env --use-on-cd --shell fish >>$cache_file
    end

    source $cache_file
end
