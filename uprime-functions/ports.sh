#!/bin/bash

allArgs=("$@")
unset allArgs[0] # remove first argument which is --ports

# check if first argument is --remove
if [ "${allArgs[1]}" == "--remove" ]; then
    echo "[--remove] REMOVING PORTS SPECIFIED"
    unset allArgs[1] # remove --remove

    for arg in "${allArgs[@]}"; do
        echo "Removing port ${arg}..."
        sudo ufw delete allow ${arg}

        if [ $? -ne 0 ]; then
            echo "Error: Something went wrong. See the error above."
            exit 1
        fi
    done

    echo "Done."
    exit 0
fi

# iterate over allArgs
for arg in "${allArgs[@]}"; do
    echo "Enabling port ${arg}..."
    sudo ufw allow ${arg}

    if [ $? -ne 0 ]; then
        echo "Error: Something went wrong. See the error above."
        exit 1
    fi
done

echo "Done."