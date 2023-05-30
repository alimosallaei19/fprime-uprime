#!/bin/bash

/opt/toolchains/bin/aarch64-none-linux-gnu-gcc -v

if [ $? -ne 1 ]; then
    echo "Cross-compiler environment was already found. See receipt above. Exiting..."
    exit 0
else
    # from https://github.com/fprime-community/fprime-workshop-led-blinker/blob/main/docs/prerequisites.md
    
    sudo apt update
    sudo apt install build-essential git g++ gdb cmake python3 python3-venv python3-pip
    sudo mkdir -p /opt/toolchains
    sudo chown $USER /opt/toolchains
    curl -Ls https://developer.arm.com/-/media/Files/downloads/gnu-a/10.2-2020.11/binrel/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.tar.xz | tar -JC /opt/toolchains --strip-components=1 -x

    if [ $? -ne 0 ]; then
        echo "Error while building cross-compiler environment. See above."
        exit 1
    else
        echo "Cross-compiler environment built successfully."
        exit 0
    fi
fi