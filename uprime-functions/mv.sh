#!/bin/bash

if [ ! -d "Top" ]; then
    echo "Error: You're not currently in a deployment folder. Please cd to the deployment folder and run this command again."
    exit 1
fi

# cd ./build-artifacts/${allArgs[2]}

# if [ $? -ne 0 ]; then
#     echo "Error: build-artifacts directory not found. You might need to run --cc-deploy first."
#     exit 1
# fi

# create a timestamp file

# cd ../../
# echo `basename "${PWD}"`

allArgs=("$@")
unset allArgs[0]

scp -r build-artifacts/aarch64-linux ${allArgs[1]}:`basename "${PWD}"`

if [ $? -ne 0 ]; then
    echo "Error: scp failed. Please check your arguments and try again."
    exit 1
fi

echo "Done."