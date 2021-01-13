#!/bin/bash

# Alias'

# Space before so they are not added to history
if [[ $PLATFORM == 'Darwin' ]]; then
  alias ls=' ls -Fh'
  alias ll=' ls -lFh'
else
  alias ls=' ls -Fh --color=auto'
  alias ll=' ls -lFh --color=auto'
fi
alias l=' ll'
alias lA=' ll -A'
alias lln=' ls -lFAt | head' # sort after last modified

if [[ $PLATFORM != 'Darwin' ]]; then
  alias chmod='chmod -c' #-c like verbose but report only when a change is made
fi

alias cd-="cd -"
alias cd.='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd3='cd ../../..'
alias cd4='cd ../../../..'
alias cd5='cd ../../../../..'
alias cd6='cd ../../../../../..'

alias recall='history | grep'

alias open='exo-open'

# Vim / NeoVim
if [[ -L /bin/view ]]; then
  alias view="vim -R"
fi

if [[ -e /usr/bin/nvim ]]; then
  alias vim='nvim'
  alias vimdiff='nvim -d'
  alias view='nvim -R'
  if [[ -e ~/.local/bin/nvr ]]; then
    alias :e='nvr --remote-silent'
  fi
fi

alias df=" df"
alias view-="view -"

alias useradd="adduser"

if [[ -e /usr/bin/pacman ]]; then
  alias pup='sudo pacman -Syu'
  # https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Browsing_packages
  alias pacbrowse="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
fi

# Ack
if [[ -e '/usr/bin/ack' ]]; then
  alias ack="ack --follow"
fi
if [[ -e /usr/bin/ack-grep ]]; then
  alias ack="ack-grep --follow"
fi

# Ag, ignore .gitignore
if [[ -e '/usr/bin/ag' ]]; then
  alias au="ag --unrestricted"
fi

if [[ -e /usr/bin/python2 && -e /usr/lib/python2.7/SimpleHTTPServer.py ]]; then
  alias webshare='python2 -m SimpleHTTPServer'
fi

if [[ -e /usr/bin/python3 ]]; then
  alias webshare='python3 -m http.server'
fi


if [[ -e ~/.local/lib/ruby/gems/bin/jump-bin ]]; then
# jump ruby gem
# jump is a function that uses jump-bin
  alias j="jump"
  alias jl="jump -l"
  alias ja="jump -a"
  alias jd="jump -d"
fi

if [[ -e '/usr/bin/htop' ]]; then
  alias top="htop"
fi

alias dh1="du -h --max-depth=1"
