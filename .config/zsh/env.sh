#!/bin/bash

# Env's

############################################
# Use vim/nvim as pager, version 7.2 to 7.4
# Don't use vim as GIT_PAGER as colors for e.g. git ls are not shown
#
if [[ "$(command -v nvim)" ]]; then
  export PAGER="/usr/share/nvim/runtime/macros/less.sh"
  # From :help man.vim
  export MANPAGER='nvim +Man!'
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
#
if [[ -z $XDG_RUNTIME_DIR ]]; then
  export NVIM_LISTEN_ADDRESS=/tmp/neovim_socket
else
  export NVIM_LISTEN_ADDRESS=$XDG_RUNTIME_DIR/neovim_socket
fi

if [[ -e /usr/bin/nvim ]]; then
  export VISUAL=/usr/bin/nvim
  export EDITOR=/usr/bin/nvim

  if [[ -e /usr/bin/nvr ]]; then
    # Note that zsh escapes spaces, this might break things
    export EDITOR="nvr --remote-wait-silent"
    export VISUAL="nvr --remote-wait-silent"
  fi
else
  export EDITOR=/usr/bin/vim
  export VISUAL=/usr/bin/vim
fi

############################################
# Bat
#
if [[ -e /usr/sbin/bat ]]; then
  export BAT_PAGER="less -RF"
  export PAGER=$BAT_PAGER
  export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
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
# TODO: ruby 2.5
# if which ruby-2.4 &>/dev/null && which gem-2.4 &>/dev/null; then
#   PATH="${PATH}:$(ruby-2.4 -rubygems -e 'puts Gem.user_dir')/bin"
# fi

# NodeJS
if [[ -d ${HOME}/.local/nodejs/bin ]]; then
  PATH=${PATH}:${HOME}/.local/nodejs/bin
fi
# NVM - node version manager
if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
  source /usr/share/nvm/init-nvm.sh
fi

# Packages installed by pip and others
if [[ -d ${HOME}/.local/bin ]]; then
  PATH=${PATH}:${HOME}/.local/bin
fi

# Pip packages on MacOS
# if [[ -d /Users/hfar/Library/Python/3.7/bin/ ]]; then
#   PATH=${PATH}:/Users/hfar/Library/Python/3.7/bin/
# fi

if [[ $PLATFORM == 'Darwin' ]]; then
  PATH=${PATH}:/usr/local/sbin
fi

# krew - kubectl plugin manager
if [[ -d ${HOME}/.krew/bin ]]; then
  PATH=${PATH}:${HOME}/.krew/bin
fi

export PATH

############################################
# Ruby gem installation path
# Replaced by ~/.gem
# export GEM_HOME=~/.local/lib/ruby/gems
export GEM_SPEC_CACHE=~/.cache/ruby/specs

############################################
# SDL settings
# export SDL_AUDIODRIVER="alsa"

############################################
# Ensure a11y is disabled (to avoid "Couldn't connect to accessibility bus" errors)
# Cinnamon unsets env so it can't be in /etc/profile.d/
export NO_AT_BRIDGE=1

############################################
# Node.js
# https://github.com/npm/npm/issues/5392
# Breaks nvm
# export NPM_CONFIG_PREFIX=~/.local/nodejs

# Wrapper script to use multiple Firefox profiles
# export BROWSER=open-link

# Coreutils quotes ls output
export QUOTING_STYLE=literal

############################################
# GO
#if [[ -d ~/Dev/go ]]; then
#  export GOPATH=~/Dev/go
#fi

############################################
# Python
# if [[ -d ~/.local/lib/python2.7 ]]; then
#   export PYTHONPATH=${PYTHONPATH}:~/.local/lib/python2.7
# fi
#
# if [[ -d ~/.local/lib/python3.8 ]]; then
#   export PYTHONPATH=${PYTHONPATH}:~/.local/lib/python3.8
# fi
#
# # MacOS
# if [[ -d ~/Library/Python/3.7/lib/python/site-packages ]]; then
#   export PYTHONPATH=${PYTHONPATH}:~/Library/Python/3.7/lib/python/site-packages
# fi
# if [[ -d ~/Library/Python/2.7/lib/python/site-packages ]]; then
#   export PYTHONPATH=${PYTHONPATH}:~/Library/Python/2.7/lib/python/site-packages
# fi

############################################
# Wine
# Prevent wine from creating filetype associations: https://wiki.archlinux.org/index.php/Wine#Unregister_existing_Wine_file_associations
if [[ -e /usr/bin/wine ]]; then
  export WINEDLLOVERRIDES="winemenubuilder.exe=d"
fi

############################################
# 1password cli
if [[ -e ~/.local/bin/op ]]; then
  export OP_BIOMETRIC_UNLOCK_ENABLED=true
fi
