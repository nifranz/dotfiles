function mk
    if test (count $argv) -ne 1
        echo "One and only one filepath is required"
    else
        mkdir $argv[1]
        cd $argv[1]
    end
end