# File: zsh/.aliases.sh
# This file defines aliases sourced by /bin/zsh

# command aliases
alias defaulteditor="code"
alias vsc="code"
alias g="git"
alias gcm="git commit -m"
alias ga="git add -A"
alias gp="git push"
alias grsuo="git remote set-url origi"
alias reload="source ~/.config/fish/config.fish"
alias ndev="npm run dev"
alias vim="nvim"
alias re="tmux a"
alias tmuxreload="tmux source ~/.dotfiles/.tmux/.tmux.conf"
alias karabiner="'/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli'"
alias vm="vboxmanage"
alias rmnode="rm -rf package-lock.json package.json node_modules"
alias chx="chmod +x"
alias rvsc="rcode"
alias o="open ."

# exa aliases

# change directory aliases
alias foundry="sh -c 'cd ~/dev/ressources/foundry/foundry-app; npm run start'"

# different nvim configurations
alias vim='NVIM_APPNAME=lvim nvim'

alias d-up='docker compose up -d'
alias d-down='docker compose down'
alias d-restart='docker compose down && docker compose up -d'
