#!/usr/bin/env bash

source_bash_files() {

    declare -r -a FILES_TO_SOURCE=(
        ".bash_options"
        ".bash_exports"
        ".bash_aliases"
        ".bash_vagrant"
    )

    for i in ${!FILES_TO_SOURCE[*]}; do

        file="${HOME}/.dotfiles/bash/linux/${FILES_TO_SOURCE[$i]}"

        if [ -e "$file" ]; then
            source "$file"
        fi

    done
}

source_bash_files
unset -f source_bash_files
