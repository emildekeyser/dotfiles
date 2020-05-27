export PATH="$HOME/.local/bin:$PATH"
fpath=(~/.config/zsh/functions $fpath)

# Programs
export TERMINAL=urxvt
export EDITOR=nvim
export VISUAL=$EDITOR
export BROWSER=librewolf
export PAGER='less'
export MANPAGER='nvim -R +":set ft=man" -'

# Paths
export XDG_DATA_DIRS=${XDG_DATA_DIRS=/usr/share:/usr/share/local}
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export GOPATH=$HOME/.cache/go:$HOME/project/go
export npm_config_prefix="$HOME/.local/node_modules"
export HISTFILE=$HOME/.local/history/zsh_history
export MPD_HOST="$HOME/.config/mpd/socket"
export UNISON=$HOME/.local/unison
export LESSHISTFILE=$HOME/.local/history/less
export INPUTRC=$HOME/.config/inputrc
export PYTHONSTARTUP=$HOME/.config/pythonstartup.py
export XAUTHORITY="$XDG_CACHE_HOME"/Xauthority
export NOTMUCH_CONFIG=$HOME/.config/notmuch-config
export NMBGIT=$XDG_DATA_HOME/nmbug
export WEECHAT_HOME="$XDG_CONFIG_HOME"/weechat
export MIX_HOME=$HOME/.local/share/mix
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache 
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export PSQL_HISTORY=$HOME/.local/history/psql
export RLWRAP_HOME=$HOME/.local/history
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export SQLITE_HISTORY=$HOME/.local/history/sqlite
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/password-store
export DIANA_DOWNLOAD_DIR=$HOME/torrent
export WGETRC="$HOME/.config/wgetrc"

# Options
export DIANA_SECRET_TOKEN=386a2506-fcea-4c79-9206-8cd7e8c43cc7
export FZF_DEFAULT_OPTS="--layout=reverse"
export HISTSIZE=10000000000000
export SAVEHIST=10000000000000
export LESS='-R' # colors=always
export CLICOLOR_FORCE=1 # colors=always with tree
export PROGRESS_ARGS='--monitor-continuously --wait'

case $(hostname)  in
    machine1)
        export ETH=enp0s25
        export WLAN=''
        ;;
    machine2)
        export ETH=enp2s0
        export WLAN=wlp0s18f2u1
        export YTFORMAT='--ytdl-format=worst'
        ;;
esac

#	 
#	        |_)            
#	   _` | | |  _` |  __| 
#	  (   | | | (   |\__ \ 
#	 \__,_|_|_|\__,_|____/ 
#	                       
#

# Default flags (interactive shell only)
alias grep='grep -iP --color=auto'
alias diff='diff --color=auto'
alias ls='ls --color=auto'
alias mpv='mpv --audio-display=no'
alias ffmpeg='ffmpeg -hide_banner'
alias ffplay='ffprobe -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias emerge='sudo emerge --ask'
alias watch='watch --color --interval=0.5'
alias cp='cp -rv'
alias curl='curl --progress-bar'
alias df='df -hT'
alias du='du -sh'
alias irssi='irssi --config=~/.config/irssi/config --home=$XDG_DATA_HOME/irssi'
alias sqlite3='sqlite3 -init ~/.config/sqliterc'
alias units='units --history ~/.local/history/units'

# Shortcuts
alias y=tree
alias S="yay -S"
alias v=$EDITOR
alias l='ls -CF1 --group-directories-first'
alias ll='ls -lhF --group-directories-first'
alias la='l -A'
alias lla='ll -A'
alias u='v ~/ucll/u.todo'
alias t='v ~/project/me/todo/now.todo'
alias T='v ~/project/me/todo/project.todo'
alias tg='telegram-cli -NfW'
alias py=python
alias md='mkdir -p'
alias xo='setsid xdg-open'
alias hl='highlight --out-format=xterm256'
alias reboot='sudo reboot'
alias poweroff='sudo poweroff'

# Edit things in vim shortcuts
alias g='cd ~/.config; v -c FZF; cd -'
alias s='cd ~/project/scripts; v -c FZF; cd -'

