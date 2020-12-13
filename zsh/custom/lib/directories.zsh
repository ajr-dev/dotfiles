# Changing/making/removing directory
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'  # alias '-' to 'cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir
alias cpr='cp -r'
alias rmf='rm -rf'
alias dk='cd ~/Desktop'
alias dl='cd ~/Downloads'

# Create and change directory https://bit.ly/3oHapk4
function mkcd()
{
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

function d() {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -10
  fi
}
compdef _dirs d  # add zsh autocompletion for the function
