# autoload
autoload -Uz compinit
compinit

# alias
alias ls='ls -G'
alias la='ls -a'
alias ll='ls -l'
alias rm='rm -i'

chpwd() { ls -Ga }

# option
setopt no_beep
setopt ignore_eof

# path
export PATH=$PATH:$HOME/.cargo/bin:$HOME/.local/bin

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"

