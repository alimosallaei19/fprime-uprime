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
    --ports)
        echo "Executing ports enabler for ports specified..."
        . $(dirname "$0")/uprime-functions/ports.sh $@
        ;;
    --cc-build-env)
        echo "Executing cross-compiler environment builder..."
        . $(dirname "$0")/uprime-functions/cc-build-env.sh
        ;;
    --cc-deploy)
        echo "Executing cross-compiler deployment builder..."
        . $(dirname "$0")/uprime-functions/cc-deploy.sh
        ;;
    --mv)
        echo "Executing move to remote node script..."
        . $(dirname "$0")/uprime-functions/mv.sh $@
        ;;
    --git-init)
        echo "Executing git init script..."
        . $(dirname "$0")/uprime-functions/git-init.sh $@
        ;;
    --cmake-lists)
        echo "Executing cmake lists script..."
        . $(dirname "$0")/uprime-functions/cmake-lists.sh $@
        ;;
    --replace-impls)
        echo "Executing replace impls script..."
        . $(dirname "$0")/uprime-functions/replace-impls.sh $@
        ;;
    --build-fpv)
        echo "Executing build fpv script..."
        . $(dirname "$0")/uprime-functions/build-fpv.sh $@
        ;;
    --cmd-descs)
        echo "Executing command descriptions script..."
        . $(dirname "$0")/uprime-functions/cmd-descs.sh $@
        ;;
    --dev-env)
        echo "Executing dev env script..."
        . $(dirname "$0")/uprime-functions/dev-env.sh $@
        ;;
    *)
        echo "Usage: uprime [option]"
        echo "Options:"
        echo "  --gds: Opens a GDS server given a *linux* cross compiled deployment. To be ran in the deployment folder."
        echo "  --toolchains: Installs cross-compilers for the arm64 architecture. To be ran in the root folder of the project."
        echo "  --ports: Enables/removes ports for the deployment. To be ran in the root folder of the project. Can take multiple arguments for ports."
        echo "  --cc-build-env: Builds a cross-compiler environment for the arm64 architecture. To be ran anywhere."
        echo "  --cc-deploy: Compiles the current deployment to Linux arm64. To be ran in the deployment folder."
        echo "  --mv: Moves the current deployment's build to a remote node. To be ran in the deployment > build-artifacts folder."
        echo "  --git-init: Initializes a .gitignore and remote source for the project. To be ran in the root folder of the project."
        echo "  --cmake-lists: Initializes a CMakeLists.txt for the project. To be ran in any directory where a CMakeLists.txt is wanted."
        echo "  --replace-impls: Replaces all standard .cpp and .hpp files with their implementations. To be ran in a component directory."
        echo "  --build-fpv: Builds the .json files needed for FPV."
        echo "  --cmd-descs: Builds the command descriptions for the project. See README."
        echo "  --dev-env: Builds the development environment for the project. Run in parent of project folder."
        ;;
esac
