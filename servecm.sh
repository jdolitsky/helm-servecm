#!/bin/bash -e

# Check if chartmuseum is installed
if ! command -v chartmuseum >/dev/null 2>&1; then

    # Prompt user if they want to auto-install
    echo -n "ChartMuseum not installed. Install latest stable release? (type \"yes\"): "
    read answer
    if [ "$answer" != "yes" ]; then
        echo "Please see https://github.com/kubernetes-helm/chartmuseum"
        echo "for installation instructions. Exiting."
        exit 1
    fi

    # Determine latest stable release
    version=$(curl -s https://s3.amazonaws.com/chartmuseum/release/stable.txt)
    echo "Attempting to install ChartMuseum server ($version)..."

    # Install binary to /usr/local/bin
    os="linux"
    if [ "$(uname)" == "Darwin" ]; then
        os="darwin"
    elif [ "$(expr substr $(uname -s) 1 5)" != "Linux" ]; then
        os="windows"
    fi
    echo "Detected your os as \"$os\""
    tmpdir="$(mktemp -d)"
    trap "rm -rf $tmpdir" EXIT
    pushd $tmpdir > /dev/null
    set -x
    curl -LO https://s3.amazonaws.com/chartmuseum/release/$version/bin/$os/amd64/chartmuseum
    chmod +x ./chartmuseum
    mv ./chartmuseum /usr/local/bin
    set +x
    popd > /dev/null
fi

# start the server
chartmuseum "$@"

