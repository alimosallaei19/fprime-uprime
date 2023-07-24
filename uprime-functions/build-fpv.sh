#!/bin/bash

# check if we're in a deployment folder
if [ ! -d "Top" ]; then
    echo "Error: You're not currently in a deployment folder. Please cd to the deployment folder and run this command again."
    exit 1
fi

# get name of current folder
currentFolder=`basename "${PWD}"`

topologyFile=./build-fprime-automatic-aarch64-linux/${currentFolder}/Top/${currentFolder}TopologyAppAi.xml

mkdir -p ../${currentFolder}-fpv

fpl-extract-xml -d ../${currentFolder}-fpv ${topologyFile}

# check if any errors
if [ $? -ne 0 ]; then
    echo "Error: fpl-layout failed. Please see above."
    exit 1
fi

cd ../${currentFolder}-fpv

# iterate through all xml files
for file in *.xml; do
    # remove the .xml extension
    filename="${file%.*}"

    # create a new folder for the fpv files
    fpl-convert-xml ${filename}.xml > ${filename}.txt

    # delete the file
    rm ${filename}.xml
done

# iterate through all txt files
for file in *.txt; do
    # remove the .txt extension
    filename="${file%.*}"

    # create the fpv files
    fpl-layout < ${filename}.txt > ${filename}.json

    # delete the file
    rm ${filename}.txt
done

# check if any errors
if [ $? -ne 0 ]; then
    echo "Error: fpl-layout failed. Please see above."
    exit 1
fi

echo "Done."