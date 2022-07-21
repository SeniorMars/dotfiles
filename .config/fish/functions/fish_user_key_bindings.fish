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

function fish_user_key_bindings
	fish_vi_key_bindings
	bind -M insert j 'commandline -P; and down-or-search; or commandline -i j'
	bind -M insert k 'commandline -P; and up-or-search; or commandline -i k'
	bind -M insert h 'commandline -P; and commandline -f backward-char; or commandline -i h'
	bind -M insert l 'commandline -P; and commandline -f forward-char; or commandline -i l'
	bind -M insert \cp history-search-backward
	bind -M insert \cn history-search-forward
	bind -M insert \cz 'fg; commandline -f repaint'
	bind -m insert \co 'ranger-cd;commandline -f repaint'                                           
	bind -M insert -k nul accept-autosuggestion
	bind -m default \cl edit_command_buffer
end

fzf_key_bindings
