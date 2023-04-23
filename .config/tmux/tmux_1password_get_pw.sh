#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail
# set -x trace

export OP_CACHE=true

CFG="$(dirname $0)/tmux_1password.cfg"
SELECTED=$(cat $CFG | fzf-tmux -p)

while RESULT=$(op read -n "${SELECTED##* }") && [ $? -ne 0 ]; do
  tmux display-message "1Password is locked - please unlock"
  sleep 5
done

if [[ $? -gt 0 ]]; then
  tmux display-message "An error occurred"
else
  tmux display-message "Typing selected password"
  tmux send-keys "$RESULT" Enter
fi
