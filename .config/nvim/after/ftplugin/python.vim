setlocal textwidth=79 
setlocal fileformat=unix
autocmd BufWritePre <buffer> :FixWhitespace
noremap <buffer> <leader>9 <Esc>:w<cr>:!clear;python %<cr>
