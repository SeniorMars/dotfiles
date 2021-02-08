setlocal textwidth=79 
setlocal fileformat=unix
autocmd BufWritePre <buffer> :FixWhitespace
noremap <buffer> <leader>8 <Esc>:w<cr>:term ipython %<cr>
noremap <buffer> <leader>9 <Esc>:w<cr>:!python %<cr>
