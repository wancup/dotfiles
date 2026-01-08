# cdls
if not functions --query standard_cd
    functions --copy cd standard_cd
end
function cd
    standard_cd $argv
    lsd -a
end
function __zoxide_cd_internal
    standard_cd $argv
    lsd -a
end

# alias
alias rm="rm -i"
abbr agi "aqua generate -i"
abbr aia "aqua install -a -l"
abbr au "aqua update-checksum --prune"
abbr buu "brew upgrade && brew update"
abbr diffs diff_stdout
abbr dc "docker compose"
abbr dcb "docker compose build"
abbr dcd "docker compose down"
abbr dce "docker compose exec"
abbr dcs "docker compose stop"
abbr dcu "docker compose up"
abbr dcud "docker compose up -d"
abbr dsp "docker system prune"
abbr dspa "docker system prune -a"
abbr ffr find_gh_pr_for_review
abbr fpr find_gh_pr
abbr fgb find_git_branch
abbr fgc find_git_commit
abbr gbi "git blame --ignore-revs-file .git-blame-ignore-revs"
abbr gc "git clone"
abbr gdd "GIT_EXTERNAL_DIFF=difft git diff"
abbr gds "GIT_EXTERNAL_DIFF=difft git show --ext-diff"
abbr gdl "GIT_EXTERNAL_DIFF=difft git log -p --ext-diff"
abbr gf "git fetch"
abbr gfp "git fetch --prune"
abbr ghna gh_notify_actions
abbr gn "git --no-pager"
abbr gp "git pull"
abbr gpr "git pull --rebase"
abbr gpp "git pull --prune"
abbr gs "git switch"
abbr gsm "git switch main"
abbr la lsd -a
abbr ll lsd -la
abbr lg lazygit
abbr lq lazysql
abbr lr lazydocker
abbr n nvim
abbr nn nvim_clipboard
abbr o. "open ."
abbr p pnpm
abbr reload "source $HOME/.config/fish/config.fish && setup -f"
abbr sws static-web-server
if test "$TERM_PROGRAM" = WezTerm
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
set -gx XDG_BIN_HOME $HOME/.local/bin
set -gx AQUA_ROOT_DIR $XDG_DATA_HOME/aquaproj-aqua
set -gx AQUA_GLOBAL_CONFIG $XDG_CONFIG_HOME/aquaproj-aqua/aqua.yaml
set -gx MANPAGER 'nvim +Man!'
set -gx EDITOR nvim

# paths
fish_add_path $AQUA_ROOT_DIR/bin
fish_add_path $HOME/.cargo/bin

# setup
if test -z "$NVIM"
    setup
end
