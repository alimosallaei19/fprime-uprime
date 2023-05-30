#!/bin/bash

sudo chmod +x uprime.sh
sudo cp uprime.sh /usr/bin/uprime

# check if uprime-functions directory exists
if [ ! -d "/usr/bin/uprime-functions" ]; then
    sudo mkdir /usr/bin/uprime-functions
fi

sudo cp uprime-functions/* /usr/bin/uprime-functions/