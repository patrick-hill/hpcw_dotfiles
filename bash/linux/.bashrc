#!/usr/bin/env bash


########################################################
### File managed via setup script from HPCW dotfiles
########################################################
dotfiles_dir=

if [[ "$(uname)" == "Linux" ]]; then
    dotfiles_dir=${HOME}/.dotfiles/bash/linux/.bash_profile
fi


if [ -e ${dotfiles} ]; then
    source ${dotfiles}
else
    echo Can't find file: ${dotfiles}
fi
