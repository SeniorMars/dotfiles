# Setup fzf
# ---------
if [[ ! "$PATH" == */home/karl/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/karl/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/karl/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/karl/.fzf/shell/key-bindings.bash"
