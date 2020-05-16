#!/bin/zsh
if [ -d ~/.kube ]; then
        _AVAILABLE_KUBE_CONFIGS=("${(@f)$(ls -d ~/.kube/configs/*)}")
        export KUBECONFIG=${(j#:#):-${^_AVAILABLE_KUBE_CONFIGS}}
        unset _AVAILABLE_KUBE_CONFIGS
fi
