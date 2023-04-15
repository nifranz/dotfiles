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
alias reload="source ~/.zshrc"
alias ndev="npm run dev"
alias vim="nvim"
alias re="tmux a"
alias tmuxreload="tmux source ~/.dotfiles/.tmux/.tmux.conf"
alias karabiner="'/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli'"
alias vm="vboxmanage"
alias rmnode="rm -rf package-lock.json package.json node_modules"
alias chx="chmod +x"
alias rvsc="rcode"

# exa aliases
alias ls="exa -l -g --icons"
alias lsa="exa -a -l -g --icons"

alias ll="exa -l -g --icons --tree"
alias lla="exa -a -l -g --icons --tree --level=2"

# change directory aliases
alias gitni="cd ~/Development/Projects/Git/github-nifranz/"
alias gitup="cd ~/Development/Projects/Git/upgit-nifranz/"
alias foundry="cd ~/Development/Projects/Local/Foundry/FoundryVTT-10.291; npm run start"
alias dotf="cd ~/.dotfiles"
