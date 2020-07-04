if ! (( $+commands[tmux] )); then
    print "zsh tmux plugin: tmux not found. Please install tmux before using this plugin." >&2
    return 1
fi

# ALIASES

# TODO: improve tla to list all aliases of tmux shortcuts
alias tla="grep -E '(=)' $MY_ZSH/tmux.zsh | less"  # list formatted aliases and descriptions
alias tls='tmux list-sessions'                  # list tmux sessions
alias ta='tmux attach'                          # attach to the first session
alias tat='tmux attach -t' #<mysession>         # attach to session with given name <mysession>
alias tad='tmux attach -d -t'
alias tns='tmux new-session -s' #<mysession>    # start new session with given name <mysession>
alias tk='tmux kill-session'                    # kill first session listed
alias tkt='tmux kill-session -t' #<mysession>   # kill session with given name <mysession>
alias tks='tmux kill-server'                    # kill all sessions
#alias tkl='tmux ls | grep : | cut -d. -f1 | awk '\"{print substr($1, 0, length($1)-1)}'\" | xargs kill'

# Use different terminfo to have italics on tmux
if [ -z "$TMUX" ]; then
    export TERM=xterm-256color-italic
else
    export TERM=tmux-256color
fi

# CONFIGURATION VARIABLES
# Automatically start tmux
: ${ZSH_TMUX_AUTOSTART:=true}
# Only autostart once. If set to false, tmux will attempt to
# autostart every time your zsh configs are reloaded
: ${ZSH_TMUX_AUTOSTART_ONCE:=true}
# Automatically connect to a previous session if it exists
: ${ZSH_TMUX_AUTOCONNECT:=true}
# Automatically close the terminal when tmux exits
: ${ZSH_TMUX_AUTOQUIT:=$ZSH_TMUX_AUTOSTART}
# Set term to screen or screen-256color based on current terminal support
: ${ZSH_TMUX_FIXTERM:=false}
# Set '-CC' option for iTerm2 tmux integration
: ${ZSH_TMUX_ITERM2:=false}
# The TERM to use for non-256 color terminals
# Tmux states this should be screen, but you may need to change it on
# systems without the proper terminfo
: ${ZSH_TMUX_FIXTERM_WITHOUT_256COLOR:=screen}
# The TERM to use for 256 color terminals.
# Tmux states this should be screen-256color, but you may need to change it on
# systems without the proper terminfo
: ${ZSH_TMUX_FIXTERM_WITH_256COLOR:=screen-256color}
# Set the configuration path
: ${ZSH_TMUX_CONFIG:=$HOME/.tmux.conf}
# Set -u option to support unicode
: ${ZSH_TMUX_UNICODE:=false}

# Determine if the terminal supports 256 colors
if [[ $terminfo[colors] == 256 ]]; then
    export ZSH_TMUX_TERM=$ZSH_TMUX_FIXTERM_WITH_256COLOR
else
    export ZSH_TMUX_TERM=$ZSH_TMUX_FIXTERM_WITHOUT_256COLOR
fi

# Set the correct local config file to use
if [[ "$ZSH_TMUX_ITERM2" == "false" && -e "$ZSH_TMUX_CONFIG" ]]; then
    export ZSH_TMUX_CONFIG
    export _ZSH_TMUX_FIXED_CONFIG="${0:h:a}/tmux.extra.conf"
else
    export _ZSH_TMUX_FIXED_CONFIG="${0:h:a}/tmux.only.conf"
fi

# Wrapper function for tmux
function _zsh_tmux_plugin_run() {
    if [[ -n "$@" ]]; then
        command tmux "$@"
        return $?
    fi

    local -a tmux_cmd
    tmux_cmd=(command tmux)
    [[ "$ZSH_TMUX_ITERM2" == "true" ]] && tmux_cmd+=(-CC)
    [[ "$ZSH_TMUX_UNICODE" == "true" ]] && tmux_cmd+=(-u)

  # Try to connect to an existing session
  [[ "$ZSH_TMUX_AUTOCONNECT" == "true" ]] && $tmux_cmd attach

  # If failed, just run tmux, fixing the TERM variable if requested
  if [[ $? -ne 0 ]]; then
      if [[ "$ZSH_TMUX_FIXTERM" == "true" ]]; then
          tmux_cmd+=(-f "$_ZSH_TMUX_FIXED_CONFIG")
      elif [[ -e "$ZSH_TMUX_CONFIG" ]]; then
          tmux_cmd+=(-f "$ZSH_TMUX_CONFIG")
      fi
      $tmux_cmd new-session
  fi

  if [[ "$ZSH_TMUX_AUTOQUIT" == "true" ]]; then
      exit
  fi
}

# Use the completions for tmux for our function
compdef _tmux _zsh_tmux_plugin_run
# Alias tmux to our wrapper function
alias tmux=_zsh_tmux_plugin_run

# Autostart if not already in tmux and enabled
if [[ -z "$TMUX" && "$ZSH_TMUX_AUTOSTART" == "true" && -z "$INSIDE_EMACS" && -z "$EMACS" && -z "$VIM" ]]; then
    # Actually don't autostart if we already did and multiple autostarts are disabled
    if [[ "$ZSH_TMUX_AUTOSTART_ONCE" == "false" || "$ZSH_TMUX_AUTOSTARTED" != "true" ]]; then
        export ZSH_TMUX_AUTOSTARTED=true
        _zsh_tmux_plugin_run
    fi
fi
