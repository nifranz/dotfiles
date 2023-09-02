# Installing dependencies
echo "Creating default directories"
mkdir $HOME/dev
mkdir $HOME/dev/config $HOME/dev/ressources $HOME/dev/projects $HOME/dev/uni;
mkdir $HOME/.config

if [ $(uname) = "Darwin" ]; then
    # Installing dependencies on macOS with homebrew
    echo "installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo "adding additional brew repositories"
    /bin/bash -c "brew tap homebrew/cask-fonts"

    echo "installing apps with brew ..."
    echo "install cli apps"
    brew install git 
    brew install tmux
    brew install exa
    brew install z
    brew install neovim 
    brew install helix
    brew install node 
    brew install mysql 
    brew install php
#   brew install skhd
    brew install koekeishiya/formulae/skhd

    echo "installing gui apps with brew ..."
    brew install --cask iterm2
    brew install --cask visual-studio-code
    brew install --cask karabiner-elements

    echo "installing fonts ..."
    brew install font-hack-nerd-font

    # echo "installing other GUI Apps with homebrew ..."
    # ~/.dotfiles/install-apps.sh

    echo "Homebrew installation done!"

    # macos specific configurations

    echo "Setting macOS defaults..."
    sudo chmod +x ~/.dotfiles/macos-defaults.sh
    ~/.dotfiles/macos-defaults.sh

    echo "linking karabiner keymaps"
    mkdir -p $HOME/.config/karabiner/assets/complex_modifications/
    ln -sv "$HOME/.dotfiles/karabiner/umlaute_remap.json" "$HOME/.config/karabiner/assets/complex_modifications/umlaute_remap.json"

    echo "configuring skhd"
    mkdir -p $HOME/.config/skhd
    ln -sv "~/.dotfiles/skhd/.skhdrc ~/.config/skhd/.skhdrc"
    skhd --start-service

elif [ $(uname) = "Linux" ]; then
    # Installing dependencies on Linux with apt-get

    echo "installing for linux"

    sudo apt-get install zsh
    sudo apt-get install tmux
    sudo apt-get install exa
    sudo apt-get install z
    sudo apt-get install git
    sudo apt-get install neovim 
    sudo apt-get install helix
    sudo apt-get install node 
    sudo apt-get install mysql 
    sudo apt-get install php

    sudo apt-get install code

    sudo apt-get install fonts-hack-ttf
else
    echo "Your operating system is not supported. Exiting."
    exit 1
fi

echo "configuring zsh ..."
echo "linking configurations"

echo "installing oh-my-zsh"
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
ln -sv "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
ln -sv "$HOME/.dotfiles/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

echo "installing custom oh-my-zsh plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/MohamedElashri/exa-zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/exa-zsh

echo "installing custom oh-my-zsh themes"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "zsh configuration done!"

echo "configuring git"
mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
ln -sv "$HOME/.dotfiles/git/.gitconfig" "$HOME/.gitconfig"

echo "configuring tmux"
rm -r "$HOME/.tmux"
rm "$HOME/.tmux.conf"
ln -sv "$HOME/.dotfiles/tmux" "$HOME/.tmux"
ln -sv "$HOME/.dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
sh -c "$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"

echo "configuring helix"
mkdir -p "$HOME/.config/helix/"
ln -sv "$HOME/.dotfiles/helix-editor/config.toml" "$HOME/.config/helix/config.toml"

echo "configuring npm"
mkdir "$HOME/.npm-packages"
ln -sv "$HOME/.dotfiles/.npmrc" "$HOME/.npmrc"


echo "\nAll installations done. For the changes to take effect, please exit and reopen your terminal.\n"

echo "A powerline10k configuration file has been copied to your home directory. If you want to configure p10k yourself, please execute 'p10k configure'".

if [ $(uname) = "Darwin" ]; then
    echo "To enable custom karabiner keymaps, please activate them in karabiner complex keymap section."
    echo "To configure iterm, import the profile 'iterm2/iterm2-profile.json' as well as the preferred color theme from 'iterm2/colors' in the iterm-gui."
fi
