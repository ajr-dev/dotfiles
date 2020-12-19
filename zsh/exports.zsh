# ==============================================================================
# Exports
# ==============================================================================
export REPORTTIME=10  # display how long all tasks over 10 seconds take
export KEYTIMEOUT=1   # 10ms delay for key sequences

function pathadd() {
if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
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

pathadd "/usr/local/opt/grep/libexec/gnubin"
pathadd "/usr/local/bin"
pathadd "/usr/local/sbin"
pathadd "$DOTFILES/bin"
pathadd "$HOME/.local/bin"  # For python packages installed with the '--user' option
pathadd "$HOME/bin"
pathadd "$HOME/.cargo/bin"
pathadd "$HOME/Dropbox/bin"
pathadd "$PYENV_ROOT/bin"
pathadd "$GOPATH/bin"
pathadd "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
pathadd "$HOME/.rvm/bin"
pathadd "$HOME/.rbenv/bin"
pathadd "$ANDROID_HOME/platform_tools"
pathadd "$ANDROID_HOME/tools"
pathadd "$ANDROID_HOME/tools/bin"
pathadd "$ANDROID_HOME/emulator"
pathadd "/snap/bin"

if [[ "$(uname)" == "Linux" ]]; then
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
  export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
  export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew";
  pathadd "$HOMEBREW_PREFIX/bin"
  pathadd "$HOMEBREW_PREFIX/sbin"
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
