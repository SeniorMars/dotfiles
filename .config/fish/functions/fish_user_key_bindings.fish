function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# function scroll-and-clear-screen
#     printf '\n%.0s' (seq 2 $LINES)
#     clear
#     commandline -f repaint
# end

function fish_user_key_bindings
    fzf_key_bindings
    fish_vi_key_bindings
    bind -M insert j 'commandline -P; and down-or-search; or commandline -i j'
    bind -M insert k 'commandline -P; and up-or-search; or commandline -i k'
    bind -M insert h 'commandline -P; and commandline -f backward-char; or commandline -i h'
    bind -M insert l 'commandline -P; and commandline -f forward-char; or commandline -i l'
    bind -M insert -k nul accept-autosuggestion
    bind -M insert \cp history-search-backward
    bind -M insert \cn history-search-forward
    bind -M insert \cz 'fg; commandline -f repaint'
    bind -M insert \co 'yy;commandline -f repaint'
    bind -M insert \cr _atuin_search
    bind -M insert \ce fzf-cd-widget
    bind -M insert \ct fzf-file-widget
end
