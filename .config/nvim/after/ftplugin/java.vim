setlocal makeprg=javac\ %
noremap <buffer> <leader>8 <Esc>:w<cr>:make<cr>:copen<cr>
noremap <buffer> <leader>6 :cprevious<cr>
noremap <buffer> <leader>7 :cnext<cr>
noremap <buffer> <leader>9 :!clear;echo;echo %\|awk -F. '{print $1}'\|xargs java<cr>
