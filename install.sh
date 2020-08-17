#!/usr/bin/env bash

function command_exists() {
    type "$1" > /dev/null 2>&1
}

if ! command_exists git; then
    read -rp "Install git"
fi

DOTFILES=$HOME/.dotfiles
if [ ! -d "$DOTFILES" ]; then
    git clone https://github.com/ajr-dev/post-install-script "$DOTFILES"
fi
echo "Installing dotfiles."
cd "$DOTFILES/install" || exit

source "$DOTFILES/install/install.sh"
