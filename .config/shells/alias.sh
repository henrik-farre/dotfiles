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

alias chmod='chmod -c' #-c like verbose but report only when a change is made

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
  if [[ -e ~/bin/nvimex.py ]]; then
    alias :e='nvimex.py e'
  fi
fi

alias df=" df -kHl"
alias view-="view -"

alias useradd="adduser"

if [[ -e /usr/bin/pacman ]]; then
  alias pup='sudo pacman -Syu'
fi

alias ack="ack --follow"
# Ack
if [[ -e /usr/bin/ack-grep ]]; then
  alias ack="ack-grep --follow"
fi

if [[ -e /usr/bin/python2 && -e /usr/lib/python2.7/SimpleHTTPServer.py ]]; then
  alias webshare='python2 -m SimpleHTTPServer'
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
