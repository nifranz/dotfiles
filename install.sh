# linking config files
ln -sv "~/.dotfiles/git/.gitconfig" ~
ln -sv "~/.dotfiles/zsh/.zshrc" ~
ln -s "~/.dotfiles/nvim/astronvim_config/" "~/.config/nvim/lua/user"
ln -s "~/.dotfiles/.npmrc" "~/.npmrc"

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add brew repositories
brew tap homebrew/cask-fonts

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install cli apps
brew install git 
brew install neovim 
brew install python
brew install mysql 
brew install node 
brew install php 
brew install tree-sitter

# install gui apps
brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask brave-browser
brew install --cask spotify 
brew install --cask discord
brew install --cask whatsapp 
brew install --cask notion 

# install fonts
brew install font-hack

# configuring npm 
mkdir ~/.npm-packages


