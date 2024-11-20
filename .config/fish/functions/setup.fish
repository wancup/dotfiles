function setup
    eval (/opt/homebrew/bin/brew shellenv)
    mise activate fish | source
    zoxide init fish | source
    fzf --fish | source
end
