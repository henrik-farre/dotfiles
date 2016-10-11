#!/bin/bash

if [[ $1 == 'shutdown' ]]; then
    echo "Will shutdown after build (no install)"
fi

cd ~/Development/linux
ABSROOT=. abs core/linux
cd core/linux/
sed -rie 's/pkgbase=linux/pkgbase=linux-hfa/' PKGBUILD
sed -rie 's/# CONFIG_VLAN_8021Q_GVRP is not set/CONFIG_VLAN_8021Q_GVRP=y/' config
sed -rie 's/# CONFIG_VLAN_8021Q_GVRP is not set/CONFIG_VLAN_8021Q_GVRP=y/' config.x86_64
updpkgsums
makepkg -s
~/bin/user-notification.sh "emblem-generic" "Kernel compile" "Done..."
mv linux-hfa-*.xz ~/Development/linux
cd ~/Development/linux
rm -rf ~/Development/linux/core

if [[ $1 == 'shutdown' ]]; then
    sudo shutdown -h now
fi
