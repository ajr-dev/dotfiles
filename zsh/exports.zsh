# ==============================================================================
# Exports
# ==============================================================================
export REPORTTIME=10  # display how long all tasks over 10 seconds take
export KEYTIMEOUT=1   # 10ms delay for key sequences

function pathprepend() {
  for ((i=$#; i>0; i--)); 
  do
    ARG=${!i}
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
      PATH="$ARG${PATH:+":$PATH"}"
    fi
  done
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

pathprepend "/usr/local/opt/grep/libexec/gnubin"
pathprepend "/usr/local/bin"
pathprepend "/usr/local/sbin"
pathprepend "$DOTFILES/bin"
pathprepend "$HOME/.local/bin"  # For python packages installed with the '--user' option
pathprepend "$HOME/bin"
pathprepend "$HOME/.cargo/bin"
pathprepend "$HOME/Dropbox/bin"
pathprepend "$PYENV_ROOT/bin"
pathprepend "$GOPATH/bin"
pathprepend "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
pathprepend "$HOME/.rvm/bin"
pathprepend "$HOME/.rbenv/bin"
pathprepend "$ANDROID_HOME/platform_tools"
pathprepend "$ANDROID_HOME/tools"
pathprepend "$ANDROID_HOME/tools/bin"
pathprepend "$ANDROID_HOME/emulator"
pathprepend "/snap/bin"

if [[ "$(uname)" == "Linux" ]]; then
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
  export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
  export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew";
  pathprepend "$HOMEBREW_PREFIX/bin"
  pathprepend "$HOMEBREW_PREFIX/sbin"
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
