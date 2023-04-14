if [ $(uname) = "Darwin" ]; then
    ipconfig getifaddr en0
elif [ $(uname) = "Linux" ]; then
    hostname -I | awk '{print $1}'
fi
