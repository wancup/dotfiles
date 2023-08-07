if status is-interactive
    # Commands to run in interactive sessions can go here
end

if status --is-login
  fish_add_path $HOME/.cargo/bin
  set -gx XDG_CONFIG_HOME $HOME/.config
end

# cdls
functions --copy cd standard_cd
function cd
  standard_cd $argv
  ls -a
end

# alias
alias rm="rm -i"
alias lg="lazygit"
alias n="nvim"

# setup
eval (/opt/homebrew/bin/brew shellenv)
rtx activate fish | source
starship init fish | source
