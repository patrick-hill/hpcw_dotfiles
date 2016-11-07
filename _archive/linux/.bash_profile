#!/usr/bin/env bash

[[ -r ~/.bashrc ]] && . ~/.bashrc

# Exports
export DROPBOX_DIR="${HOME}/Dropbox"
export VM_DIR="${HOME}/vms"
export SRC_DIR="${HOME}/src"
export GAMES="${HOME}/games"
export DOTFILES_DIR="${SRC_DIR}/hpcw/hpcw_dotfiles"
export SCRIPTS_DIR="${DOTFILES_DIR}/scripts"
export PATH="$PATH:${SCRIPTS_DIR}"

#### Navigation Shortcuts
alias cdprofile="func_cd ${DOTFILES_DIR}"
alias cdscripts="func_cd ${SCRIPTS_DIR}"
alias cdsrc="func_cd ${SRC_DIR}"
alias cdgames="func_cd ${GAMES}"
alias cdenv="func_cd ${SRC_DIR}/hpcw/hpcw_env_setup"
alias cdvm="func_cd ${VM_DIR}"
alias cddb="func_cd ${DROPBOX_DIR}"
alias cdd="func_cd ${HOME}/Documents"
alias cddl="func_cd ${HOME}/Downloads"

#### Bash Profile Shortcuts
alias src='source ~/.bash_profile'
alias editenv="code ${SRC_DIR}/hpcw/hpcw_env_setup"
alias editprofile="code ${DOTFILES_DIR}/linux/.bash_init"

#### System Shortcuts
alias log-out="gnome-session-quit"

# Checksum
alias sha1=func_sha1
func_sha1() {
  sha1sum $@
}
alias md5=func_md5
func_md5() {
  md5sum $@
}

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Make and cd to dir
alias mdir=func_mdir
func_mdir() {
  mkdir -p "$@" && cd "$_"
}
# Display the current directory path and its contents every time you clear the screen
alias r='reset && pwd'
alias c='clear'
alias cl='clear && pwd && l'
# Only send 4 ping requests, then stop
alias ping='ping -c 4'
# Become root
alias root='sudo su - root'
# Determine size of a file or total size of a directory
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
# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
	function diff() {
		git diff --no-index --color-words "$@";
	}
fi;

#### Dirs
alias l='ls -la'

#### Inter-Web Findings
alias date='date +%d-%b-%Y'
alias ..='cd ..'
alias backup=func_backup
func_backup() {
  cp $1{,.bak}
}
alias diff=func_diff
func_diff() {
  diff $1{.bak,}
}

# Used for all 'cd' aliases
func_cd() {
  cd $1 && c
}

#### Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias ga.='git add .'
alias gc='git commit'
alias gp='git push'

#### Vagrant
export VAGRANT_DEFAULT_PROVIDER=virtualbox
alias vup='vagrant up'
alias vupv='vagrant up --provider=virtualbox'
alias vdown='vagrant halt'
alias vr='vagrant reload'
alias vdes='vagrant destroy -f'
alias vs='vagrant ssh'
alias vstat='vagrant status'
alias vpro='vagrant provision'
alias vclean='vagrant global-status --prune'
alias vpl='vagrant plugin list'
alias vslist='vagrant snapshot list'
alias vsnap=func_vSnapSave
func_vSnapSave() {
    vagrant snapshot save $@
}
alias vroll=func_vSnapRestore
func_vSnapRestore() {
  vagrant snapshot restore $@
}
alias vsdel=func_vSnapDelete
func_vSnapDelete() {
  vagrant snapshot delete $@
}
alias vbl=func_vbl
func_vbl() {
  if [ -z $1 ];then
    vagrant box list
  else  
    vagrant box list | grep $1
  fi
}
alias vba=func_vba
func_vba() {
  for val in $@
  do
    vagrant box add $val $val
  done
}
alias vbr=func_vbr
func_vbr() {
  for val in $@
  do
    vagrant box remove -f $val
  done
}
alias vbu=func_vbu
func_vbu() {
  for val in $@
  do
    vbr $val
    vba $val
  done
}
