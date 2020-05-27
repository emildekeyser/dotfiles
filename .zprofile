source $HOME/.zshrc

[ $(hostname) == machine1 ] && [ -z $(pgrep mpd) ] && mpd &
dad start

[ "$(tty)" == "/dev/tty1" ] && [ "$(hostname)" =~ "machine[0-9]*" ] && startx $HOME/.config/X/xinitrc >> $HOME/.local/log/X 2>&1
