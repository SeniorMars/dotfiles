# Man stuff
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;9m'   # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[01;33m'       # begin standout-mode - info box
setenv LESS_TERMCAP_us \e'[04;38;5;10m'  # begin underline
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
 
# Set fish to use vi key bindings
set -g fish_key_bindings hybrid_bindings
set fish_key_bindings fish_user_key_bindings

# fzf
setenv FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix'
setenv FZF_CTRL_T_COMMAND 'fd -t f --follow --exclude ".git" . /Users/charlie'
setenv FZF_DEFAULT_OPTS '--height 20%'

set -gx SHELL /opt/homebrew/bin/fish
source ~/.config/fish/abr.fish # abbrs / alias
zoxide init fish | source
atuin init fish | source