# Sources
alias U='find ~/project/ucll1920/sem1/ -type d 2>/dev/null'
alias C='find ~/.config/ -type f -or -type l 2>/dev/null'
alias S='find ~/project/scripts/ -type f,l -not -path "*/.git/*" 2>/dev/null'
alias H='tac $HISTFILE'
alias D='find ~ -type d 2>/dev/null | grep -v "/\."'
alias M='cdr -l' # Mru
# alias D='' # Db's TODO

# Sinks
alias c='xclip -filter -rmlastnl -selection "clipboard"'
alias z='read input ; print -z "$input"'
alias d='read input ; cd "$input"'
# alias go-cdr="cut -d' ' -f1 | read input ; echo $input"
alias ve='read input ; $EDITOR "$input"'

# Compositions
alias h='H | fzf --tiebreak=index | z'
alias fcd='D | fzf | d'
# alias fr='M | fzf | go-cdr' # TODO

# Actual aliases
alias cut-space="cut -d' '"
alias cut-semicolon="cut -d';'"
alias cut-colon="cut -d':'"
alias cut-comma="cut -d','"
alias cut-tab="cut -d\t"
[ -x /usr/bin/trash-put ] && alias rm='trash-put'
alias android='jmtpfs /mnt/mtp ; cd /mnt/mtp'
alias keycodes='xmodmap -pke'
alias update-mirrors='sudo reflector --verbose --protocol http --latest 200 --sort rate --save /etc/pacman.d/mirrorlist'
# alias iex='rlwrap -afoo iex'
alias eupdate='sudo emaint sync -a && sudo layman -S'
alias eupgrade='emerge --update --deep --newuse --keep-going @world'
alias esearch='\emerge --searchdesc'
alias vbox-wangblows='VBoxManage startvm Windows'
alias dotgit='git --work-tree=$HOME --git-dir=$HOME/project/dotfiles/dotfiles-public'
alias dotgit-private='git --work-tree=$HOME --git-dir=$HOME/project/dotfiles/dotfiles-private'
alias etcgit-arch='git --work-tree=/etc --git-dir=$HOME/project/dotfiles/etc-arch'
alias etcgit-gentoo='git --work-tree=/etc --git-dir=$HOME/project/dotfiles/etc-gentoo'
alias edit-sleep='sudo -e /etc/systemd/sleep.conf'
alias random_string='tr -dc [:alnum:] < /dev/urandom | head -c50'

# Functions
f()
{
	search=$(echo $@ | tr ' ' '*')
	find -iname "*$search*"
}

try_source() {
    [ -r $1 ] && source $1
}

# # REPL System
# export repl_state=echo
# function repl_eval()
# {
# 	echo "$@"
# }
# function repl()
# {
#     # [ $repl_state=echo ] && echo 'Set $repl_state and define function repl_eval'
#     while { true } { printf "($repl_state)>" ; read line ; repl_eval "$line" }
# }

typeset -A key
key=(
	BackSpace  "${terminfo[kbs]}"
	Home       "${terminfo[khome]}"
	End        "${terminfo[kend]}"
	Insert     "${terminfo[kich1]}"
	Delete     "${terminfo[kdch1]}"
	Up         "${terminfo[kcuu1]}"
	Down       "${terminfo[kcud1]}"
	Left       "${terminfo[kcub1]}"
	Right      "${terminfo[kcuf1]}"
	PageUp     "${terminfo[kpp]}"
	PageDown   "${terminfo[knp]}"
)

# rc
eval $(dircolors)
p=~/.cache/wal/colors.sh
[[ -r $p ]] && source $p
p=~/.cache/wal/sequences
[[ -r $p ]] && cat $p

# vim edit
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd " e" edit-command-line

# ignore interactive comments
set -k

#man for last cmd
bindkey -M vicmd " m" man

## Vi beam on insert
# Remove mode switching delay.
#KEYTIMEOUT=5
# Change cursor shape for different vi modes.
# function zle-keymap-select {
#     if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
# 		    echo -ne '\e[1 q'
#     elif [[ ${KEYMAP} == main ]] ||
#     	[[ ${KEYMAP} == viins ]] ||
#     	[[ ${KEYMAP} = '' ]] ||
#     	[[ $1 = 'beam' ]]; then
#     	echo -ne '\e[5 q'
#     fi
# }
# zle -N zle-keymap-select

