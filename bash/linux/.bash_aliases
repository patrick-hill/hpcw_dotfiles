#!/usr/bin/env bash

########################################################
### Terminal Tweaks w/ Git Enhancements
########################################################
# AutoComplete
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# http://misc.flogisoft.com/bash/tip_colors_and_formatting
case "$TERM" in
xterm*|rxvt*)
  PS1='\[\033[0;37m\][\t]\[\033[0;32m\][\u]\[\033[31m\][\h]\[\033[0;33m\]`git branch 2>/dev/null | grep \* | head -1 | sed "s/\* //g" | awk "{ print \"[ \"\\\$1 \" ]\" }"` \[\033[1;36m\]\w\a\[\033[0m\]\n\$ '
    ;;
*)
    ;;
esac


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
alias cdsrc="cd ${DIR_SRC}/hpcw; c; "
alias cdgames="cd ${DIR_GAMES}; c; "
alias cdenv="cd ${DIR_SRC}/hpcw/provisioning/hpcw_env_setup; c; "
alias cdvm="cd ${DIR_VM}; c; "
alias cddb="cd ${DIR_DROPBOX}; c; "
alias cdd="cd ${HOME}/Documents; c; "
alias cddl="cd ${HOME}/Downloads; c; "


########################################################
### Bash .dotfiles
########################################################
alias src='source ${HOME}/.bashrc'
alias editenv="code ${DIR_SRC}/hpcw/provisioning/hpcw_env_setup"
alias editprofile="code ${DIR_SRC}/hpcw/provisioning/hpcw_dotfiles/"


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
alias l='ls -CF --color=auto'
alias la='ls -A --color=auto'
alias ll='ls -alF --color=auto'
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