setlocal textwidth=79 
setlocal fileformat=unix
autocmd BufWritePre <buffer> call FixWhitespace()
noremap <buffer> <localleader>9 <Esc>:w<cr>:!clear;python %<cr>
