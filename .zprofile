source $HOME/.zshrc

[ "$(tty)" == "/dev/tty1" ] || exit
[ "$(hostname)" =~ "machine[0-9]*" ] || exit

startx $HOME/.config/X/xinitrc >> $HOME/.local/log/X 2>&1
