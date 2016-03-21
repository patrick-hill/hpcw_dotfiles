# Code is ran only once for login (Except Mac's run for every new Terminal.app -.-)

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
else
	echo "Can't find ~/.bashrc!"
fi
