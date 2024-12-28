function setup
    if test "$(uname)" = Linux
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    end
    if test "$(uname)" = Darwin
        eval (/opt/homebrew/bin/brew shellenv)
    end

    mise activate fish | source
    zoxide init fish | source
    fzf --fish | source
end
