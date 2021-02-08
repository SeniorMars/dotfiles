compiler java
nmap <buffer> <leader>o6 <Plug>VimspectorContinue
nmap <buffer> <leader>o7 <Plug>VimspectorStepInto
nmap <buffer> <leader>o8 <Plug>VimspectorStepOver
nmap <buffer> <leader>o9 <Plug>VimspectorStepOut
nmap <buffer> <leader>o0 <Plug>VimspectorStop
nmap <buffer> <leader>oo <Plug>VimspectorToggleBreakpoint
noremap <buffer> <leader>7 :term java %<cr>
noremap <buffer> <leader>8 :w<cr>:make<cr>:cwindow<cr>
noremap <buffer> <leader>9 :!echo <C-r>=expand('%:r')<cr> \| xargs java<cr>
