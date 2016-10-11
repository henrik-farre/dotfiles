#!/bin/sh

[ -n "$1" ] || exit 1
tmux select-pane $1
tmux select-pane -P 'bg=black'
sleep 0.1
tmux select-pane -P 'bg=default'
