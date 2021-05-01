call plug#begin('~/.vim/plugged') "I use vim too so it's better to keep them in one place
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'KarlWithK/gruvbox' "Theme
Plug 'tpope/vim-surround' "Allows me to change { to [ and what not
Plug 'jiangmiao/auto-pairs'
Plug 'dpelle/vim-LanguageTool'
call plug#end()

set laststatus=0
set noshowmode "make the current mode label disappear - airline has this
" set termguicolors "True colors term support
let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }


let mapleader = ","
imap <leader>w <C-w>
nmap <leader>P "+gP
nmap <leader>p "+gp
nmap <leader>z [s1z=
nmap <expr> j (v:count? 'j' : 'gj')
nmap <expr> k (v:count? 'k' : 'gk')
nmap <leader><cr> o<Esc>
nmap Y y$
imap jk <Esc>
xmap <leader>y "*y :let @+=@*<cr>
nmap <leader>3 :retab<cr>:FixWhitespace<cr>
nmap <leader>5 :call SpellToggle()<cr>
let g:gruvbox_contrast_dark='hard' "dark mode
let g:gruvbox_invert_selection='0' "No highlight
let g:gruvbox_italic='1' "enable italics
let g:languagetool_cmd='/usr/bin/languagetool'
let g:languagetool_lang='en-US'
runtime myhighlights.vim
colorscheme gruvbox "colorscheme

function! SpellToggle()
    if &spell
      setlocal spell! spelllang&
    else
      setlocal spell spelllang=en_us
    endif
endfunction

command! FixWhitespace :%s/\s\+$//e
au BufEnter *.txt set filetype=text
au BufEnter github.com_*.txt set filetype=markdown

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
