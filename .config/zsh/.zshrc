[[ $- != *i* ]] && return

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# exports
export ZSH="/home/karl/.config/zsh/"
export UPDATE_ZSH_DAYS=30
export ZLE_RPROMPT_INDENT=0
export KEYTIMEOUT=1

# Plugins
plugins=(git archlinux common-aliases sudo vi-mode zsh-syntax-highlighting you-should-use) 
source $ZSH/oh-my-zsh.sh

# User configuration
[ -f ~/.config/profile/aliases ] && source $HOME/.config/profile/aliases
# source $HOME/.config/zsh/custom/agnosterBetter.zsh # another theme I had
[ -f ~/.config/zsh/custom/fzf.zsh ] && source ~/.config/zsh/custom/fzf.zsh

# p10k 
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Other settings
HISTFILE=~/.local/share/history
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob GLOB_COMPLETE
unsetopt beep
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
_comp_options+=(globdots)	
compinit

# vi keys when tab complete
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
