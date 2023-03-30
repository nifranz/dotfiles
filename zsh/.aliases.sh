# File: zsh/.aliases.sh
# This file defines aliases sourced by /bin/zsh

# command aliases
alias g="git"
alias reload="source ~/.zshrc"
alias ndev="npm run dev"
alias vim="nvim"
alias re="tmux a"

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
