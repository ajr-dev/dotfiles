#!/usr/bin/env bash

function command_exists() {
    type "$1" > /dev/null 2>&1
}

if ! command_exists git; then
    read -rp "Install git"
fi

DOTFILES=$HOME/.dotfiles
INSTALL=$DOTFILES/install
if [ ! -d "$DOTFILES" ]; then
    git clone https://github.com/ajr-dev/dotfiles "$DOTFILES"
fi
echo "Installing dotfiles."

cd "$DOTFILES" || exit
source "$INSTALL/link.sh"
source "$INSTALL/git.sh"

if ! command_exists brew; then
    echo -e "\\n\\nInstalling homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    # Add Homebrew to your PATH
    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

    # install brew dependencies from Brewfile
    BASEDIR=$(dirname "$0")
    cd "$BASEDIR" || { echo "Directory $BASEDIR not found" ; exit 1; }
    echo "Installing brew dependencies from Brewfile"
    brew bundle
    cd - || { echo "Couldn't go back to the previous directory" ; exit 1; }

    echo -e "\\n\\nInstalling Neovim support for Python libraries"
    echo "=============================="
    pip3 install pynvim
fi

# After the install, setup fzf
echo -e "\\n\\nRunning fzf install script..."
echo "=============================="
if [ -d /usr/local/homebrew ]; then
    echo -e "\\n\\nRunning on macOS"
    HOMEBREW_PREFIX="/usr/local"
elif [ -d /home/linuxbrew/.linuxbrew ]; then
    HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
elif [ -d /home/linuxbrew/.linuxbrew ]; then
    HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi
$HOMEBREW_PREFIX/opt/fzf/install --all --no-bash --no-fish

# perform macOS-specific install
if [ "$(uname)" == "Darwin" ]; then
    echo -e "\\n\\nRunning on macOS"
    source "$INSTALL/osx.sh"
fi

if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
fi

nvim +PlugInstall +qall
tic -x resources/xterm-256color-italic.terminfo
tic -x resources/tmux.terminfo
zsh_path="$( command -v zsh )"
if ! grep "$zsh_path" /etc/shells; then
    echo -e "\\n\\nChanging default shell to zsh"
    echo "adding $zsh_path to /etc/shells"
    echo "$zsh_path" | sudo tee -a /etc/shells
fi

if ! [[ $SHELL =~ .*zsh.* ]]; then
    chsh -s "$zsh_path"
    echo "default shell changed to $zsh_path"

    zsh # Reload terminal
fi
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
read -rp "You still have to install the tmux plugins with <Prefix>+I"
if ! command_exists xclip; then
    read -rp "You still have to install xclip to be able to copy to clipboard in nvim and tmux"
fi
