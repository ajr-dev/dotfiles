# MINE =========================================================================
# add color to man pages
#export MANROFFOPT='-c'
#export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
#export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
#export LESS_TERMCAP_me=$(tput sgr0)
#export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
#export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
#export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
#export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
#export LESS_TERMCAP_mr=$(tput rev)
#export LESS_TERMCAP_mh=$(tput dim)#
# MINE =========================================================================

# Requires colors autoload.
# See termcap(5).

# Set up once, and then reuse. This way it supports user overrides after the
# plugin is loaded.
typeset -AHg less_termcap

# bold & blinking mode
less_termcap[mb]="${fg_bold[red]}"
less_termcap[md]="${fg_bold[red]}"
less_termcap[me]="${reset_color}"
# standout mode
less_termcap[so]="${fg_bold[yellow]}${bg[blue]}"
less_termcap[se]="${reset_color}"
# underlining
less_termcap[us]="${fg_bold[green]}"
less_termcap[ue]="${reset_color}"

# Absolute path to this file's directory.
typeset __colored_man_pages_dir="${0:A:h}"

function colored() {
  local -a environment

  # Convert associative array to plain array of NAME=VALUE items.
  local k v
  for k v in "${(@kv)less_termcap}"; do
    environment+=( "LESS_TERMCAP_${k}=${v}" )
  done

  # Prefer `less` whenever available, since we specifically configured
  # environment for it.
  environment+=( PAGER="${commands[less]:-$PAGER}" )

  # See ./nroff script.
  if [[ "$OSTYPE" = solaris* ]]; then
    environment+=( PATH="${__colored_man_pages_dir}:$PATH" )
  fi

  command env $environment "$@"
}

# Colorize man and dman/debman (from debian-goodies)
function man \
  dman \
  debman {
  colored $0 "$@"
}
