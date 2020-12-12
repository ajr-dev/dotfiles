# ==============================================================================
# Plugins
# ==============================================================================
export ZPLUG_HOME=$HOME/.zplug
#export ZPLUGDIR="$CACHEDIR/zsh/plugins"
#[[ -d "$ZPLUGDIR" ]] || mkdir -p "$ZPLUGDIR"

# Check if zplug is installed
if [[ ! -d $ZPLUG_HOME ]]; then
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
    source $ZPLUG_HOME/init.zsh && zplug update --self
else
    source $ZPLUG_HOME/init.zsh
fi

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "mafredri/zsh-async", from:"github", use:"async.zsh"
zplug "sindresorhus/pure", use:"pure.zsh", from:"github", as:"theme"
zplug "zsh-users/zsh-completions",              defer:0
zplug "zsh-users/zsh-autosuggestions",          defer:2, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting",      defer:3, on:"zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3, on:"zsh-users/zsh-syntax-highlighting"

# If an alias exists for a command you write, it prints the alias to remember it
zplug "djui/alias-tips"

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    zplug install
fi
