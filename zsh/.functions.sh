# File: zsh/.functions.sh
# This file defines shell functions sourced by /bin/zsh
echo Sourcing .functions.sh

function sshc() {
  echo Select a host to connect to: "\a"

  hosts=('niklas@Eragon' 'nifranz@141.89.39.93')

  select ITEM in $hosts
  do
          echo Connecting via ssh to $ITEM ...
          ssh $ITEM
          break
  done
}

function config() {
  echo Select a config file to open:
  config_files=('zsh' '')

  select FILE in $config_files
  do
    if $FILE == 'zsh'
    then
      nvim ~/.dotfiles/zsh/.zshrc
    fi
  done
}
