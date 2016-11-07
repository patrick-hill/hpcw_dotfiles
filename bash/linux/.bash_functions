#!/usr/bin/env bash


########################################################
### Checksums
########################################################
func_sha1() {
  sha1sum $@
}

func_md5() {
  md5sum $@
}


########################################################
### Dir & Files
########################################################
func_mdir() {
  mkdir -p "$@" && cd "$_"
}

func_cd() {
  cd $1 && c
}

func_backup() {
  cp $1{,.bak}
}

func_diff() {
  diff $1{.bak,}
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
### Support Functions (Used elsewhere in .dotfiles)
########################################################

