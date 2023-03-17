function ranger-cd                                                               
	set tempfile '/tmp/chosendir'                                                  
	ranger --choosedir=$tempfile (pwd)                                    

	if test -f $tempfile                                                           
		if [ (cat $tempfile) != (pwd) ]                                            
			cd (cat $tempfile)                                                       
		end                                                                        
	end                                                                            

	rm -f $tempfile                                                                
end                                                                              

function scroll-and-clear-screen # kitty does weird things with clear
    printf '\n%.0s' (seq 2 $LINES)
    clear
    commandline -f repaint
end

function fish_user_key_bindings
	fzf_key_bindings
	fish_vi_key_bindings
	bind \el 'commandline -f repaint'
	bind \cl scroll-and-clear-screen
	bind -M insert j 'commandline -P; and down-or-search; or commandline -i j'
	bind -M insert k 'commandline -P; and up-or-search; or commandline -i k'
	bind -M insert h 'commandline -P; and commandline -f backward-char; or commandline -i h'
	bind -M insert l 'commandline -P; and commandline -f forward-char; or commandline -i l'
	bind -M insert -k nul accept-autosuggestion
	bind -M insert \cp history-search-backward
	bind -M insert \cn history-search-forward
	bind -M insert \cz 'fg; commandline -f repaint'
	bind -M insert \co 'ranger-cd;commandline -f repaint'                                           
	bind -M insert \cr _atuin_search
	bind -M insert \el 'commandline -f repaint'
	bind -M visual \el 'commandline -f repaint'
	bind -M insert \cl scroll-and-clear-screen
	bind -M visual \cl scroll-and-clear-screen
	bind -M insert \ce fzf-cd-widget
	bind -M insert \ct fzf-file-widget
end
