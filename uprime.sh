#!/bin/bash

option="${1}"

# Determine where to go based on command

case ${option} in
    -gds)
        echo "Opening GDS for `basename "${PWD}"`..."
        . $(dirname "$0")/gds.sh
        ;;
esac
