#!/bin/bash

# wildcard file check with .cpp-template
if ls *.cpp-template 1> /dev/null 2>&1; then
    parentDir=`basename "${PWD}"`

    mv ${parentDir}.cpp-template ${parentDir}.cpp
    mv ${parentDir}.hpp-template ${parentDir}.hpp

    if [ $? -ne 0 ]; then
        echo "Error: Something went wrong. See the error above."
        exit 1
    fi

    echo "Done."
else
    echo "Error: No .cpp-template files found. Please run this script from a component directory."
    exit 1
fi

