#!/bin/zsh

current_profile=$('/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli' --show-current-profile-name)
echo "$current_profile"

if [ $current_profile = "Development" ]; then
    '/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli' --select-profile Typing
elif [ $current_profile = "Typing" ]; then
    '/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli' --select-profile Development
fi