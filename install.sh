#!/bin/sh

set -e

INSTALLATION_PATH="$HOME/.config"
PROGRAM_DIR="analytx"
PROGRAM_PATH="$INSTALLATION_PATH/$PROGRAM_DIR"
CURRENT_DIR=$(pwd)

getRemoteRepository() {
    if [ -d "$PROGRAM_PATH" ]; then
        echo "Analytx is already installed. Checking updates..."
        cd "$PROGRAM_PATH" && git pull
        cd "$CURRENT_DIR" || return
    else
        echo "Cloning Analytx repository..."
        git clone https://github.com/ma-xlo/analytx "$PROGRAM_PATH"
    fi

}

giveFilePermission() {
    chmod +x "$PROGRAM_PATH/analytx"
}

isAnalytxAlreadyInPath() {
    if ! grep -q "$PROGRAM_PATH" "$HOME/.bashrc"; then
        echo "Adding Analytx to PATH..."
        echo "PATH=\$PATH:$PROGRAM_PATH" >> "$HOME/.bashrc"
        return 0
    fi
}

getRemoteRepository
giveFilePermission
isAnalytxAlreadyInPath

echo "Installation/update completed."
