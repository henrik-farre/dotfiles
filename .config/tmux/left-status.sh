#!/bin/zsh
if [[ -f ~/.kube/config ]]; then
  local CURRENT_CONTEXT=$(grep current-context: ~/.kube/config | cut -d" " -f2)
  local CURRENT_NS=$(kubens --current)
  local BLOCK_COLOR
  local SHOW=n

  if [[ $CURRENT_CONTEXT =~ "^.prod-.*" ]]; then
    SHOW=y
    BLOCK_COLOR="colour196"
  elif [[ $CURRENT_CONTEXT =~ "^.nonprod-.*" ]]; then
    SHOW=y
    BLOCK_COLOR="colour178"
  elif [[ $CURRENT_CONTEXT != '""' ]]; then
    SHOW=y
    BLOCK_COLOR="colour2"
  fi

  if [[ "$SHOW" == 'y' ]]; then
    printf "#[fg=%s] #[fg=colour255,bg=%s] ⎈ %s | %s" "$BLOCK_COLOR" "$BLOCK_COLOR" "$CURRENT_CONTEXT" "$CURRENT_NS"
  fi
fi
