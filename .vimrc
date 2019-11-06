syntax on "activates syntax highlighting among other things
syntax enable

" activates filetype detection
filetype plugin indent on

set hidden "work with mutiple unsaved buffers.
set backspace=indent,eol,start "Fixes the backspace 

"sets line numbers
set number

"other stuff
set nocp "meant to fix syntax on
set encoding=utf-8 "required by YCM

"plugin shit

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"
"~~~~~~~~~~~~~~" Plugins here
Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'sheerun/vim-polyglot'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'powerline/fonts'
Plugin 'wellle/targets.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'mbbill/undotree'
Plugin 'tpope/vim-fugitive'
Plugin 'gko/vim-coloresque'
Plugin 'metakirby5/codi.vim'

"All of your Plugins must be added before the following line
call vundle#end()            " required

"second vim plugin just in case
execute pathogen#infect()

set noshowmode "make the current mode label dissappear - I have airline for this.

filetype plugin indent on    " required 


"Key remapings
let mapleader = ","
noremap <Leader>x :x<cr>
noremap <Leader>l :UndotreeToggle<cr>
nmap <CR> o<Esc>
inoremap jk <Esc>
inoremap <C-k> <Esc>O<Esc>jA
vnoremap <Leader>y "*y :let @+=@*<cr>
map <Leader>p "+p


"Extra

let g:airline_powerline_fonts = 1
let g:powerline_pycmd="py3"
let g:airline#extensions#tabline#enabled = 1 "airline thing
let g:user_emmet_leader_key='<leader>'




"Java Suppport!

autocmd Filetype java set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
noremap <leader>8 :make<return>:copen<return>
noremap <leader>6 :cprevious<Return>
noremap <leader>7 :cnext<Return>
noremap <leader>9 :!echo %\|awk -F. '{print $1}'\|xargs java<return>


"python Support!
noremap <leader>0 <Esc>:w<CR>:!clear;python %<CR>

