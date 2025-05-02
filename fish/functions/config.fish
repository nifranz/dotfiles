function config
    set config_files "fish user config" "fish aliases" "fish exports" "ssh hosts" paths

    echo "Select a config file:"
    for i in (seq (count $config_files))
        echo "$i) $config_files[$i]"
    end

    echo -n "Enter number: "
    read choice

    # Validate input and resolve selection
    set selection ""
    if test $choice -gt 0 -a $choice -le (count $config_files)
        set selection $config_files[$choice]
    else
        echo "Invalid selection."
        return 1
    end

    set filePath ""
    switch $selection
        case "fish user config"
            set filePath "$HOME/.dotfiles/fish/user.config.fish"
        case "fish aliases"
            set filePath "$HOME/.dotfiles/fish/aliases.fish"
        case "fish exports"
            set filePath "$HOME/.dotfiles/fish/exports.fish"
        case "ssh hosts"
            set filePath "$HOME/.ssh/config"
        case paths
            set filePath "$HOME/.dotfiles/fish/paths.fish"
    end

    if test -z "$filePath"
        echo "No file path found for $selection"
        return 1
    end

    set editors nvim vim code nano
    echo "Select an editor:"
    for i in (seq (count $editors))
        echo "$i) $editors[$i]"
    end

    echo -n "Enter editor number: "
    read eidx
    if test $eidx -gt 0 -a $eidx -le (count $editors)
        set editor $editors[$eidx]
    else
        echo "Invalid editor selection."
        return 1
    end

    echo "Opening $filePath with $editor ..."
    command $editor $filePath
    echo "Reloading fish environment ..."
    echo "Done!"
    reload
end
