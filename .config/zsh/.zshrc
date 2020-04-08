[[ $- != *i* ]] && return
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# The following lines were added by compinstall
# zstyle :compinstall filename '/home/karl/.config/zsh/zshrc'
export ZSH="/home/karl/.config/zsh/"
export ZLE_RPROMPT_INDENT=0
export KEYTIMEOUT=1
HISTFILE=~/.local/share/history
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob GLOB_COMPLETE
unsetopt beep
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
compinit
_comp_options+=(globdots)	

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to change how often to auto-update (in days)
export UPDATE_ZSH_DAYS=30

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
plugins=(git archlinux command-not-found common-aliases sudo vi-mode fzf zsh-syntax-highlighting you-should-use) 
source $ZSH/oh-my-zsh.sh

# User configuration
alias -g gs="git status"
[ -f ~/.config/profile/aliases ] && source $HOME/.config/profile/aliases
# source $HOME/.config/zsh/custom/agnosterBetter.zsh
[ -f ~/.config/zsh/custom/fzf.zsh ] && source ~/.config/zsh/custom/fzf.zsh

# p10k 
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
