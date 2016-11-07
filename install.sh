#!/usr/bin/env bash

dts=$(date +%F_%T)

echo Checking for dir: ~/.dotfiles
if [ -e ~/.dotfiles ]; then
    mv ~/.dotfiles ~/.dotfiles_${dts}.bak
fi


echo Cloning repo to: ~/.dotfiles
git clone https://github.com/patrick-hill/hpcw_dotfiles.git ~/.dotfiles
#cp -r ~/src/hpcw/hpcw_dotfiles/ ~/.dotfiles

echo Running setup
cd ~/.dotfiles && ./setup.sh


echo
echo Installation complete
exit 0
