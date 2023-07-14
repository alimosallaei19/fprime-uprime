#!/bin/bash

# step -1: make sure all dependencies are installed
sudo apt install git cmake default-jre python3 python3-pip python3-venv

# step 0: get args. 2nd one should be git link
allArgs=("$@")

echo "Cloning ${allArgs[1]}..."

git clone ${allArgs[1]} --recursive # to get all submodules
cd `basename "${allArgs[1]}" .git` # go into the directory that was just created

echo "Initializing virtual environment..."

# create new virtual environment and activate it
python3 -m venv venv
source venv/bin/activate

echo "Installing fprime..."

# install fprime
pip install fprime-tools
pip install -r fprime/requirements.txt

echo "Generating a clean fprime build..."

# run a clean build of fprime
fprime-util generate
fprime-util build

echo "You should be all set! NOTE: Some errors may have occured above that the script did not catch. Please review them and fix them manually if necessary."