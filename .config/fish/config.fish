source ~/.config/profile/aliases
abbr -a yr 'cal -y'
abbr -a mr 'neomutt'
abbr -a c cargo
abbr -a e nvim
abbr -a m make
abbr -a o open
abbr -a g git
abbr -a gc 'git checkout'
abbr -a ga 'git add -p'
abbr -a vimdiff 'nvim -d'
abbr -a ct 'cargo t'
abbr -a gah 'git stash; and git pull --rebase; and git stash pop'
abbr -a pr 'gh pr create -t (git show -s --format=%s HEAD) -b (git show -s --format=%B HEAD | tail -n+3)'
abbr -a backup 'restic --repo /Volumes/backup/tetra_backup/ backup ~ --exclude-file=/Users/karl/.config/rclone/exclude_backup'
set FISH_CLIPBOARD_CMD "cat"

# Man stuff
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;9m'   # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[01;33m'       # begin standout-mode - info box
setenv LESS_TERMCAP_us \e'[04;38;5;10m'  # begin underline
setenv LESS_TERMCAP_ue \e'[0m'           # end underline

# fzf
setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_ALT_C_COMMAND "$FZF_CTRL_T_COMMAND"
setenv FZF_CTRL_T_COMMAND "fd -t d --hidden --follow --exclude \".git\" . $HOME"
setenv FZF_DEFAULT_OPTS '--height 20%'

set -g fish_key_bindings hybrid_bindings
set fish_key_bindings fish_user_key_bindings
if status is-interactive
	if ! set -q TMUX
		exec tmux
	end
end

zoxide init fish | source
source /opt/homebrew/opt/asdf/libexec/asdf.fish
test -e ~/.config/iterm2/iterm2_shell_integration.fish ; and source ~/.config/iterm2/iterm2_shell_integration.fish
