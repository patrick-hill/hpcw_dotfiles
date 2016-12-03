#!/usr/bin/env bash

########################################################
### Functions: Checksums
########################################################
func_sha1() {
  sha1sum $@
}

func_md5() {
  md5sum $@
}


########################################################
### Functions: Dir & Files
########################################################
func_mdir() {
  mkdir -p "$@" && cd "$_"
}

function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* *;
	fi;
}


########################################################
### Navigation
########################################################
alias cdprofile="cd ${HOME}/.dotfiles; c; "
alias cdscripts="cd ${DIR_SCRIPTS}; c; "
alias cdsrc="cd ${DIR_SRC}; c; "
alias cdgames="cd ${DIR_GAMES}; c; "
alias cdenv="cd ${DIR_SRC}/hpcw/hpcw_env_setup; c; "
alias cdvm="cd ${DIR_VM}; c; "
alias cddb="cd ${DIR_DROPBOX}; c; "
alias cdd="cd ${HOME}/Documents; c; "
alias cddl="cd ${HOME}/Downloads; c; "


########################################################
### Bash .dotfiles
########################################################
alias src='source ${HOME}/.bashrc'
alias editenv="intellij ${DIR_SRC}/hpcw/hpcw_env_setup"
alias editprofile="intellij ${DIR_SRC}/hpcw/hpcw_dotfiles/"


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