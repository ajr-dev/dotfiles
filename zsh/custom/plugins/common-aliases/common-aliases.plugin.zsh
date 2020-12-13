# ------------------------------------------
# List aliases
# ------------------------------------------

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # macOS `ls`
    colorflag="-G"
fi
alias l="ls -CF ${colorflag}"        # list by column,show type
alias lsa="ls -lah ${colorflag}"     # long list,hidden files,size human readable
alias la="ls -lAFh ${colorflag}"     # long list,almost all,show type,size human readable
alias ll="ls -lFh ${colorflag}"      # long list,show type,show type,size human readable
alias lr="ls -tRFh ${colorflag}"     # sorted by date,recursive,show type,human readable
alias lt="ls -ltFh ${colorflag}"     # long list,sorted by date,show type,human readable
alias lld="ls -l ${colorflag} | grep ^d"  # long list only directories
alias ldot="ls -ld .* ${colorflag}"  # long list dotfiles
alias lS="ls -1FSsh ${colorflag}"    # list,show only size and name,sorted by size
alias lart="ls -1Fcart ${colorflag}" # list,sorted oldest modification first
alias lrt="ls -1Fcrt ${colorflag}"   # list,sorted in reverse of create/modification time(oldest first)

alias ell='exa -l --color=always --group-directories-first'   # long format
alias elt='exa -aT --color=always --group-directories-first'  # tree listing

# ------------------------------------------
# Command line head / tail shortcuts
# ------------------------------------------
alias t='tail -f' # shorthand for tail which outputs the last part of a file
alias -g H='| head'  # pipes output to head which outputs the first part of a file
alias -g T='| tail'  # pipes output to tail which outputs the last part of a file
alias -g G='| grep'  # pipes output to grep to search for some word
alias -g L='| less'  # pipes output to less, useful for paging
alias -g M='| most'  # pipes output to more, useful for paging
alias -g LL='2>&1 | less'  # writes stderr to stdout and passes it to less
alias -g CA='2>&1 | cat -A'  # writes stderr to stdout and passes it to cat
alias -g NE='2> /dev/null'  # silences stderr
alias -g NUL='> /dev/null 2>&1'  # silences both stdout and stderr
alias -g P='2>&1| pygmentize -l pytb'  # writes stderr to stdout and passes it to pygmentize

# ------------------------------------------
# Helpers
# ------------------------------------------
alias c='clear'
alias cl='clear'
alias cls='clear'
alias q='exit'
alias :q='exit'
alias h='history'
alias m='make'
alias hh='hstr'
alias tf='terraform'
alias df='df -h'  # disk free, in human readable form (Gigabytes, not bytes)
alias du='du -h -c'  # calculate disk usage for a folder
alias dud='du -d 1 -h'  # display the size of files at depth 1 in current location in human-readable form
alias duf='du -sh *'  # display the size of files in current location in human-readable form
alias topdu='du -a | sort -nr | head -50'
alias fsize='du -s'
alias sudo='sudo '
alias please='sudo '
alias lpath='echo $PATH | tr ":" "\n"'  # list the PATH separated by new lines

alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'
alias o='xdg-open'
alias open='xdg-open'
alias weather='curl wttr.in'
# Do something and receive a desktop alert when it completes `sudo apt-get install something | alert`
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias dot="cd $HOME/$DOTFILES"
alias home='cd ~'

# Quick access to the .zshrc file
alias ez='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc'
alias zshconfig='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc'
alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc'
alias ev="$EDITOR $MYVIMRC"  # edit vimrc
alias et="$EDITOR $MYTMUX"  # edit tmux.conf

# Reload zsh configuration
function reload() {
    zsh -f
    source ~/.zshrc
}
alias sz=reload

(( $+commands[fd] )) || alias fd='find . -type d -name'  # find a directory with the given name
alias ff='find . -type f -name'  # find a file with the given name

alias sortnr='sort -n -r' # sort the lines of a text file
alias unexport='unset'  # unset an environment variable
alias j='jobs -l'
alias p='ps -f'  # display currently executing processes
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# ------------------------------------------
#  APT
# ------------------------------------------
alias autoremove='sudo apt autoremove'
alias dist-upgrade='sudo apt full-upgrade'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias up='sudo apt update && sudo apt upgrade -y'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias unlock='sudo rm /var/lib/pacman/db.lck'

# ------------------------------------------
# Services
# ------------------------------------------
alias ss='sudo service'
alias ssmysql='sudo service mysql start'
alias sspgsql='sudo service postgresql start'
alias ssredis='sudo service redis-server start'
alias sselastic='sudo service elasticsearch start'

# ------------------------------------------
# Applications
# ------------------------------------------
alias d='docker'
alias lg='lazygit'
alias top='htop'
alias e="$EDITOR"
alias v="$EDITOR"
alias vi='nvim'
alias vdiff='nvim -d'
alias vimdiff='nvim -d'
alias py='python3'
alias help='man'
alias nr='npm run'
alias ni='npm i'
alias np='nano -w PKGBUILD'
alias msql='mysql -uroot -p'
alias norminette='~/.norminette/norminette.rb'
# npm install -g http-server
alias ws='http-server -c-1 -p 3333 -o'
alias g11='g++ -std=c++11'
alias ya='yarn add'
alias yt='yarn test'
alias ys='yarn start'

# ------------------------------------------
# Language specific
# ------------------------------------------
alias rb='ruby'
alias js='node'
alias composer='php /usr/local/bin/composer.phar'
alias dcu='docker-compose up'

# ------------------------------------------
# Other
# ------------------------------------------

# Applications
alias ios='open -a /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias showdesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"
# Remove broken symlinks
alias clsym="find -L . -name . -o -type d -prune -o -type l -exec rm {} +"

autoload -Uz is-at-least
if is-at-least 4.2.0; then
  # Open urls in terminal using browser specified by the variable $BROWSER
  if [[ -n "$BROWSER" ]]; then
    _browser_fts=(htm html de org net com at cx nl se dk)
    for ft in $_browser_fts; do alias -s $ft='$BROWSER'; done
  fi

  # Open C, C++, Tex and text files using editor specified by the variable $EDITOR
  _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
  for ft in $_editor_fts; do alias -s $ft='$EDITOR'; done

  # Open images using image viewer specified by the variable $XIVIEWER
  if [[ -n "$XIVIEWER" ]]; then
    _image_fts=(jpg jpeg png gif mng tiff tif xpm)
    for ft in $_image_fts; do alias -s $ft='$XIVIEWER'; done
  fi

  # Open videos and other media using mplayer
  _media_fts=(ape avi flv m4a mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
  for ft in $_media_fts; do alias -s $ft=mplayer; done

  # Read documents
  alias -s pdf=acroread  # open up a document using acroread
  alias -s ps=gv         # open up a .ps file using gv
  alias -s dvi=xdvi      # open up a .dvi file using xdvi
  alias -s chm=xchm      # open up a .chm file using xchm
  alias -s djvu=djview   # open up a .djvu file using djview

  #list whats inside packed file
  alias -s zip='unzip -l'  # list files inside a .zip file
  alias -s rar='unrar l'   # list files inside a .rar file
  alias -s tar='tar tf'    # list files inside a .tar file
  alias -s tar.gz='echo '  # list files inside a .tar.gz file
  alias -s ace='unace l'   # list files inside a .ace file
fi


# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
