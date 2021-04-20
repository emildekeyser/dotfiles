source $HOME/.zshrc

[[ $(hostname) == machine1 ]] && pgrep mpd >/dev/null && mpd &
dad start

# warning when a program might create a mess
pgrep inotifywait >/dev/null \
    && inotifywait -q --monitor --event create $HOME $HOME/.config $HOME/.local/share >> ~/.local/log/masterlog &

[[ "$(tty)" == "/dev/tty1" ]] && \
    [[ "$HOST" =~ "machine[[0-9]]*" ]] \
    && startx $HOME/.config/X/xinitrc -- -logfile $HOME/.local/log/X # 2>&1 >/dev/null

# vim:ft=sh
