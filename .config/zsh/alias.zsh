#!/bin/zsh

alias cp='nocorrect cp -iv' # no spelling correction on cp...
alias rm='nocorrect rm -iv'
alias mv='nocorrect mv -iv'
alias mkdir='nocorrect mkdir'

################################################
# Vim / Neovim
if [[ -e /usr/bin/nvim ]]; then
  # neovim
  alias vim='nocorrect nvim'
else
  alias vim='nocorrect vim'
fi

# Replaced with cd function
#alias cd=' builtin cd' # midnight commander history fix
#

################################################
# History aliases, show full history
alias recall='fc -l 1 | ag'
alias history='fc -l 1'

################################################
# Suffix aliases
alias -s doc='libreoffice'
alias -s pdf='evince'
