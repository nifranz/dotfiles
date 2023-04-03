if [[ $(uname) != "Darwin" ]]; then
    echo "This script can only be executed on macOS"
    exit 1
fi

echo "configuring zsh ..."
echo "installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "installing custom oh-my-zsh plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "installing custom oh-my-zsh themes"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "linking configurations"
ln -sv "~/.dotfiles/zsh/.zshrc" "~"
ln -sv "~/.dotfiles/zsh/.p10k.zsh" "~"

echo "zsh configuration done!"

echo "configuring Homebrew ..."
echo "installing brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "adding additional brew repositories"
brew tap homebrew/cask-fonts

echo "installing apps with brew ..."
echo "install cli apps"
brew install git 
brew install tmux
brew install neovim 
brew install helix
brew install mysql 
brew install node 
brew install php 

echo "installing gui apps with brew ..."
brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask karabiner-elements

echo "installing fonts ..."
brew install font-hack

echo "Homebrew configuration done!"

echo "configuring git"
ln -sv "~/.dotfiles/git/.gitconfig" ~

echo "configuring tmux"
ln -sv "~/.dotfiles/.tmux" "~/.tmux"

echo "configuring helix"
ln -sv "~/.dotfiles/helix-editor/config.toml" "~/.config/helix/config.toml"

echo "configuring npm"
mkdir ~/.npm-packages
ln -sv "~/.dotfiles/.npmrc" "~/.npmrc"

echo "linking karabiner keymaps"
ln -sv "~/.dotfiles/karabiner/umlaute_remap.json" "~/.config/karabiner/assets/complex_modifications/umlaute_remap.json"

echo "Executing macOS defaults configuration script"
~/.dotfiles/macos-defaults.sh

echo "installing other GUI Apps with homebrew ..."
~/.dotfiles/install-apps.sh
echo "other GUI apps installation done!"

echo "\nAll installations done. For the changes to take effect, please exit and reopen your terminal.\n"

echo "A powerline10k configuration file has been copied to your home directory. If you want to configure p10k yourself, please execute 'p10k configure'".
echo "To enable custom karabiner keymaps, please activate them in karabiner complex keymap section."
echo "To ensure all tmux plugins are loaded and installed onto your machine, execute 'prefix + I' in tmux."
echo "To configure iterm, import the profile 'iterm2/iterm2-profile.json' as well as the preferred color theme from 'iterm2/colors' in the iterm-gui."
