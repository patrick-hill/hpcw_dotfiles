#!/usr/bin/env bash


########################################################
### Vars
########################################################
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
dts=$(date +%F_%T)
os=$(uname)

echo
echo Setup script running from dir: $DIR
echo


########################################################
### .bashrc
########################################################
if [ -e ~/.bashrc ]; then
    echo Backing up .bashrc to: ~/.bashrc_${dts}.bak
    mv ~/.bashrc ~/.bashrc_${dts}.bak
fi

if [[ "$os" == "Linux" ]]; then
    cp -f bash/linux/.bashrc ~/.bashrc
fi


########################################################
### Git
########################################################
echo
echo Copying git dotfiles
cp -f git/.git* ~/


echo
echo Setup complete
exit 0
