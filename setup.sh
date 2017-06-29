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
### .bashrc & .bash_profile
########################################################
bash_files=( .bashrc .bash_profile )
for i in "${bash_files[@]}"
do
    if [ -e ~/${i} ]; then
        echo Backing up ${i} to: ~/${i}_${dts}.bak
        mv ~/${i} ~/${i}_${dts}.bak
    fi

    if [[ "$os" == "Linux" ]]; then
        cp -f bash/linux/${i} ~/${i}
fi

done


########################################################
### Git
########################################################
echo
echo Copying git dotfiles
cp -f git/.git* ~/

########################################################
### Sourcing
########################################################
echo
echo Sourcing .bashrc
source ~/.bashrc

echo
echo Setup complete
exit 0
