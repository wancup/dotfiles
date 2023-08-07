# autoload
autoload -Uz compinit
compinit

# alias
alias ls='ls -G'
alias la='ls -a'
alias ll='ls -l'
alias rm='rm -i'
alias lg='lazygit'

chpwd() { ls -Ga }

# option
setopt no_beep
setopt ignore_eof

# env
export PATH="$PATH:$HOME/.cargo/bin"
export XDG_CONFIG_HOME="$HOME/.config"

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(rtx activate zsh)"

