#!/bin/bash

cd /tmp
rm -rf neovim-git neovim-git.tar.gz
wget https://aur.archlinux.org/cgit/aur.git/snapshot/neovim-git.tar.gz
tar zxvf neovim-git.tar.gz
cd neovim-git
sed -r -i -e 's/=Dev/=Release/' PKGBUILD
makepkg
PACKAGE=$(find . -name "*.xz")
mkdir -p ~/tmp/neovim/
cp "$PACKAGE" ~/tmp/neovim/
sudo pacman -U "$PACKAGE"
cd /tmp
rm -rf neovim-git neovim-git.tar.gz
