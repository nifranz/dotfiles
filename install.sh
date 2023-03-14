# linking config files
ln -sv "~/.dotfiles/git/.gitconfig" ~
ln -sv "~/.dotfiles/zsh/.zshrc" ~

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap homebrew/cask-fonts
brew install font-hack

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install cli apps
brew install neovim node python mysql php tree-sitter

# install gui apps
brew install --cask iterm2 visual-studio-code spotify brave-browser discord whatsapp notion

