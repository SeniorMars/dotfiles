# personal variables school
export BROWSER="firefox" 
export COLORTERM="truecolor"
export TERM="xterm-256color"
export EDITOR="nvim"
export VISUAL="nvim"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND="$FZF_CTRL_T_COMMAND"
export FZF_CTRL_T_COMMAND="fd -t d --hidden --follow --exclude \".git\" . $HOME"
export READER="zathura"
export TERMBROWSER="lynx"
export TERMINAL="alacritty"

# enviroment variables
export GPG_TTY=$(tty)
export WINEPREFIX=~/.local/share/wine
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export GREP_COLOR='1;33'
export LESSHISTFILE="-"
export CM_LAUNCHER=rofi
export WGETRC="$HOME/.config/wget/wgetrc"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export ZSH_TMUX_CONFIG="$XDG_CONFIG_HOME"/tmux/tmux.conf
export ZSH=$XDG_CONFIG_HOME/zsh
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export GTK_THEME=Sweet-Dark
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_PATH="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export GOPATH="$XDG_DATA_HOME"/go
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython
export PLTUSERHOME="$XDG_DATA_HOME"/racket
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export NPM_HOME="$XDG_DATA_HOME/npm"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/password-store

# man
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[01;38;5;9m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[38;5;7m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[04;38;5;10m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"

# path
export PATH="$PATH:$HOME/.local/bin:$GOPATH/bin:$GEM_HOME/ruby/2.7.0/bin:$GEM_HOME/bin:$CARGO_HOME/bin:$NPM_HOME/bin:" 

# startx
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  ssh-agent startx 
fi
