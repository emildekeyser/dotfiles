source $HOME/.zshrc

if [ "$(tty)" == "/dev/tty1" ]; then
	startx $HOME/.config/X/xinitrc >> $HOME/.local/log/X 2>&1
fi
