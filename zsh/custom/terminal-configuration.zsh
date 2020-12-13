# Disable control flow (ctrl-s / ctrl-q)
stty stop '' -ixoff -ixon

# The prompt string is subjected to parameter expansion,
# command substitution and arithmetic expansion
setopt prompt_subst

# If a command is issued that can’t be executed as a normal command,and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# Make cd push the old directory onto the directory stack
setopt auto_pushd

# Don’t push multiple copies of the same directory onto the directory stack
setopt pushd_ignore_dups    

# Exchanges the meanings of ‘+’ and ‘-’ when used with a number to specify a directory in the stack
setopt pushdminus

# Set spelling correction 
setopt correct

# Extended globbing. allows using regular expressions with *
setopt extended_glob

# Case insensitive globbing
setopt nocaseglob

# If unset, the cursor is set to the end of the word if completion is started
setopt complete_in_word

setopt no_beep

# Allow comments even in interactive shells.
setopt interactive_comments   

setopt list_packed

# Show completion menu on successive tab press
setopt auto_menu

# Prevents aliases on the command line from being internally substituted before completion is attempted
setopt complete_aliases

# Do not require a leading ‘.’ in a filename to be matched explicitly
setopt glob_dots

setopt magic_equal_subst

# Don't raise errors when regex nomatch fires 
unsetopt nomatch

# On a completion the cursor is moved to the end of the word
setopt always_to_end

setopt no_flow_control

setopt auto_list

setopt multios

# Do not autoselect the first completion entry
unsetopt menu_complete

setopt auto_cd

setopt multios

# Don't give less priority to background jobs
#setopt no_bg_nice

# Don't kill background jobs when the shell exits
setopt no_hup

#setopt no_list_beep

# Allow functions to have local options
#setopt local_options

# Allow functions to have local traps
#setopt local_traps

# Treat the '!' character specially during expansion
#setopt bang_hist

# =============================================================================
# History
# ==============================================================================

# Share history between all sessions
setopt share_history

# Delete old recorded entry if new entry is a duplicate
#setopt hist_ignore_all_dups

# Don't record an entry that was just recorded again
setopt hist_ignore_dups

# Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_expire_dups_first

# Don't record an entry starting with a space
# A useful trick to prevent particular entries from being recorded
# into the history by preceding them with a space
setopt hist_ignore_space

# Write to the history file immediately, not when the shell exits
#setopt inc_append_history

# If this is set, zsh sessions will append their history list to the history file, rather than replace it
setopt append_history

# Record timestamp of command in HISTFILE
setopt extended_history

# Remove superfluous blanks before recording entry
setopt hist_reduce_blanks

# While stepping through the history (with Ctrl+R) don't show duplicates
setopt hist_find_no_dups

# Don't write duplicate entries in the history file
#setopt hist_save_no_dups

# Show command with history expansion to user before running it
setopt hist_verify
