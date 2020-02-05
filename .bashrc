# ____    _    ____  _   _ ____   ____ 
#| __ )  / \  / ___|| | | |  _ \ / ___|
#|  _ \ / _ \ \___ \| |_| | |_) | |    
#| |_) / ___ \ ___) |  _  |  _ <| |___ 
#|____/_/   \_\____/|_| |_|_| \_\\____|
#

set -o vi #vim mode
bind -m vi-insert "\C-l":clear-screen
stty -ixon #disable ctrl-s and ctrl-q

# set custom things
export EDITOR="nvim"
export TERMINAL="konsole"
export BROWSER="firefox" 
export READER="zathura"
export TERMBROWSER="w3m"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export GREP_COLOR='1;33'
# export PATH="$HOME/.cargo/bin:$PATH"

#man 
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

#prompt
export PS1="\[\e[31m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[34m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\] \[\e[35m\]\w\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ "

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
# eval $(thefuck --alias) #enable fuck

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export THEME=$HOME/.bash/agnoster.bash
if [[ -f $THEME ]]; then
    export DEFAULT_USER=``
    source $THEME
fi

# source ~/.bash/alias_completion.bash
# source ~/.bash/gitps1.bash
