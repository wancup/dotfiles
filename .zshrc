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

if command -v aqua >/dev/null 2>&1; then
  export AQUA_GLOBAL_CONFIG="${XDG_CONFIG_HOME}/aquaproj-aqua/aqua.yaml"
  export PATH="$(aqua root-dir)/bin:${PATH}"
fi

