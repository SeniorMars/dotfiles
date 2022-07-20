if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ $- != *i* ]] && return

# exports
export ZSH=$XDG_CONFIG_HOME/zsh
export UPDATE_ZSH_DAYS=30
export ZSH_AUTOSUGGEST_USE_ASYNC=0
ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZVM_CURSOR_STYLE_ENABLED=false
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git zsh-vi-mode tmux rust systemadmin common-aliases you-should-use)
source $ZSH/oh-my-zsh.sh

# load fzf binds
zvm_after_init_commands+=('[ -f $ZSH/fzf.zsh ] && source $ZSH/fzf.zsh')

# zoxide
eval "$(zoxide init zsh)"

# auto-suggestion
source /opt/homebrew/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
source /opt/homebrew/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# User configuration
[ -f ~/.config/profile/aliases ] && source $HOME/.config/profile/aliases
# source $HOME/.config/profile/agnosterBetter.zsh # another theme I had

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Other settings
HISTFILE=$XDG_DATA_HOME/history
HISTSIZE=1000
SAVEHIST=1000
setopt AUTOCD EXTENDEDGLOB GLOB_COMPLETE COMPLETE_ALIASES HIST_IGNORE_ALL_DUPS
unsetopt beep 
autoload -U compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
compinit
_comp_options+=(globdots)

# vi keys when tab complete
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# ranger
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /opt/homebrew/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

function source-asdf {
    if [ -f /opt/asdf-vm/asdf.sh ]; then
      export ASDF_DIR=/opt/asdf-vm
      export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME"/asdf/asdfrc
      export ASDF_DATA_DIR="$XDG_DATA_HOME"/asdf
      export ASDF_COMPLETIONS=/usr/share/zsh/site-functions/_asdf
      source $ASDF_DIR/asdf.sh
    fi
}

bindkey -s '^O' 'ranger-cd\n'
bindkey -s '^z' 'fg\n'
bindkey -s '^q' 'source-asdf\n'
bindkey '^ ' forward-char
bindkey -M vicmd 'L' edit-command-line
alias rm="rm"
