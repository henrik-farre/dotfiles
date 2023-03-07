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

alias open='xdg-open'

# Vim / NeoVim
if [[ -L /bin/view ]]; then
  alias view="vim -R"
fi

if [[ -e /usr/bin/nvim ]]; then
  alias vim='nvim'
  alias vimdiff='nvim -d'
  alias view='nvim -R'
  if [[ -e /usr/bin/nvr ]]; then
    alias :e='nvr --remote-silent'
  fi
fi

alias df=" df"
alias view-="view -"

alias useradd="adduser"

##############################################################
# ArchLinux pacman/yay
#
if [[ -e /usr/bin/pacman ]]; then
  alias pup='sudo pacman -Syu'
  # https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Browsing_packages
  alias pacbrowse="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
fi

if [[ -e /usr/bin/yay ]]; then
  alias yay="sudo -u aur_builder yay "
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
# Inspired by https://gist.github.com/thebouv/8657674
# -s summerize
# -h human readable
# -x one file system
alias ducks="du -shx * | sort -hr | head"

if [[ -e /usr/bin/ugrep ]]; then
  alias uq='ug -Q'
  alias ux='ug -U --hexdump'
  alias uz='ug -z'
  alias ugit='ug --ignore-files'
  alias grep='ugrep -G'
  alias egrep='ugrep -E'
  alias fgrep='ugrep -F'
#  alias pgrep='ugrep -P'
  alias xgrep='ugrep -U --hexdump'
  alias zgrep='ugrep -zG'
  alias zegrep='ugrep -zE'
  alias zfgrep='ugrep -zF'
  alias zpgrep='ugrep -zP'
  alias zxgrep='ugrep -zU --hexdump'
  alias xdump='ugrep -X ""'
fi

alias kubectl="rancher kubectl"
alias rancher2="rancher"
