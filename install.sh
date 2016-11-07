#!/usr/bin/env bash

echo Cloning repo to: ~/.dotfiles
git clone https://github.com/patrick-hill/hpcw_dotfiles.git ~/.dotfiles

echo Running setup
~/.dotfiles/setup.sh

exit 0
