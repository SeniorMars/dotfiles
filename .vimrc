"plugins!  set nocompatible              " be improved, required
let g:polyglot_disabled = ['latex'] "allow vimtex to work
filetype off                  " required

" set the run time path to include Bundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"~~~~~~~~~~~~~~" Plugins here
Plugin 'VundleVim/Vundle.vim' "vundle plguin mngr
Plugin 'mattn/emmet-vim' "emmet for vim.
Plugin 'jiangmiao/auto-pairs' "auto completes [] and ()
Plugin 'sheerun/vim-polyglot' "vim syntax for different languages
Plugin 'vim-airline/vim-airline' "airline see bottom of bar
Plugin 'vim-airline/vim-airline-themes' "airline theme theme
Plugin 'powerline/fonts' "powerline fonts
Plugin 'wellle/targets.vim' "adds more targets like [ or ,
Plugin 'Yggdroot/indentLine' "indent lines like atom. See python file for ex
Plugin 'mbbill/undotree' "undo tree to see recent changed
Plugin 'tpope/vim-fugitive' "git control to vim
Plugin 'gko/vim-coloresque' "css html color highlighting
Plugin 'SirVer/ultisnips' "Track the engine.
Plugin 'honza/vim-snippets' " Snippets are separated from the engine
Plugin 'Chiel92/vim-autoformat' "autoformat
Plugin 'lervag/vimtex' "To use latex better

call vundle#end()            " required - all plugins must be before this line!

"second plugin mgnr just in case
execute pathogen#infect()


"Global settings!
filetype plugin indent on    " required
syntax on "activates syntax highlighting among other things
set hidden "work with multiple unsaved buffers.
set backspace=indent,eol,start "Fixes the backspace
set incsearch "highlights as you search
set rnu "sets line numbers
set foldmethod=indent "fold your code.
set foldlevel=99
set encoding=utf-8 "required by YCM
set noshowmode "make the current mode label disappear - I have airline for this.
set runtimepath^=~/.vim/bundle/ctrlp.vim "Allows ctrl p to work
set conceallevel=1

"Key remapping
let mapleader = ","
noremap <leader>s :source ~/.vimrc<cr>
noremap <leader>x :UndotreeToggle<cr>
noremap <leader>q :NERDTreeToggle<CR>
noremap <leader>w <C-w><C-w>
noremap <leader>z [s1z=
noremap <leader>p "+p
noremap <leader>P "+P
noremap <space> za
noremap <CR> o<Esc>
inoremap jk <Esc>
inoremap <C-k> <Esc>O<Esc>jA
vnoremap <leader>y "*y :let @+=@*<cr>
map <leader>1 :bn<cr>
map <leader>2 :bp<cr>
map <leader>3 :retab<cr>
map <leader>4 :Autoformat<CR>
map <leader>5 :setlocal spell spelllang=en_us<cr>

"Extra
let g:airline_powerline_fonts = 1
let g:powerline_pycmd="py3"
let g:airline#extensions#tabline#enabled = 1 "airline thing
let g:user_emmet_leader_key='<leader>'

" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

"vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:indentLine_setConceal = 0
let g:tex_conceal='abdmg'

"Java Support!
autocmd Filetype java set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
autocmd FileType java noremap <buffer> <leader>8 :make<return>:copen<return>
autocmd FileType java noremap <buffer> <leader>6 :cprevious<Return>
autocmd FileType java noremap <buffer> <leader>7 :cnext<Return>
autocmd FileType java noremap <buffer> <leader>9 :!echo %\|awk -F. '{print $1}'\|xargs java<return>

"python Support!
autocmd FileType python noremap <buffer> <leader>9 <Esc>:w<CR>:!clear;python %<CR>
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set textwidth=79
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix
autocmd BufWritePre *.py :%s/\s\+$//e

" Full stack development
au BufNewFile,BufRead *.js,*.html,*.css set tabstop=2
au BufNewFile,BufRead *.js,*.html,*.css set softtabstop=2
au BufNewFile,BufRead *.js,*.html,*.css set shiftwidth=2
au BufNewFile,BufRead *.js,*.html,*.css set expandtab
au BufNewFile,BufRead *.js,*.html,*.css set autoindent

" skeletons!
autocmd BufNewFile *.tex r ~/.vim/templates/skeleton.tex
