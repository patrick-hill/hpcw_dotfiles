#!/usr/bin/env bash


########################################################
### File managed via setup script from HPCW dotfiles
########################################################
dotfiles_dir=${HOME}/.dotfiles/bash/linux/.bash_profile

if [[ "$(uname)" == "Linux" ]]; then

    dotfiles_dir=${HOME}/.dotfiles/bash/linux/.bash_profile

    if [ -e $dotfiles_dir ]; then
        source $dotfiles_dir
    fi
fi
