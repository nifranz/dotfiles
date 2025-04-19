function sshc
    echo "Select a host to connect to: "
    
    set config (cat ~/.ssh/config)
    set hosts (echo "$config" | grep "^Host " | awk '{print $2}')

    for i in (seq (count $hosts))
        echo "$i) $hosts[$i]"
    end

    echo -n "Enter number: "
    read choice

    # Validate input and resolve selection
    set host ""
    if test $choice -gt 0 -a $choice -le (count $hosts)
        set host $hosts[$choice]
    else
        echo "Invalid selection."
        return 1
    end

    echo "Connecting to $host via SSH..."
    ssh $host
end
