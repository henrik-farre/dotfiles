#!/bin/sh

amixer set Master 85

thunderbird &
firefox -P Work -no-remote &
zim &
~/bin/trckr &
~/bin/rdio &
urxvtc &
skype &

# sleep 5
# WINDOWS=`wmctrl -l`
# 
# wmctrl -i -r `echo $WINDOWS | grep 'Thunderbird' | cut -d" " -f1` -t 0
# wmctrl -i -r `echo $WINDOWS | grep 'Firefox' | cut -d" " -f1` -t 1
# wmctrl -i -r `echo $WINDOWS | grep 'Zim' | cut -d" " -f1` -t 1
# wmctrl -i -r `echo $WINDOWS | grep 'Trckr' | cut -d" " -f1` -t 1
# sleep 5
# WINDOWS=`wmctrl -l`
# wmctrl -i -r `echo $WINDOWS | grep 'Rdio' | cut -d" " -f1` -t 4
