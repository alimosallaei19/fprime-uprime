#!/bin/bash

allArgs=("$@")

if [ ! -f ".gitmodules" ]; then
    echo "Error: This folder is not a git repo. Please run this script from the root directory of the project."
    exit 1
fi

# check if a .gitignore already exists

isGitignore=false

if [ -f ".gitignore" ]; then
    # ask user if they want to continue
    echo "A .gitignore already exists. Continuing will append to the current .gitignore. Continue? (y/n)"
    read response

    if [ "${response}" != "y" ]; then
        echo "Exiting..."
        exit 0
    fi

    isGitignore=true
fi

if [ "${isGitignore}" = false ]; then
    # create a .gitignore
    echo "Creating a .gitignore..."
    
    echo "# fprime items" > .gitignore
    echo "logs/" >> .gitignore
    echo "cmake-build-*" >> .gitignore
    echo "build-artifacts/" >> .gitignore
    echo "build-fprime-*" >> .gitignore
    echo "*-template" >> .gitignore
    echo " " >> .gitignore

    echo "# Misc" >> .gitignore
    echo "/venv/" >> .gitignore
    echo "/.vscode/" >> .gitignore
    echo "/.idea/" >> .gitignore
    echo "/.DS_Store" >> .gitignore
    echo "*.gcov" >> .gitignore
    echo "/bin/" >> .gitignore
else
    # append to the .gitignore
    echo "Appending to the .gitignore..."

    echo "# fprime items" >> .gitignore
    echo "logs/" >> .gitignore
    echo "cmake-build-*" >> .gitignore
    echo "build-artifacts/" >> .gitignore
    echo "build-fprime-*" >> .gitignore
    echo "*-template" >> .gitignore
    echo " " >> .gitignore

    echo "# Misc" >> .gitignore
    echo "/venv/" >> .gitignore
    echo "/.vscode/" >> .gitignore
    echo "/.idea/" >> .gitignore
    echo "/.DS_Store" >> .gitignore
    echo "*.gcov" >> .gitignore
    echo "/bin/" >> .gitignore
fi

git remote add source ${allArgs[1]}

if [ $? -eq 0 ]; then
    echo "Successfully added remote source."
else
    echo "Error: Could not add remote source."
    exit 1
fi

echo "Done."