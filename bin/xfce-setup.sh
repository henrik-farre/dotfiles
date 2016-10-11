#!/bin/bash
exec > ~/.xfce-setup.log 2>&1

HOST=$(hostname)

if [[ -f "$HOME/.nvidia-settings-rc" ]]; then
  # echo "Loading nvidia settings"
  nvidia-settings --load-config-only
  # https://wiki.archlinux.org/index.php/NVIDIA#GUI:_nvidia-settings
  # For a dramatic 2D graphics performance increase in pixmap-intensive applications, e.g. Firefox, set the InitialPixmapPlacement parameter to 2
  # http://cgit.freedesktop.org/~aplattner/nvidia-settings/tree/src/libXNVCtrl/NVCtrl.h?id=b27db3d10d58b821e87fbe3f46166e02dc589855#n2797
  # nvidia-settings -a InitialPixmapPlacement=2
fi

# ETH0=$( ip addr list eth0 |grep "inet " |cut -d' ' -f6|cut -d/ -f1 )
# SSID=$(/usr/sbin/iwgetid --raw)
# NETWORK='x';
#
# if [[ x${ETH0} == 'x' ]]; then # eth0 has no ip, lets try wlan0
#   if [[ x${SSID} == 'x' ]]; then # no network connection
#       NETWORK='home'
#   else
#   case ${SSID} in
#     'ethereal_plane')
#       NETWORK='home'
#       ;;
#     'bellcom')
#       NETWORK='work'
#       ;;
#   esac
#   fi
# else
#   case ${ETH0} in
#     '192.168.0.20')
#       NETWORK='home'
#       ;;
#     '192.168.42.51')
#       NETWORK='work'
#       ;;
#   esac
# fi

# if [[ ${NETWORK} == 'home' || ${NETWORK} == 'x' ]]; then
#   xfconf-query -c xfce4-panel -p "/panels/panel-0/output-name" -s "LVDS1"
# elif [[ ${NETWORK} == 'work' ]]; then
#   xfconf-query -c xfce4-panel -p "/panels/panel-0/output-name" -s "HDMI2"
# fi

# if [[ ${NETWORK} == 'work' || ${NETWORK} == 'x' ]]; then
#    /usr/bin/xautolock -locker slimlock -time 10 -notify 10 -notifier '/usr/bin/notify-send "Screen will lock in 10 seconds"' &
# fi

# urxvtc -name "RootTerm" -e top &
# wmctrl -l -x
# wmctrl -i -r 0x03200139 -b add,skip_pager,below
# wmctrl -i -r 0x03200139 -b add,skip_taskbar
#
# ID=$(wmctrl -l | awk '{if (match($4, /^enrique@/)) print $1 }')
# wmctrl -i -r ${ID} -b add,below -b add,skip_pager -b add,skip_taskbar
#

#if [[ $HOST == "firehouse" ]]; then
  # Moved to /etc/X11/xorg.conf.d/50-mouse-acceleration.conf
#  xinput set-prop 'pointer:Logitech USB Receiver' 'Device Accel Constant Deceleration' 2
#   synergys
#   notify-send "Started synergys" -i /usr/share/icons/Tango/scalable/apps/utilities-terminal.svg
#fi
#
# if [[ $HOST == "ectoplasma"  ]]; then
#   SSID=$(/usr/sbin/iwgetid --raw)
#
#   if [[ $SSID == 'ethereal_plane' ]]; then
#     synergyc -d ERROR firehouse
#     setxkbmap $(setxkbmap -query | grep "^layout:" | awk -F ": *" '{print $2}')
#     notify-send "Started synergyc" "to firehouse" -i /usr/share/icons/Tango/scalable/apps/utilities-terminal.svg
#   fi
# fi

##########################################################################
# Background setup
#
CONNECTED_OUTPUTS=$(xrandr | grep "\<connected\>" -c)

BACKGROUNDS="/home/enrique/.btsync/Backgrounds/Laptop/"
PANEL_OUTPUTNAME="LVDS1"
MAIN_OUTPUTNAME="LVDS1"

if [[ $CONNECTED_OUTPUTS == 1 && $HOST == "ectoplasma" ]]; then
  BACKGROUNDS="/home/enrique/.sync/Backgrounds/Dual/"
  # echo "One connected output on ectoplasma"
  # xrandr --output HDMI1 --off
  # xrandr --output LVDS1 --auto
  # xrandr --output HDMI2 --off
elif [[ $HOST == "workstation" ]]; then
  xrandr --output VGA-0 --left-of DVI-I-1
elif [[ $CONNECTED_OUTPUTS == 2 && $HOST == "firehouse" ]]; then
  # echo "Two connected output on firehouse"
  MAIN_OUTPUTNAME="HDMI-0"
  PANEL_OUTPUTNAME="DVI-I-1"
  BACKGROUNDS="/home/enrique/.btsync/Backgrounds/Dual/"
elif [[ $CONNECTED_OUTPUTS == 3 ]]; then
  # echo "Three connected output"
  # 3 Means LVDS1, HDMI1 and HDMI2
  MAIN_OUTPUTNAME="HDMI1"
  PANEL_OUTPUTNAME="HDMI2"
  BACKGROUNDS="/home/enrique/.btsync/Backgrounds/Dual/"
  xrandr --output HDMI1 --auto
  xrandr --output LVDS1 --off
  xrandr --output HDMI2 --auto
  xrandr --output HDMI2 --right-of HDMI1
fi

# Place panel on correct screen
#xfconf-query -c xfce4-panel -p "/panels/panel-0/output-name" -s "$PANEL_OUTPUTNAME"

BACKGROUND="${BACKGROUNDS}$(ls $BACKGROUNDS | shuf -n 1)"

# echo "$BACKGROUND"

# Set background to image in folder
#xfconf-query -c xfce4-desktop -p "/backdrop/screen0/monitor${MAIN_OUTPUTNAME}/workspace0/last-image" -s "$BACKGROUND"

##########################################################################
# Misc
#
# Does not work well with firefox
#
# if hash unclutter; then
#   unclutter &
# fi

# CONKY_RUNNING=$(pgrep -c conky)
# if [[ $CONKY_RUNNING -eq 0 ]]; then
#   echo "Starting conky"
#   conky
# else
#   echo "Restarting conky"
#   pkill --signal USR1 conky
# fi

# Disable presentation mode
xfconf-query -c xfce4-power-manager -p "/xfce4-power-manager/presentation-mode" -s false

# Is run in .config/xfce4/xinitrc
#xmodmap ~/.Xmodmap
