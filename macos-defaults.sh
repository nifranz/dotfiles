# Set sensible defaults for MacOS System

if [[ $(uname) != "Darwin" ]]; then
    echo "This script can only be executed on macOS"
    exit 1
fi

# VSCODE
# enable repeated key inputs by holding down a key in vscode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# FINDER - UI
# always show file extensions 
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
# dont warn when changing file extensions
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
# always open finder in column view (all values: Column View = clmv, List View = Nlsv, Gallery View = glyv, Icon View = icnv)
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
# add quit option to finder
defaults write com.apple.finder "QuitMenuItem" -bool "true"
# enable the file path bar
defaults write com.apple.finder "ShowPathbar" -bool "true"

# FINDER - DESKTOP
# show connected hard disk on desktop
defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool "true"
killall Finder


# MENUBAR 
# flash time seperator every second
defaults write com.apple.menuextra.clock "FlashDateSeparators" -bool "true" && killall SystemUIServer


# DOCK
defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
defaults write com.apple.dock autohide-delay -float 0; killall Dock


# SYSTEM
# set system accent color to green
defaults write 'Apple Global Domain' AppleAccentColor 3