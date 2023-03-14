# File: zsh/.functions.sh
# This file defines shell functions sourced by /bin/zsh

# Function: sshc()
# A function defining a shortcut for opening a ssh connection to commonly used hosts
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

# Function: config()
# A function defining a shortcut for opening commonly used config files with nvim.
function config() {
  echo Select a config file to open:
  config_files=('zsh' 'zsh aliases' 'zsh functions')

  select FILE in $config_files
  do
    if [ $FILE = 'zsh' ]
    then
      echo zsh
      nvim ~/.dotfiles/zsh/.zshrc
      break
    fi

    if [ $FILE = 'zsh aliases' ]
    then
      echo zsh
      nvim ~/.dotfiles/zsh/.aliases.sh
      break
    fi

    if [ $FILE = 'zsh functions' ]
    then
      echo zsh
      nvim ~/.dotfiles/zsh/.functions.sh
      break
    fi
    break
  done
}
