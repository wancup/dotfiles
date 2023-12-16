# cdls
functions --copy cd standard_cd
function cd
  standard_cd $argv
  ls -a
end

# alias
alias rm="rm -i"
abbr dc "docker compose"
abbr dcb "docker compose build"
abbr dcu "docker compose up"
abbr dcud "docker compose up -d"
abbr dcs "docker compose stop"
abbr dcd "docker compose down"
abbr dsp "docker system prune"
abbr dspa "docker system prune -a"
abbr gf "git fetch"
abbr gfp "git fetch --prune"
abbr gp "git pull"
abbr gpp "git pull --prune"
abbr lg "lazygit"
abbr n "nvim"
abbr fco "fzf-git-checkout"
abbr fgc "fzf-git-commit"
abbr ghna "gh-notify-actions"
if test "$TERM_PROGRAM" = "WezTerm"
  abbr ic "wezterm imgcat"
end

# key bindings
bind \cr fzf-history
bind \er history-pager

# vi mode
set -g fish_key_bindings modal_key_bindings
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

# environments
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx AQUA_ROOT_DIR $XDG_DATA_HOME/aquaproj-aqua
set -gx AQUA_GLOBAL_CONFIG $XDG_CONFIG_HOME/aquaproj-aqua/aqua.yaml
set -gx MANPAGER 'nvim +Man!'
fish_add_path $AQUA_ROOT_DIR/bin
fish_add_path $HOME/.cargo/bin

# setup
eval (/opt/homebrew/bin/brew shellenv)
rtx activate fish | source
starship init fish | source
zoxide init fish | source
