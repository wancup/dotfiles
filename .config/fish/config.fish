# cdls
functions --copy cd standard_cd
function cd
  standard_cd $argv
  ls -a
end

# alias
alias rm="rm -i"
abbr buu "brew upgrade && brew update"
abbr dc "docker compose"
abbr dcb "docker compose build"
abbr dcd "docker compose down"
abbr dcs "docker compose stop"
abbr dcu "docker compose up"
abbr dcud "docker compose up -d"
abbr dsp "docker system prune"
abbr dspa "docker system prune -a"
abbr fco "fzf_git_checkout"
abbr fgc "fzf_git_commit"
abbr gf "git fetch"
abbr gfp "git fetch --prune"
abbr ghna "gh_notify_actions"
abbr gp "git pull"
abbr gpp "git pull --prune"
abbr lg "lazygit"
abbr n "nvim"
if test "$TERM_PROGRAM" = "WezTerm"
  abbr ic "wezterm imgcat"
end

# vi mode
set -g fish_key_bindings modal_key_bindings
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block
set -g fish_vi_force_cursor 1

# environments
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx AQUA_ROOT_DIR $XDG_DATA_HOME/aquaproj-aqua
set -gx AQUA_GLOBAL_CONFIG $XDG_CONFIG_HOME/aquaproj-aqua/aqua.yaml
set -gx MANPAGER 'nvim +Man!'
fish_add_path $AQUA_ROOT_DIR/bin
fish_add_path $HOME/.cargo/bin

# setup
eval (/opt/homebrew/bin/brew shellenv)
mise activate fish | source
starship init fish | source
zoxide init fish | source
