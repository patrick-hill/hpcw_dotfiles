#!/usr/bin/env bash

# Backup current .bash_profile
dts=$(date +%F_%T)

if [[ -e ~/.bash_profile ]]; then
  echo "Current profile backed up to: ~/.bash_profile_$dts.bak"
  mv ~/.bash_profile ~/.bash_profile_$dts.bak
fi

os=$(uname)

if [[ "$os" == "Linux" ]]; then
  echo "Copying linux profile"
  cp -f linux/.bash_profile ~/.bash_profile
fi

echo 'Done'