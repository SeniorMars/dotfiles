syntax on "activates syntax highlighting among other things
syntax enable

" activates filetype detection
filetype plugin indent on

" allows you to deal with multiple unsaved
" buffers simultaneously without resorting
" to misusing tabs
set hidden

set backspace=indent,eol,start "who knows what this does.

"sets line numbers
set number

"other stuff
set nocp "meant to fix syntax on
filetype on "same as above
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
" All of your Plugins must be added before the following line
call vundle#end()            " required

"second vim plugin just in case
execute pathogen#infect()

set noshowmode "make the current mode label dissappear - I have airline for this.

filetype plugin indent on    " required 


"Key remapings
let mapleader = ","
noremap <Leader>x :x<cr>
noremap <Leader>l :UndotreeToggle<cr>
inoremap jk <Esc>
inoremap <C-k> <Esc>O<Esc>jA
vnoremap <Leader>y "*y :let @+=@*<cr>
map <Leader>p "+p



"Other:

let g:airline_powerline_fonts = 1
let g:powerline_pycmd="py3"
let g:airline#extensions#tabline#enabled = 1 "airline thing
