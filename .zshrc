# KEY
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

fpath=(~/.config/zsh/zshfunctions $fpath)

export PATH="$PATH:$HOME/.local/bin:$HOME/.local/node_modules/.bin/:$HOME/.local/node_modules/bin/"
export TERMINAL=urxvt
export EDITOR=nvim
export VISUAL=$EDITOR
export BROWSER=firefox
export PAGER='less'

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export MANPAGER='nvim -R +":set ft=man" -'
export MANPATH=:/home/user1/.local/surf/
export GOPATH=$HOME/.cache/go
export npm_config_prefix="$HOME/.local/node_modules"
export FZF_DEFAULT_OPTS="--layout=reverse"
export HISTFILE=~/.local/history/zsh_history
export HISTSIZE=10000000000000
export SAVEHIST=10000000000000


#	 
#	        |_)            
#	   _` | | |  _` |  __| 
#	  (   | | | (   |\__ \ 
#	 \__,_|_|_|\__,_|____/ 
#	                       
#

# Default flags (interactive shell only)
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ls='ls --color=auto'
alias mpv='mpv --audio-display=no'
alias ffmpeg='ffmpeg -hide_banner'
alias ffplay='ffprobe -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias emerge='sudo emerge --ask'

# Shortcuts
alias S="yay -S"
alias v=$EDITOR
alias l='ls -CF1 --group-directories-first'
alias ll='ls -lhF --group-directories-first'
alias la='l -A'
alias lla='ll -A'
alias t='v ~/doc/todo/now.todo'
alias T='v ~/doc/todo/project.todo'
alias tg='telegram-cli -NfW'
alias py=python
alias md='mkdir -p'
alias xo='xdg-open'
alias hl='highlight --out-format=xterm256'

# Sources
alias U='find ~/project/ucll1920/sem1/ -type d 2>/dev/null'
alias C='find ~/.config/ -type f -or -type l 2>/dev/null'
alias H='tac $HISTFILE'
alias D='find ~ -type d 2>/dev/null | grep -v "/\."'
alias M='cdr -l' # Mru
# alias D='' # Db's TODO

# Sinks
alias c='xclip -selection "clipboard"'
alias z='read input ; print -z "$input"'
alias d='read input ; cd "$input"'
alias ve='read input ; $EDITOR "$input"'

# Compositions
alias cfg='C | fzf | ve'
alias h='H | fzf | z'
alias cdd='D | fzf | d'
alias m='M | fzf | cdr'

# Actual aliases
alias keycodes='xmodmap -pke'
alias update-mirrors='sudo reflector --verbose --protocol http --latest 200 --sort rate --save /etc/pacman.d/mirrorlist'
alias iex='rlwrap -afoo iex'
alias eupgrade='emerge --sync && emerge -uDU --keep-going --with-bdeps=y @world'
alias vbox-wangblows='VBoxManage startvm Windows'
alias dotgit='git --work-tree=$HOME --git-dir=$HOME/project/dotfiles/dotfiles-public'
alias dotgit-private='git --work-tree=$HOME --git-dir=$HOME/project/dotfiles/dotfiles-private'

# Functions
f()
{
	search=$(echo $@ | tr ' ' '*')
	find -iname "*$search*"
}

# rc
eval $(dircolors)
#source /usr/share/doc/pkgfile/command-not-found.zsh
p1=~/.cache/wal/colors-tty.sh
p2=~/.cache/wal/sequences
[[ -r $p1 ]] && source $p1
[[ -r $p2 ]] && cat $p2

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
# zstyle :compinstall filename '/home/user1/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

#Directory remember
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection

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

[ $(hostname) == machine1 ] && plugindir=/usr/share/zsh/site-contrib # Gentoo
[ $(hostname) == machine2 ] && plugindir=/usr/share/zsh/plugins # Arch

[ -f $plugindir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] \
    && source $plugindir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh




