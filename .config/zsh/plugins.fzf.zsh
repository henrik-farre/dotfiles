######################################################
# FZF
# From https://github.com/junegunn/fzf
#
if type fzf &>/dev/null; then
  source <(fzf --zsh)

  # https://github.com/junegunn/fzf/blob/master/fzf#L653
  #export FZF_DEFAULT_COMMAND="find * -path '*/\\.*' -xdev -prune -o -type f -print -o -type l -print 2> /dev/null"
  # https://github.com/junegunn/fzf Respecting .gitignore, .hgignore, and svn:ignore
  if type ag &>/dev/null; then
    export FZF_DEFAULT_COMMAND='ag -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
  export FZF_DEFAULT_OPTS="-x -e"

  # Else fzf will not split using tmux
  export FZF_TMUX=1

  # Use tmux popup window, see fzf-tmux --help
  export FZF_TMUX_OPTS="-p 80%"

  export FZF_CTRL_R_OPTS="--prompt='History > '"

  # "setopt vi resets TAB key binding, so unless you've assigned a dedicated key, fuzzy completion will become unavailable."
  # - https://github.com/junegunn/fzf/wiki/Configuring-fuzzy-completion
  # bindkey '^T' fzf-completion
  # bindkey '^I' $fzf_default_completion
fi
