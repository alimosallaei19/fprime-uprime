#!/bin/bash

currDirectory=`basename "${PWD}"` # also name of deployment.
pathToDictionary="build-artifacts/aarch64-linux/"
toCDOut="../../../"

echo "Using current directory ${currDirectory} as the deployment directory. If this isn't correct, cd to the correct deployment directory and run the function."

# Locate the dictionary file. Slowly move inwards.

cd ./build-artifacts/aarch64-linux

if [ $? -ne 0 ]; then
    echo "Error: build-artifacts directory not found. Please run this script from the deployment directory."
    exit 1
fi


cd ./${currDirectory}/dict

if [ $? -ne 0 ]; then
    cd ./dict
    if [ $? -ne 0 ]; then
        echo "Error: dictionary not found within build-artifacts. You may need to re-cross compile or re-build the deployment"
        exit 1
    fi

    pathToDictionary="${pathToDictionary}dict/"
else 
    pathToDictionary="${pathToDictionary}${currDirectory}/dict/"
    toCDOut="${toCDOut}../"
fi

ls ./${currDirectory}TopologyAppDictionary.xml > /dev/null

if [ $? -ne 0 ]; then
    echo "Error: dictionary file not found. You may need to re-cross compile or re-build the deployment"
    exit 1
fi

pathToDictionary="${pathToDictionary}${currDirectory}TopologyAppDictionary.xml"

echo "Build artifact dictionary found. Opening GDS now..."

cd ${toCDOut}

fprime-gds -n --dictionary ${pathToDictionary}

