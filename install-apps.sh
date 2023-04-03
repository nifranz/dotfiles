if [[ $(uname) != "Darwin" ]]; then
    echo "This script can only be executed on macOS"
    exit 1
fi

brew install --cask brave-browser
brew install --cask spotify 
brew install --cask discord
brew install --cask whatsapp 
brew install --cask notion  