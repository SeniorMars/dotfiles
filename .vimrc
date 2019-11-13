syntax on "activates syntax highlighting among other things

set hidden "work with multiple unsaved buffers.
set backspace=indent,eol,start "Fixes the backspace

"sets line numbers
set number
set foldmethod=indent "fold your code.
set foldlevel=99

"other stuff
set encoding=utf-8 "required by CM
set noshowmode "make the current mode label disappear - I have airline for this.
"plugin shit

set nocompatible              " be improved, required
filetype off                  " required

" set the run time path to include Bundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let bundle manage Bundle, required


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
Plugin 'metakirby5/codi.vim' "live python interp kinda usless tbh
Plugin 'SirVer/ultisnips' "Track the engine.
Plugin 'honza/vim-snippets' " Snippets are separated from the engine
Plugin 'Chiel92/vim-autoformat' "autoformat


"All of your Plugins must be added before the following line
call vundle#end()            " required

"second plugin mgnr just in case
execute pathogen#infect()

filetype plugin indent on    " required

set runtimepath^=~/.vim/bundle/ctrlp.vim "Allows ctrl p to work

"Key remapping
let mapleader = ","
noremap <Leader>x :x<cr>
noremap <Leader>l :UndotreeToggle<cr>
noremap <leader>w <C-w><C-w>
noremap <leader>z [s1z=
noremap <leader>q :NERDTreeToggle<CR>
noremap <leader>s :source ~/.vimrc<cr>
noremap <Leader>p "+p
noremap <Leader>P :+p
noremap <space> za
noremap <tab> i<tab><Esc>
noremap <CR> o<Esc>
inoremap jk <Esc>
inoremap <C-k> <Esc>O<Esc>jA
vnoremap <Leader>y "*y :let @+=@*<cr>
map <leader>1 :bn<cr>
map <leader>2 :bp<cr>
map <leader>3 :retab<cr>:RemoveTrailingSpaces<cr>
map <leader>4 :Autoformat<CR>
map <leader>5 :set spell spelllang=en_us<cr>


"Extra
let g:airline_powerline_fonts = 1
let g:powerline_pycmd="py3"
let g:airline#extensions#tabline#enabled = 1 "airline thing
let g:user_emmet_leader_key='<leader>'

" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

"Java Support!
autocmd Filetype java set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
autocmd FileType java noremap <buffer> <leader>8 :make<return>:copen<return>
autocmd FileType java noremap <buffer> <leader>6 :cprevious<Return>
autocmd FileType java noremap <buffer> <leader>7 :cnext<Return>
autocmd FileType java noremap <buffer> <leader>9 :!echo %\|awk -F. '{print $1}'\|xargs java<return>

"python Support!
autocmd FileType python noremap <buffer> <leader>9 <Esc>:w<CR>:!clear;python %<CR>
