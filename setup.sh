#!/usr/bin/env bash

DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
echo "Setup script running from dir: $DIR"
dts=$(date +%F_%T)
os=$(uname)

# This script will backup the current .bash_profile
# and then symlink to the current OS's .bash_init file


# Backup current .bash_profile
if [[ -e ~/.bash_profile ]]; then
  echo "Current profile backed up to: ~/.bash_profile_$dts.bak"
  mv ~/.bash_profile ~/.bash_profile_$dts.bak
fi
# Remove profile if currently a symlink
if [[ -h ~/.bash_profile ]]; then
  echo "Profile is symlinked, removing old link"
  rm ~/.bash_profile
fi


# Symlink the repo's profile
if [[ "$os" == "Linux" ]]; then
  echo "Symlinking linux profile"
  ln -s $DIR/linux/.bash_profile ~/.bash_profile
fi


echo 'Done'