#!/usr/bin/env bash


########################################################
### Navigation
########################################################
alias cdprofile="func_cd ${HOME}/.dotfiles"
alias cdscripts="func_cd ${DIR_SCRIPTS}"
alias cdsrc="func_cd ${DIR_SRC}"
alias cdgames="func_cd ${DIR_GAMES}"
alias cdenv="func_cd ${DIR_SRC}/hpcw/hpcw_env_setup"
alias cdvm="func_cd ${DIR_VM}"
alias cddb="func_cd ${DIR_DROPBOX}"
alias cdd="func_cd ${HOME}/Documents"
alias cddl="func_cd ${HOME}/Downloads"


########################################################
### Bash .dotfiles
########################################################
alias src='source ${HOME}/.bashrc'
alias editenv="code ${DIR_SRC}/hpcw/hpcw_env_setup"
alias editprofile="code .dotfiles/"


########################################################
### Terminal
########################################################
alias r='reset && pwd'
alias c='clear'
alias cl='clear && pwd && l'
alias ..='cd ..'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'

alias ip='ifconfig'
alias ping='ping -c 4'

alias root='sudo su - root'

alias date='date +%d-%b-%Y'

alias backup=func_backup
alias diff=func_diff
alias sha1=func_sha1
alias md5=func_md5
alias mdir=func_mdir

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


########################################################
### APT
########################################################
alias apti="sudo apt-get install"
alias aptr="sudo apt-get remove"
alias apts="sudo apt-cache search"
alias aptu="sudo apt-get update"


########################################################
### Git
########################################################
alias g='git'
alias gs='git status'
alias ga='git add'
alias ga.='git add .'
alias gc='git commit'
alias gp='git push'


########################################################
### Fun ;)
########################################################
alias starwars="telnet towel.blinkenlights.nl"