# # Use beam shape cursor on startup.
# print -Pn '\e[5 q'
# precmd() {
# 	# Use beam shape cursor for each new prompt.
# 	echo -ne '\e[5 q'
# 	# set title
# 	print -Pn "\e]0;zsh\a" 
# }

# History
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -- "$key[Up]"   up-line-or-beginning-search
bindkey -- "$key[Down]" down-line-or-beginning-search
bindkey -- "^P"   up-line-or-beginning-search
bindkey -- "^N" down-line-or-beginning-search
bindkey "^R" history-incremental-search-backward

# rehash on completion
# zstyle ':completion:*' rehash true

# activate help
autoload -Uz run-help
# unalias run-help
alias help=run-help
zle -N man

# The following lines were added by compinstall
zstyle ':completion:*' auto-description '%d'
zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format '%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true

autoload -Uz compinit
compinit -d $HOME/.cache/zcompdump-$ZSH_VERSION

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

#Directory remember
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':chpwd:*' recent-dirs-max 40
zstyle ':chpwd:*' recent-dirs-file ~/.local/history/chpwd-recent-dirs

#cd $(head -1 ~/.chpwd-recent-dirs | cut -c2-) # TODO

setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE

setopt autocd
setopt beep
setopt extendedglob
setopt notify
unsetopt nomatch
# setopt PRINT_EXIT_VALUE

# bindkey -v

# if [[ $1 == eval ]]
# then
#     "$@"
# set --
# fi

source ~/.config/zsh/zsh-vim-mode.plugin.zsh

# Cursor
MODE_CURSOR_DEFAULT="blinking bar"
MODE_CURSOR_VICMD="steady block"
MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_SEARCH="steady underline"

MODE_INDICATOR_VIINS='I'
MODE_INDICATOR_VICMD='C'
MODE_INDICATOR_REPLACE='R'
MODE_INDICATOR_SEARCH='S'
MODE_INDICATOR_VISUAL='V'
MODE_INDICATOR_VLINE='V'

# Prompt
# setopt NO_prompt_subst
short_path()
{
	pwd | sed -e "s:^$HOME:/~:" -e 's/\/\./\//' | grep -o '/.' | sed 's:^/~:~:' | tr -d '\n'
}
[[ "$SSH_CONNECTION" == "" ]] || hostprompt="[$(hostname)]"
autoload -Uz promptinit
setopt PROMPT_SUBST
promptinit
PROMPT=$'%{\e[0;31;40m%}ᛃ %{\e[0;37;40m%}'
# RPROMPT=$'%{\e[0;33;40m%}$(short_path)%{\e[0;37;40m%} %{\e[0;31;40m%}[${MODE_INDICATOR_PROMPT}]%{\e[0;37;40m%}' # prompt with mode inidcator
RPROMPT=$'%{\e[0;33;40m%}$(short_path)%{\e[0;37;40m%} %{\e[0;31;40m%}$hostprompt%{\e[0;37;40m%}'
#  text-style--^  ^--text-color

# source =env_parallel.zsh

catch_signal_usr1() {
  trap catch_signal_usr1 USR1
  rehash
}
trap catch_signal_usr1 USR1

[ $(hostname) == machine1 ] \
    && zsh_synatx_hl=/usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh  # Gentoo
[ $(hostname) == machine2 ] \
    && zsh_synatx_hl=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # Arch
[ -f "$zsh_synatx_hl" ] && source $zsh_synatx_hl

try_source /usr/share/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh
try_source /usr/share/doc/pkgfile/command-not-found.zsh

p="$HOME/.local/share/nvim/site/autoload/plug.vim"
[ -r $p ] || curl -vfLo $p --create-dirs  \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# [[ $- == *i* ]] \
#     && [ -r ~/doc/todo/now.todo ] \
#     && echo TODO: && cat ~/doc/todo/now.todo
