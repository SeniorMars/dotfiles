# ____    _    ____  _   _ ____   ____
#| __ )  / \  / ___|| | | |  _ \ / ___|
#|  _ \ / _ \ \___ \| |_| | |_) | |
#| |_) / ___ \ ___) |  _  |  _ <| |___
#|____/_/   \_\____/|_| |_|_| \_\\____|
#


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi #vim mode
bind -m vi-insert "\C-l":clear-screen
stty -ixon #disable ctrl-s and ctrl-q
setxkbmap -option caps:escape

#prompt
export PS1="\[\e[31m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[34m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\] \[\e[35m\]\w\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ "

#man
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export THEME=$HOME/.config/bash/agnoster.bash
if [[ -f $THEME ]]; then
    export DEFAULT_USER=``
    source $THEME
fi

# Alias definitions in bash_aliases
if [ -f $HOME/.config/bash/bash_aliases.bash ]; then
    . $HOME/.config/bash/bash_aliases.bash
fi

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

force_color_prompt=yes

# enable programmable completion features (you don't need to enable
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s autocd
shopt -s checkwinsize #check window size
shopt -s globstar # match files with **

# fzf
[ -f ~/.config/bash/fzf.bash ] && source ~/.config/bash/fzf.bash

# source /usr/share/nvm/init-nvm.sh
# source ~/.config/bash/alias_completion.bash
# source ~/.config/bash/gitps1.bash
