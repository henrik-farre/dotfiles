#!/bin/zsh
if [[ -f ~/.kube/config ]]; then
  local CURRENT_CONTEXT=$(grep current-context: ~/.kube/config | cut -d" " -f2)
  local BLOCK_COLOR="colour196"
  if [[ $CURRENT_CONTEXT =~ "^.prod-.*" ]]; then
    printf "#[fg=%s] #[fg=colour255,bg=%s] ⎈ %s" "$BLOCK_COLOR" "$BLOCK_COLOR" "$CURRENT_CONTEXT"
  elif [[ $CURRENT_CONTEXT =~ "^.nonprod-.*" ]]; then
    BLOCK_COLOR="colour178"
    printf "#[fg=%s] #[fg=colour255,bg=%s] ⎈ %s" "$BLOCK_COLOR" "$BLOCK_COLOR" "$CURRENT_CONTEXT"
  elif [[ $CURRENT_CONTEXT != '""' ]]; then
    BLOCK_COLOR="colour34"
    printf "#[fg=%s] #[fg=colour255,bg=%s] ⎈ %s" "$BLOCK_COLOR" "$BLOCK_COLOR" "$CURRENT_CONTEXT"
  fi
fi
