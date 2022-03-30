#!/bin/bash

sudo cp --force .devcontainer/welcome-message.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt
script/setup

script_folder="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
workspaces_folder="$(cd "${script_folder}/.." && pwd)"

cd "${workspaces_folder}"
if [ ! -d "$1" ]; then
    git clone "https://github.com/primer/css"
else
    echo "Already cloned $1"
fi
