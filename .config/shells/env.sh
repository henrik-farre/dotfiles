#!/bin/bash

# Env's

############################################
# Use vim/nvim as pager, version 7.2 to 7.4
# Don't use vim as GIT_PAGER as colors for e.g. git ls are not shown
if [[ -f /usr/share/nvim/runtime/macros/less.sh ]]; then
  export PAGER="/usr/share/nvim/runtime/macros/less.sh"
  export MANPAGER="nvim '+set background=dark' '+set ft=man' -"
elif [[ -f /usr/share/vim/vim72/macros/less.sh ]]; then
  export PAGER="/usr/share/vim/vim72/macros/less.sh"
  export MANPAGER="sh -c \"col -b | /usr/share/vim/vim72/macros/less.sh -c 'set ft=man nomod nolist number!' -\""
elif [[ -f /usr/share/vim/vim73/macros/less.sh ]]; then
  export PAGER="/usr/share/vim/vim73/macros/less.sh"
  export MANPAGER="sh -c \"col -b | /usr/share/vim/vim73/macros/less.sh -c 'set ft=man nomod nolist number!' -\""
elif [[ -f /usr/share/vim/vim74/macros/less.sh ]]; then
  export PAGER="/usr/share/vim/vim74/macros/less.sh"
  export MANPAGER="sh -c \"col -b | /usr/share/vim/vim74/macros/less.sh -c 'set ft=man nomod nolist number!' -\""
fi

############################################
# Neovim
if [[ -z $XDG_RUNTIME_DIR ]]; then
  export NVIM_LISTEN_ADDRESS=/tmp/neovim_socket
else
  export NVIM_LISTEN_ADDRESS=$XDG_RUNTIME_DIR/neovim_socket
fi

if [[ -e /usr/bin/nvim ]]; then
  export EDITOR=/usr/bin/nvim
  export VISUAL=/usr/bin/nvim
else
  export EDITOR=/usr/bin/vim
  export VISUAL=/usr/bin/vim
fi

############################################
# SystemD / JournalD
# https://wiki.archlinux.org/index.php/Journalctl#Journal
# By omitting the S option, the output will be wrapped instead of truncated.
export SYSTEMD_LESS=FRXMK

############################################
# Path setup
if [[ -d ${HOME}/bin ]]; then
  PATH=${PATH}:${HOME}/bin
fi

# Check if gems module is installed
if which ruby &>/dev/null && which gem &>/dev/null; then
  PATH="${PATH}:$(ruby -rubygems -e 'puts Gem.user_dir')/bin"
fi

if [[ -d ${HOME}/.local/nodejs/bin ]]; then
  PATH=${PATH}:${HOME}/.local/nodejs/bin
fi

if [[ -d ${HOME}/.config/composer/vendor/bin ]]; then
  PATH=${PATH}:${HOME}/.config/composer/vendor/bin
fi

if [[ -d ${HOME}/Dev/docker/bin ]]; then
  PATH=${PATH}:${HOME}/Dev/docker/bin
fi

# Packages installed by pip and others
if [[ -d ${HOME}/.local/bin ]]; then
  PATH=${PATH}:${HOME}/.local/bin
fi

export PATH

############################################
# Ruby gem installation path
# Replaced by ~/.gem
# export GEM_HOME=~/.local/lib/ruby/gems
export GEM_SPEC_CACHE=~/.cache/ruby/specs

export SDL_AUDIODRIVER="alsa"

# History options, TODO: bash vs zsh?
export HISTFILESIZE=5000
export HISTIGNORE=ls:l:ll:mc:cd:..
export HISTCONTROL=ignoreboth:erasedups

if [[ ${SHELL_IS} == "bash" ]]; then
  export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
fi

############################################
# Ensure a11y is disabled (to avoid "Couldn't connect to accessibility bus" errors)
# Cinnamon unsets env so it can't be in /etc/profile.d/
export NO_AT_BRIDGE=1

############################################
# Node.js
# https://github.com/npm/npm/issues/5392
export NPM_CONFIG_PREFIX=~/.local/nodejs

# Wrapper script to use multiple Firefox profiles
export BROWSER=open-link

# Coreutils quotes ls output
export QUOTING_STYLE=literal

############################################
# GO
if [[ -d ~/Dev/go ]]; then
  export GOPATH=~/Dev/go
fi

############################################
# Python
if [[ -d ~/.local/lib/python2.7 ]]; then
  export PYTHONPATH=~/.local/lib/python2.7
fi

############################################
# Wine
# Prevent wine from creating filetype associations: https://wiki.archlinux.org/index.php/Wine#Unregister_existing_Wine_file_associations
if [[ -e /usr/bin/wine ]]; then
  export WINEDLLOVERRIDES="winemenubuilder.exe=d"
fi
