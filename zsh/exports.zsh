# ==============================================================================
# Exports
# ==============================================================================
# Oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$MYZSH/custom"
# export ZSH_CACHE_DIR="$CACHEDIR/.zsh/cache"

export REPORTTIME=10  # display how long all tasks over 10 seconds take
export KEYTIMEOUT=1   # 10ms delay for key sequences

function add_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH=(
            $1
            $PATH
        )
    fi
}

fpath=(
    $ZSH_CUSTOM/functions
    $ZSH_CUSTOM/completions
    /usr/local/share/zsh/site-functions
    $fpath
)

typeset -aU path

if [ -d $ZSH_CUSTOM/functions ]; then
  for func in $ZSH_CUSTOM/functions/*(:t); autoload -U $func
fi

add_path "/usr/local/opt/grep/libexec/gnubin"
add_path "/usr/local/bin"
add_path "/usr/local/sbin"
add_path "$DOTFILES/bin"
# For python packages installed with the '--user' option
add_path "$HOME/.local/bin"
add_path "$HOME/bin"
add_path "$HOME/.cargo/bin"
add_path "$HOME/Dropbox/bin"
add_path "$PYENV_ROOT/bin"
add_path "$GOPATH/bin"
add_path "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
add_path "$HOME/.rvm/bin"
add_path "$HOME/.rbenv/bin"
add_path "$ANDROID_HOME/platform_tools"
add_path "$ANDROID_HOME/tools"
add_path "$ANDROID_HOME/tools/bin"
add_path "$ANDROID_HOME/emulator"
add_path "/snap/bin"

if [[ "$(uname)" == "Linux" ]]; then
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
    export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew";
    add_path "$HOMEBREW_PREFIX/bin"
    add_path "$HOMEBREW_PREFIX/sbin"
    export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH}";
fi

# WSL needs this
if  grep -q Microsoft /proc/version;  then
    export DISPLAY=:0
fi

# This is where my code exists and where I want
# the `c` autocomplete to work from exclusively
if [[ -d ~/code ]]; then
    export CODE_DIR=~/code
fi
if [[ -d ~/Dropbox/code ]]; then
    export CODE_DIR=~/Dropbox/code
fi
