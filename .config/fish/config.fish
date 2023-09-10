# cdls
functions --copy cd standard_cd
function cd
  standard_cd $argv
  ls -a
end

# alias
alias rm="rm -i"
alias dc="docker compose"
alias lg="lazygit"
alias n="nvim"
if test "$TERM_PROGRAM" = "WezTerm"
  alias ic="wezterm imgcat"
end

# environments
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx AQUA_ROOT_DIR $XDG_DATA_HOME/aquaproj-aqua
set -gx AQUA_GLOBAL_CONFIG $XDG_CONFIG_HOME/aquaproj-aqua/aqua.yaml
fish_add_path $AQUA_ROOT_DIR/bin
fish_add_path $HOME/.cargo/bin

# setup
eval (/opt/homebrew/bin/brew shellenv)
rtx activate fish | source
starship init fish | source
zoxide init fish | source
