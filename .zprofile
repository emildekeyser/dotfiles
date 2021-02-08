source $HOME/.zshrc

# monitor-home &
[ $HOST == machine1 ] && [ -z $(pgrep mpd) ] && mpd &
dad start

# warning when a program might create a mess
[ -z $(pgrep inotifywait) ] \
    && inotifywait -q --monitor --event create $HOME $HOME/.config $HOME/.local/share >> ~/.local/log/masterlog &

[ "$(tty)" == "/dev/tty1" ] && [ "$HOST" =~ "machine[0-9]*" ] && startx $HOME/.config/X/xinitrc >> $HOME/.local/log/X 2>&1

# vim:ft=sh
