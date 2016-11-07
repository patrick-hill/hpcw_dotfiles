#!/usr/bin/env bash


########################################################
### Vars
########################################################
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
dts=$(date +%F_%T)
os=$(uname)
echo "Setup script running from dir: $DIR"


########################################################
### .dotfiles Dir
########################################################
# Scripts are coded for: ~/.dotfiles as this repo's root
# confirm this is the case and if not, copy over & continue
if [ "${DIR}" != "${HOME}/.dotfiles" ]; then

    echo DIR is: ${DIR}
    echo COMPARE is: ${DIR} != ${HOME}/.dotfiles

    if [ -e "${HOME}/.dotfiles" ]; then
        mv ${HOME}/.dotfiles/ ${HOME}/.dotfiles_${dts}.bak
        sleep 1
    fi

    mkdir ${HOME}/.dotfiles
    cp -rf ${DIR}/* ${HOME}/.dotfiles
    ${HOME}/.dotfiles/setup.sh
    exit 0
fi


########################################################
### .bashrc
########################################################
if [ -e ~/.bashrc ]; then
    echo Backing up .bashrc to: ~/.bashrc_${dts}.bak
    mv ~/.bashrc ~/.bashrc_${dts}.bak
fi

if [[ "$os" == "Linux" ]]; then
    cp -f bash/linux/.bashrc ~/
fi


########################################################
### Git
########################################################
echo Copying git dotfiles
cp -f .git* ~/


echo 'Done'
exit 0
