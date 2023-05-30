#!/bin/bash

currDirectory=`basename "${PWD}"` # also name of deployment.

echo "Using current directory ${currDirectory} as the project's root directory. If this is not the case, cd to the root folder of the project and execute the command there."

cd fprime

if [ $? -ne 0 ]; then
    echo "Error: fprime directory not found. Please run this script from the root directory of the project."
    exit 1
fi

cd ../

cd fprime-arm-linux

if [ $? -ne 0 ]; 
    then
        git submodule add https://github.com/fprime-community/fprime-arm-linux.git
        git submodule update --init --recursive

    else
        cd ../
fi

if [ $? -ne 0 ]; then
    echo "Error: Something went wrong. See the error above."
    exit 1
fi

basename "${PWD}"

mv fprime-arm-linux/cmake/toolchain/* fprime/cmake/toolchain

rm -rf fprime-arm-linux

if [ $? -ne 1 ]; then
    echo "Done."
fi

