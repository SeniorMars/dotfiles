# ____    _    ____  _   _ ____   ____ 
#| __ )  / \  / ___|| | | |  _ \ / ___|
#|  _ \ / _ \ \___ \| |_| | |_) | |    
#| |_) / ___ \ ___) |  _  |  _ <| |___ 
#|____/_/   \_\____/|_| |_|_| \_\\____|
#
                                      

set -o vi #vim mode
# set custom things
export EDITOR="nvim"
export TERMINAL="konsole"
export BROWSER="firefox" 
export READER="zathura"
export TERMBROWSER="w3m"
export PS1="\[\e[31m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[34m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\] \[\e[35m\]\w\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ "

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

stty -ixon #disable ctrl-s and ctrl-q

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Alias definitions in bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

#Extra Stuff
eval "$(thefuck --alias)" # enable fuck

# Path to the bash it configuration
export BASH_IT="/home/karl/Downloads/bash-it"
export SCM_CHECK=true #check version control status
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1
source "$BASH_IT"/bash_it.sh


export THEME=.bash/agnoster.bash
if [[ -f $THEME ]]; then
    export DEFAULT_USER=``
    source $THEME
fi

# source ~/.bash/gitps1.bash
