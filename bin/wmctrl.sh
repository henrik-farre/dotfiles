#!/bin/sh

case ${1} in
  'topleft') 
  wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
  wmctrl -r :ACTIVE: -e 0,0,0,960,580
  ;;
  'topright') 
  wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
  wmctrl -r :ACTIVE: -e 0,960,0,960,580
  ;;
  'bottomleft') 
  wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
  wmctrl -r :ACTIVE: -e 0,0,600,960,580
  ;;
  'bottomright') 
  wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
  wmctrl -r :ACTIVE: -e 0,960,600,960,580
  ;;
esac
