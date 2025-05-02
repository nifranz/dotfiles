#!/bin/bash
# Before running this script, please first install fish shell and tide.

echo 'source "$HOME/.dotfiles/fish/user.config.fish"' >> "$HOME/.config/fish/config.fish"
echo /usr/local/bin/fish | sudo tee -a /etc/shells

