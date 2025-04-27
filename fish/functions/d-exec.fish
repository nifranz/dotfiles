function d-exec
    if test (count $argv) -eq 0
        echo "Usage: d-exec <container_name>"
        return 1
    end
    docker exec -it $argv[1] bash
end
