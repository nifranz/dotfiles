function rcode
    if test (count $argv) -ne 1
        echo "Usage: rcode [user@host:/remote/path]"
        return 1
    end

    set remote $argv[1]
    echo "Opening remote folder $remote in VS Code..."

    # Open with Remote SSH in VS Code
    code --remote ssh-remote+$remote

    echo "Done!"
end