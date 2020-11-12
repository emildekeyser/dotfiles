#        ::::::::: ::::::::  :::    ::: :::::::::   :::::::: 
#            :+: :+:    :+: :+:    :+: :+:    :+: :+:    :+: 
#          +:+  +:+        +:+    +:+ +:+    +:+ +:+         
#        +#+   +#++:++#++ +#++:++#++ +#++:++#:  +#+          
#      +#+           +#+ +#+    +#+ +#+    +#+ +#+           
#    #+#     #+#    #+# #+#    #+# #+#    #+# #+#    #+#     
#  ######### ########  ###    ### ###    ###  ########       

# {{{ env

export PATH="$HOME/.local/bin:$PATH"
fpath=(~/.config/zsh/functions $fpath)

# Programs
export TERMINAL=urxvt
export EDITOR=nvim
export VISUAL=$EDITOR
export BROWSER=brave
export PAGER='less'
export MANPAGER='nvim -R +":set ft=man" -'

# Paths
export XDG_DATA_DIRS=${XDG_DATA_DIRS=/usr/share:/usr/share/local}
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export ELINKS_CONFDIR=$XDG_CONFIG_HOME/elinks
export MAILDIR=$XDG_DATA_HOME/mail
export GOPATH=$XDG_CACHE_HOME/go:$HOME/project/go
export npm_config_prefix=$HOME/.local/node_modules
export HISTFILE=$HOME/.local/history/zsh_history
export MPD_HOST=$XDG_DATA_HOME/mpd/socket
export UNISON=$HOME/.local/unison
export LESSHISTFILE=$HOME/.local/history/less
export INPUTRC=$XDG_CONFIG_HOME/inputrc
export PYTHONSTARTUP=$XDG_CONFIG_HOME/pythonstartup.py
export XAUTHORITY=$XDG_CACHE_HOME/Xauthority
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/notmuch-config
export NMBGIT=$XDG_DATA_HOME/nmbug
export WEECHAT_HOME=$XDG_CONFIG_HOME/weechat
export MIX_HOME=$XDG_DATA_HOME/mix
export CCACHE_CONFIGPATH=$XDG_CONFIG_HOME/ccache.config
export CCACHE_DIR=$XDG_CACHE_HOME/ccache 
export PSQLRC=$XDG_CONFIG_HOME/pg/psqlrc
export PGPASSFILE=$XDG_CONFIG_HOME/pg/pgpass
export PGSERVICEFILE=$XDG_CONFIG_HOME/pg/pg_service.conf
export PSQL_HISTORY=$HOME/.local/history/psql
export RLWRAP_HOME=$HOME/.local/history
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export SQLITE_HISTORY=$HOME/.local/history/sqlite
export PASSWORD_STORE_DIR=$XDG_DATA_HOME/password-store
export DIANA_DOWNLOAD_DIR=$HOME/torrent
export WGETRC=$XDG_CONFIG_HOME/wgetrc
export CARGO_HOME=$XDG_DATA_HOME/cargo
export HEX_HOME=$XDG_CACHE_HOME/hex
export IPYTHONDIR=$XDG_DATA_HOME/ipython
export LEIN_HOME=$XDG_DATA_HOME/lein
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export RANDFILE=$XDG_CACHE_HOME/rnd
export GTK_RC_FILES=$XDG_CONFIG_HOME/gtk-1.0/gtkrc
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc

# Options
export DIANA_SECRET_TOKEN=386a2506-fcea-4c79-9206-8cd7e8c43cc7
export FZF_DEFAULT_OPTS="--layout=reverse"
export LESS='-R' # colors=always
export CLICOLOR_FORCE=1 # colors=always with tree
export PROGRESS_ARGS='--monitor-continuously --wait'
export ERL_AFLAGS="-kernel shell_history enabled"

case $(hostname)  in
    machine1)
        export ETH=eth0
        export WLAN=''
        ;;
    machine2)
        export ETH=enp2s0
        export WLAN=wlp0s18f2u1
        export YTFORMAT='--ytdl-format=worst'
        ;;
esac

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

# }}}
# {{{ functions and aliases

seds()
{
    sed 's/'$1'/'$2'/g'
}


awkp()
{
    i=${1:-1}
    awk '{print $'$i'}'
}

f()
{
	search=$(echo $@ | tr ' ' '*')
	find -iname "*$search*"
}

try_source()
{
    [ -r "$1" ] && source "$1"
}

source ~/.config/zsh/aliases

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

# }}}
# {{{ plugin options

# Cursor config (vim-plugin)
MODE_CURSOR_DEFAULT="blinking bar"
MODE_CURSOR_VICMD="steady block"
MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_SEARCH="steady underline"

# }}}
# {{{ rc

eval $(dircolors)
[[ -r ~/.cache/wal/sequences ]] && cat ~/.cache/wal/sequences
try_source ~/.cache/wal/colors.sh
try_source ~/.config/zsh/plugins/vi-increment.zsh
try_source ~/.config/zsh/plugins/vi-mode.zsh
try_source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh  # Gentoo
try_source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # Arch
try_source /usr/share/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh
try_source /usr/share/doc/pkgfile/command-not-found.zsh

# [[ $- == *i* ]] \ # check if interactive
#     && [ -r ~/doc/todo/now.todo ] \
#     && echo : && cat ~/doc/todo/now.todo

# }}}
# {{{ options

# Edit command line in $EDITOR.
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd "  " edit-command-line

# Ignore comments on interactive cli.
set -k

# History
export HISTSIZE=10000000000000
export SAVEHIST=10000000000000
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -- "$key[Up]"   up-line-or-beginning-search
bindkey -- "$key[Down]" down-line-or-beginning-search
bindkey -- "^P"   up-line-or-beginning-search
bindkey -- "^N" down-line-or-beginning-search
bindkey -- "^J" down-line-or-history
bindkey -- "^K" up-line-or-history
# bindkey "^R" history-incremental-search-backward

# Help
autoload -Uz run-help
alias help=run-help

# Completion
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
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history


# Compilation
autoload -Uz compinit
compinit -d $HOME/.cache/zcompdump-$ZSH_VERSION

# Directory stack
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':chpwd:*' recent-dirs-max 40
zstyle ':chpwd:*' recent-dirs-file ~/.local/history/chpwd-recent-dirs

# Misc
setopt autocd
setopt beep
setopt extendedglob
setopt notify
unsetopt nomatch
setopt PRINT_EXIT_VALUE

# Prompt
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

catch_signal_usr1() {
  trap catch_signal_usr1 USR1
  rehash
}
trap catch_signal_usr1 USR1

zle -N vi-increment vi-crement
zle -N vi-decrement vi-crement
for m in vicmd visual; do
	bindkey -M "$m" '^a' vi-increment
	bindkey -M "$m" '^x' vi-decrement
done

# if [[ $1 == eval ]]
# then
#     "$@"
# set --
# fi

# }}}

# vim:foldmethod=marker
# vim:foldlevel=0
