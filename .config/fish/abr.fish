# these are abreviations for fish shell
function last_history_item; echo $history[1]; end
abbr -a !! --position anywhere --function last_history_item

abbr -a dotfiles '/usr/bin/git --git-dir=/Users/charlie/Work/dotfiles/.git --work-tree=$HOME/'

abbr -a ali '$EDITOR ~/.config/fish/abr.fish'
abbr -a alr '$EDITOR ~/.config/alacritty/alacritty.yml'
abbr -a cat ccat
abbr -a grep 'grep --color=auto'
abbr -a glp "git log --graph --pretty=format:'%C(yellow)%h%C(auto)%d%Creset %s %C(white)- %an, %ar%Creset'"
abbr -a gla 'git log --all --graph --decorate --oneline'
abbr -a muttrc 'cd ~/.config/mutt/;$EDITOR ~/.config/mutt/muttrc'
abbr -a python python3
abbr -a se 'fzf | xargs -r $EDITOR'
abbr -a sv sudoedit
abbr -a tiny 'tiny -c ~/.config/tiny/config.yml'
abbr -a vim $EDITOR
abbr -a vimrc '$EDITOR ~/.config/nvim/init.lua'
abbr -a fishrc '$EDITOR ~/.config/fish/config.fish'

# # Directory
abbr -a md mkdir -p
abbr -a rd rmdir

# # List directory contents
abbr -a ls exa
abbr -a sl exa
abbr -a la exa -aF
abbr -a ll exa -al
abbr -a l exa -a
abbr -a l1 exa -1

abbr -a q exit
abbr -a yr 'cal -y'
abbr -a mr 'neomutt'
abbr -a c cargo
abbr -a ct 'cargo t'
abbr -a cb 'cargo b'
abbr -a e nvim
abbr -a m make
abbr -a o open
abbr -a g git
abbr -a gc 'git checkout'
abbr -a ga 'git add -p'
abbr -a vimdiff 'nvim -d'
abbr -a gah 'git stash; and git pull --rebase; and git stash pop'
abbr -a pr 'gh pr create -t (git show -s --format=%s HEAD) -b (git show -s --format=%B HEAD | tail -n+3)'
abbr -a backup 'restic --repo /Volumes/backup/tetra_backup/ backup ~ --exclude-file=/Users/charlie/.config/rclone/exclude_backup'
