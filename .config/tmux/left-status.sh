#!/bin/zsh
if [[ -e /usr/bin/kubectx ]]; then
  source ~/.config/shell.d/kubeconfig.zsh
  echo "#[fg=colour74] #[fg=colour255,bg=colour74] ⎈ $(/usr/bin/kubectx --current)"
fi
