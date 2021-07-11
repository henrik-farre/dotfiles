#!/bin/bash

# set -o xtrace
# exec &>> /tmp/launcher.log

WINDOW_NAME="$1"
APPLICATION_NAME="$2"

WINDOW_ID=$(wmctrl -lx | grep "$WINDOW_NAME" | cut -d" " -f1)

if [[ -z $WINDOW_ID ]]; then
  exec "$2"
else
  # -R <WIN> Move the window <WIN> to the current desktop, raise the window, and give it focus.
  wmctrl -i -R "$WINDOW_ID"
fi
