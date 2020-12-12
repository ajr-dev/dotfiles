#MINE ================================================================
#setopt correct                   # set spelling correction
#unsetopt nomatch                 # don't raise errors when regex nomatch fires
## setopt NO_BG_NICE              # don't give less priority to background jobs
#setopt NO_HUP                    # don't kill background jobs when the shell exits
#setopt NO_LIST_BEEP
#setopt LOCAL_OPTIONS             # allow functions to have local options
#setopt LOCAL_TRAPS               # allow functions to have local traps
#setopt PROMPT_SUBST
#
#setopt BANG_HIST                 # treat the '!' character specially during expansion
#setopt EXTENDED_HISTORY          # write the history file in the format ‘: <beginning time>:<elapsed seconds>;<command>’
#setopt INC_APPEND_HISTORY        # write to the history file immediately, not when the shell exits
#setopt SHARE_HISTORY             # share history between all sessions
#setopt HIST_EXPIRE_DUPS_FIRST    # expire duplicate entries first when trimming history
#setopt HIST_IGNORE_DUPS          # don't record an entry that was just recorded again
#setopt HIST_IGNORE_ALL_DUPS      # delete old recorded entry if new entry is a duplicate
#setopt HIST_SAVE_NO_DUPS         # don't write duplicate entries in the history file
#setopt HIST_FIND_NO_DUPS         # while stepping through the history (with Ctrl+R) don't show duplicates
#setopt HIST_REDUCE_BLANKS        # remove superfluous blanks before recording entry
#setopt HIST_VERIFY               # don't execute immediately upon history expansion
## A useful trick to prevent particular entries from being recorded into a history by preceding them with at least one space
#setopt HIST_IGNORE_SPACE         # don't record an entry starting with a space
#
#setopt COMPLETE_ALIASES
#MINE ================================================================

## History wrapper
function omz_history {
  local clear list
  zparseopts -E c=clear l=list

  if [[ -n "$clear" ]]; then
    # if -c provided, clobber the history file
    echo -n >| "$HISTFILE"
    fc -p "$HISTFILE"
    echo >&2 History file deleted.
  elif [[ -n "$list" ]]; then
    # if -l provided, run as if calling `fc' directly
    builtin fc "$@"
  else
    # unless a number is provided, show all history events (starting from 1)
    [[ ${@[-1]-} = *[0-9]* ]] && builtin fc -l "$@" || builtin fc -l "$@" 1
  fi
}

# Timestamp format
case ${HIST_STAMPS-} in
  "mm/dd/yyyy") alias history='omz_history -f' ;;
  "dd.mm.yyyy") alias history='omz_history -E' ;;
  "yyyy-mm-dd") alias history='omz_history -i' ;;
  "") alias history='omz_history' ;;
  *) alias history="omz_history -t '$HIST_STAMPS'" ;;
esac

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 9223372036854775807 ] && HISTSIZE=9223372036854775807
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
