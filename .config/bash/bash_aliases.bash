alias ali="$EDITOR ~/.config/bash/bash_aliases.bash"
alias bashrc="$EDITOR ~/.bashrc"
alias cat='ccat'
alias c='clear'
alias csj="cd ~/Documents/CS/Java"
alias Gr="cd ~/Work/Graphics/"
alias grep='grep --color=auto'
alias i3conf="$EDITOR ~/.config/i3/config"
alias kr="$EDITOR ~/.config/kitty/kitty.conf"
alias ls='ls --color=auto'
alias ms="mutt -F ~/.config/mutt/account1.gmail"
alias mutt='neomutt'
alias muttrc="cd ~/.config/mutt/;$EDITOR ~/.config/mutt/account1.gmail"
alias mw="mutt -F ~/.config/mutt/account2.gmail"
alias nani="echo 'Omae Wa Mou Shindeiru'"
alias pac='sudo pacman -Syu'
alias pc='sudo pacman'
alias q='exit'
alias rmc="rm *.class"
alias rmswp="rm ~/.cache/vim/swap/*;rm ~/.local/share/nvim/swap/*"
alias scan="cd ~/Pictures/Scans;hp-scan -d 'hpaio:/net/ENVY_7640_series?ip=192.168.1.11'"
alias se="fzf | xargs -r $EDITOR"
alias sv="sudoedit"
alias tmux='TERM=tmux-256color tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias trc='$EDITOR $XDG_CONFIG_HOME/tmux/tmux.conf'
alias vim="$EDITOR"
alias vimrc="$EDITOR ~/.config/nvim/init.vim"
alias virc="vi ~/.vim/vimrc"
alias vi="/usr/bin/vim -u ~/.vim/vimrc"
alias wd="cd ~/Work/docs/"
alias ytd="youtube-dl -f bestaudio"

# pacman
alias plist="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias ylist="yay -Slq | fzf -m --preview 'yay -Si {1}'| xargs -ro yay -S"
alias ylrem="yay -Qeq | fzf -m --preview 'yay -Qi {1}' | xargs -ro yay -Rs"


# Language aliases
# alias rb='ruby'
alias py='python'
# alias ipy='ipython'

#CD
alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

# Shell History
alias h='history'

# Directory
alias md='mkdir -p'
alias rd='rmdir'

# List directory contents
alias sl=ls
alias la='ls -AF'       # Compact view, show hidden
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'

case $OSTYPE in
  linux*)
    XCLIP=$(command -v xclip)
    [[ $XCLIP ]] && \
    alias pbcopy="$XCLIP -selection clipboard" && \
    alias pbpaste="$XCLIP -selection clipboard -o"
    ;;   
esac

# Aliases for git
alias gcl='git clone'
alias ga='git add'
alias grm='git rm'
alias gap='git add -p'
alias gall='git add -A'
alias gf='git fetch --all --prune'
alias gft='git fetch --all --prune --tags'
alias gfv='git fetch --all --prune --verbose'
alias gftv='git fetch --all --prune --tags --verbose'
alias gus='git reset HEAD'
alias gpristine='git reset --hard && git clean -dfx'
alias gclean='git clean -fd'
alias gm="git merge"
alias gmv='git mv'
alias g='git'
alias get='git'
alias gs='git status'
alias gss='git status -s'
alias gsu='git submodule update --init --recursive'
alias gl='git pull'
alias glum='git pull upstream master'
alias gpr='git pull --rebase'
alias gpp='git pull && git push'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gpo='git push origin HEAD'
alias gpu='git push --set-upstream'
alias gpuo='git push --set-upstream origin'
alias gpuoc='git push --set-upstream origin $(git symbolic-ref --short HEAD)'
alias gpom='git push origin master'
alias gr='git remote'
alias grv='git remote -v'
alias gra='git remote add'
alias gd='git diff'
alias gds='git diff --staged'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -v -m'
alias gcam="git commit -v -am"
alias gci='git commit --interactive'
alias gcamd='git commit --amend'
alias gb='git branch'
alias gba='git branch -a'
alias gbt='git branch --track'
alias gbm='git branch -m'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpx='git cherry-pick -x'
alias gco='git checkout'
alias gcom='git checkout master'
alias gcb='git checkout -b'
alias gcob='git checkout -b'
alias gct='git checkout --track'
alias gcpd='git checkout master; git pull; git branch -D'
alias gexport='git archive --format zip --output'
alias gdel='git branch -D'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gsl="git shortlog -sn"
alias gwc="git whatchanged"
alias gt="git tag"
alias gta="git tag -a"
alias gtd="git tag -d"
alias gtl="git tag -l"
alias gpatch="git format-patch -1"
# From http://blogs.atlassian.com/2014/10/advanced-git-aliases/
# Show commits since last pull
alias gnew="git log HEAD@{1}..HEAD@{0}"
# Add uncommitted and unstaged changes to the last commit
alias gcaa="git commit -a --amend -C HEAD"
alias ggui="git gui"
alias gcsam="git commit -S -am"
alias gst="git stash"
alias gstb="git stash branch"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"
# alias gh='cd "$(git rev-parse --show-toplevel)"'
# Show untracked files
alias gu='git ls-files . --exclude-standard --others'

case $OSTYPE in
  darwin*)
    alias gtls="git tag -l | gsort -V"
    ;;
  *)
    alias gtls='git tag -l | sort -V'
    ;;
esac
