__GREP_CACHE_FILE="$ZSH_CACHE_DIR/grep-alias.zsh"

# See if there's a cache file modified in the last day
__GREP_ALIAS_CACHES=("$__GREP_CACHE_FILE"(Nm-1))
if [[ -n "$__GREP_ALIAS_CACHES" ]]; then
  source "$__GREP_CACHE_FILE"
else
  function grep-flags-available() {
    command grep "$@" "" &>/dev/null <<< ""
  }

    # Ignore these folders (if the necessary grep flags are available)
    EXC_FOLDERS="{.bzr,CVS,.git,.hg,.svn,.idea,.tox}"

    # Check for --exclude-dir, otherwise check for --exclude. If --exclude
    # isn't available, --color won't be either (they were released at the same
    # time (v2.5): https://git.savannah.gnu.org/cgit/grep.git/tree/NEWS?id=1236f007
    if grep-flags-available --color=auto --exclude-dir=.cvs; then
      GREP_OPTIONS="--color=auto --exclude-dir=$EXC_FOLDERS"
    elif grep-flags-available --color=auto --exclude=.cvs; then
      GREP_OPTIONS="--color=auto --exclude=$EXC_FOLDERS"
    fi

    if [[ -n "$GREP_OPTIONS" ]]; then
      # export grep, egrep and fgrep settings
      alias grep="grep $GREP_OPTIONS"
      alias egrep="egrep $GREP_OPTIONS"
      alias fgrep="fgrep $GREP_OPTIONS"
      alias sgrep="grep -R -n -H -C 5 $GREP_OPTIONS"
      alias hgrep="fc -El 0 | grep $GREP_OPTIONS"

        # write to cache file if cache directory is writable
        if [[ -w "$ZSH_CACHE_DIR" ]]; then
          alias -L grep egrep fgrep sgrep hgrep >| "$__GREP_CACHE_FILE"
          cat << EOF >> "$__GREP_CACHE_FILE"

# (r) Recursively search pattern, (i) ignore case, (I) ignore binary files,
# (n) prefix with line number within file, (s) suppress error messages.
# Use path or current directory
function grepr() {
  # Usage: grepr PATTERN [PATH...]
  grep -rIins $GREP_OPTIONS \$1 \${2:-.}
}
EOF
        fi
    fi

    # Clean up
    # unset GREP_OPTIONS is necessary to avoid warning message
    unset GREP_OPTIONS EXC_FOLDERS

    unfunction grep-flags-available
fi

unset __GREP_CACHE_FILE __GREP_ALIAS_CACHES
