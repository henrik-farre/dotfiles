#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail
# set -x trace

export OP_CACHE=true

CFG="$(dirname $0)/tmux_1password.cfg"
SELECTED=$(cat $CFG | fzf-tmux -p)

i=0

# Select everything after // so there can be any text in front
while RESULT=$(op read -n "op://${SELECTED##*//}") && [ $? -ne 0 ]; do
  tmux display-message "1Password is locked - please unlock"
  if [[ $i == 10 ]]; then
    break
  fi
  ((i++))
  sleep 2
done

if [[ $? -gt 0 ]]; then
  tmux display-message "An error occurred"
else
  tmux display-message "Typing selected password"
  tmux send-keys "$RESULT" Enter
fi
