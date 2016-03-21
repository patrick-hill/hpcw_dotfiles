# Code is ran for every new terminal (Mac's .bash_profile sources this file!)

bash_init='/Users/phill/src/hpcw/hpcw_mac_env/.bash_init'

if [ -e ${bash_init} ]; then
   source ${bash_init}
else
	echo "Can't find file: ${bash_init}"
fi