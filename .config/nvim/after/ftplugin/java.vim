setlocal makeprg=javac\ %
noremap <buffer> <localleader>8 <Esc>:w<cr>:make<cr>:copen<cr>
noremap <buffer> <localleader>6 :cprevious<cr>
noremap <buffer> <localleader>7 :cnext<cr>
noremap <buffer> <localleader>9 :!clear;echo;echo %\|awk -F. '{print $1}'\|xargs java<cr>
