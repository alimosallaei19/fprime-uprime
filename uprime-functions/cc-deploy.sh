#!/bin/bash

cd Top

if [ $? -ne 0 ]; then
    echo "Error: This is not a deployment directory. cd into a deployment directory and try again."
    exit 1
fi

cd ../

if [ -d "build-fprime-automatic-aarch64-linux" ]; then
    echo "Warning: A build folder for arm4 already seems to exist. This build command may fail as a result. Continuing..."
fi

export ARM_TOOLS_PATH=/opt/toolchains
fprime-util generate aarch64-linux
fprime-util build aarch64-linux

if [ $? -ne 0 ]; then
    echo "Error while building deployment. See above."
    exit 1
else
    echo "Deployment built successfully."
    exit 0
fi