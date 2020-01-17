#!/bin/bash
############################################################
# Terminal settings
if [[ $TERM == "screen-256color" && -n $SSH_TTY && ! -e /usr/bin/screen && $SHELL == "/bin/bash" ]]; then
  export TERM="xterm-256color"
fi

# Disable flow control, so CTRL-S / CTRL-Q doesn't freeze the terminal
stty -ixon -ixoff
