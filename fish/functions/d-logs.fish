function d-logs
# If no argument is passed, ask the user to select a container
    if test (count $argv) -eq 0
        set containers (docker ps --format "{{.Names}}")

        # Check if there are any containers running
        if test (count $containers) -eq 0
            echo "No running containers found."
            return 1
        end

        echo "Select a container:"

        # List containers with their index (starting from 1)
        for i in (seq (count $containers))
            echo "$i. $containers[$i]"
        end

        # Prompt the user to enter a number
        echo -n "Enter the number of the container: "
        read choice

        # Validate input: ensure it's a number and within the valid range
        if not string match -qr '^[0-9]+$' -- $choice
            echo "Invalid input. Please enter a valid number."
            return 1
        end

        if test $choice -lt 1 -o $choice -gt (count $containers)
            echo "Choice out of range."
            return 1
        end

        # Get the container name based on the user's choice
        set container $containers[$choice]
    else
        set container $argv[1]
    end

    docker logs -f $container 
end
