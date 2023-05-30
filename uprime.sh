#!/bin/bash

option="${1}"

# Determine where to go based on command

case ${option} in
    --gds)
        echo "Opening GDS for `basename "${PWD}"`..."
        . $(dirname "$0")/uprime-functions/gds.sh
        ;;
    --toolchains)
        echo "Opening toolchains installation for `basename "${PWD}"`..."
        . $(dirname "$0")/uprime-functions/toolchains.sh
        ;;
    #else
    *)
        echo "Usage: uprime [option]"
        echo "Options:"
        echo "  --gds: Opens a GDS server given a *linux* cross compiled deployment. To be ran in the deployment folder."
        echo "  --toolchains: Installs cross-compilers for the arm64 architecture. To be ran in the root folder of the project."
        ;;
esac
