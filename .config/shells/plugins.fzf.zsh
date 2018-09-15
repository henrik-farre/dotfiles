######################################################
# FZF
# From https://github.com/junegunn/fzf
FZF_KEYBINDINGS_PATH=/usr/share/fzf/key-bindings.zsh
FZF_COMPLETION_PATH=/usr/share/fzf/completion.zsh
if [[ $PLATFORM == 'Darwin' ]]; then
  FZF_KEYBINDINGS_PATH=/usr/local/opt/fzf/shell/key-bindings.zsh
fi

# Use -e if symlink (locally installed)
if [[ -f $FZF_KEYBINDINGS_PATH ]]; then
  # System installed:
  source $FZF_KEYBINDINGS_PATH
  # Local installed:
  # source ~/.fzf.zsh

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
fi

if [[ -f $FZF_COMPLETION_PATH ]]; then
  export FZF_COMPLETION_TRIGGER=''
  source $FZF_COMPLETION_PATH
  # "setopt vi resets TAB key binding, so unless you've assigned a dedicated key, fuzzy completion will become unavailable."
  # - https://github.com/junegunn/fzf/wiki/Configuring-fuzzy-completion
  bindkey '^T' fzf-completion
  bindkey '^I' $fzf_default_completion
fi
