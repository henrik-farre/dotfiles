#!/bin/bash

# https://unix.stackexchange.com/questions/533664/how-to-auto-complete-based-on-the-buffer-contents-in-tmux

tmux capture-pane -pS -100 |      # Dump the tmux buffer.
  tac |                              # Reverse so duplicates use the first match.
  grep -P -o "[\w\d_\-\.\/]+" |      # Extract the words.
  awk '{ if (!seen[$0]++) print }' | # De-duplicate them with awk, then pass to fzf.
  grep -P -v "\($USERNAME\|^[ld-][rwx-]\)" |                     # Remove unwanted strings
  grep -P -v "\(jan\|feb\|mar\|apr\|maj\|jun\|jul\|aug\|sep\|okt\|nov\|dec\)" |
  grep -P -v "\d*,+\d+[KMGT]" |
  fzf --no-sort --exact +i           # Pass to fzf for completion.
