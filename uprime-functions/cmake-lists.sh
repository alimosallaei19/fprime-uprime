#!/bin/bash

allArgs=("$@")

if [ -f "CMakeLists.txt" ]; then
    echo "Error: This folder already contains a CMakeLists.txt file."
    exit 1
fi

# check if first argument is either basic or complex
if [ "${allArgs[1]}" = "basic" ]; then
    # create a basic CMakeLists.txt
    echo "Creating a basic CMakeLists.txt..."

    echo "set(SOURCE_FILES" > CMakeLists.txt
    echo "  \"\${CMAKE_CURRENT_LIST_DIR}/${allArgs[3]}\"" >> CMakeLists.txt
    echo ")" >> CMakeLists.txt
    echo "register_fprime_module()" >> CMakeLists.txt

    echo "Done."
    exit 0;
elif [ "${allArgs[1]}" = "complex" ]; then
    # create a complex CMakeLists.txt
    echo "Creating a complex CMakeLists.txt..."

    echo "cmake_minimum_required(VERSION 3.13)" > CMakeLists.txt
    echo "project(`basename "${PWD}"` C CXX)" >> CMakeLists.txt
    echo "" >> CMakeLists.txt

    echo "include(\"\${CMAKE_CURRENT_LIST_DIR}/${allArgs[2]}/cmake/FPrime.cmake\")" >> CMakeLists.txt
    echo "include(\"\${FPRIME_FRAMEWORK_PATH}/cmake/FPrime-Code.cmake\")" >> CMakeLists.txt
else
    echo "Error: Invalid argument. Please use either basic or complex."
    exit 1
fi