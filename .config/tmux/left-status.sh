#!/bin/zsh
if [[ -e /usr/bin/kubectx ]]; then
  source ~/.config/shell.d/kubeconfig.zsh
  local CURRENT_CONTEXT=$(/usr/bin/kubectx --current)
  if [[ $CURRENT_CONTEXT =~ ".*prod.*" ]]; then
    BLOCK_COLOR="colour196"
    printf "#[fg=%s] #[fg=colour255,bg=%s] ⎈ %s" "$BLOCK_COLOR" "$BLOCK_COLOR" "$CURRENT_CONTEXT"
  fi
fi
