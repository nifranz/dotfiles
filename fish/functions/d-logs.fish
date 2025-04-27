function d-logs
    if test (count $argv) -eq 0
        echo "Usage: d-logs <container_name>"
        return 1
    end
    docker logs -f $argv[1]
end
