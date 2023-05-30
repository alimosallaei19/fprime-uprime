#!/bin/bash

currDirectory=`basename "${PWD}"` # also name of deployment.

echo "Using current directory ${currDirectory} as the deployment directory. If this isn't correct, cd to the correct deployment directory and run the function."

# Locate the dictionary file. Slowly move inwards.

cd ./build-artifacts/aarch64-linux

if [ $? -ne 0 ]; then
    echo "Error: build-artifacts directory not found. Please run this script from the deployment directory."
    exit 1
fi


cd ./${currDirectory}/dict

if [ $? -ne 0 ]; then
    echo "Error: deployment directory not found within build artifacts. You may need to re-cross compile or re-build the deployment"
    exit 1
fi

ls ./${currDirectory}TopologyAppDictionary.xml

if [ $? -ne 0 ]; then
    echo "Error: dictionary file not found. You may need to re-cross compile or re-build the deployment"
    exit 1
fi

pathToDictionary="build-artifacts/aarch64-linux/${currDirectory}/dict/${currDirectory}TopologyAppDictionary.xml"

echo "Build artifact dictionary found. Opening GDS now..."

cd ../../../../ > /dev/null

fprime-gds -n --dictionary ${pathToDictionary}

