#!/bin/bash
############################################################
# Terminal settings
if [[ "${TERM}" == "rxvt-unicode" ]] && \
        [[ ! -f /usr/share/terminfo/r/rxvt-unicode ]] && \
        [[ ! -f ~/.terminfo/r/rxvt-unicode ]] ; then
    export TERM=rxvt
fi

if [[ "${TERM}" == "rxvt-256color" ]] && \
        [[ ! -f /usr/share/terminfo/r/rxvt-256color ]] && \
        [[ ! -f ~/.terminfo/r/rxvt-256color ]] ; then
    export TERM=rxvt
fi

if [[ "${TERM}" == "rxvt-unicode-256color" ]] && \
        [[ ! -f /usr/share/terminfo/r/rxvt-unicode-256color ]] && \
        [[ ! -f ~/.terminfo/r/rxvt-unicode-256color ]] ; then
    export TERM=rxvt
fi

if [[ "${TERM}" == "xterm" ]]; then
  export TERM=xterm-256color
fi

if [[ $TERM == "tmux-256color" && -z $TMUX ]]; then
  export TERM="screen-256color"
fi

# Disable flow control, so CTRL-S / CTRL-Q doesn't freeze the terminal
stty -ixon -ixoff
