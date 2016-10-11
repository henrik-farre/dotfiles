#!/bin/bash

#TERM="urxvt.URxvt"
TERM="termite.Termite"

TERM_ID=$(wmctrl -lx | grep "$TERM" | cut -d" " -f1)
#CURRENT_DESK=`wmctrl -d | grep "* DG" | cut -d" " -f1`

if [[ -z $TERM_ID ]]; then
  #urxvtc
  termite
else
  #wmctrl -i -r $TERM_ID -t $CURRENT_DESK
  # -R <WIN> Move the window <WIN> to the current desktop, raise the window, and give it focus.
  wmctrl -i -R "$TERM_ID"
fi
