#!/bin/bash

if [ ! -d "Top" ]; then
    echo "Error: You're not currently in a deployment folder. Please cd to the deployment folder and run this command again."
    exit 1
fi

cd ./build-artifacts/${allArgs[2]}

if [ $? -ne 0 ]; then
    echo "Error: build-artifacts directory not found. You might need to run --cc-deploy first."
    exit 1
fi

# create a timestamp file

cd ../../

now=`date`
echo "$now" > MV-TIMESTAMP.txt

allArgs=("$@")
unset allArgs[0]

echo "Deleting old deployment..."
ssh ${allArgs[1]} "rm -rf `basename "${PWD}"`"

echo "Sending new deployment..."
scp -r build-artifacts/${allArgs[2]} ${allArgs[1]}:`basename "${PWD}"`

if [ $? -ne 0 ]; then
    echo "Error: scp failed. Please check your arguments and try again."
    exit 1
fi

rm -rf MV-TIMESTAMP.txt

echo "Done."