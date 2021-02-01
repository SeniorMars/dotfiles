" I Moved to neovim, this is for the sake if I ever need vim again. See
" ~/.config/nvim for more

"Auto Download
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"plugins!
call plug#begin('~/.vim/plugged')
Plug 'KarlWithK/gruvbox' "Theme fork
Plug 'jiangmiao/auto-pairs' "auto completes [] and ()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot' "vim syntax for different languages
Plug 'tpope/vim-commentary' "Comment stuff
Plug 'tpope/vim-surround' "Allows me to change { to [ and what not
Plug 'tpope/vim-fugitive' "Git control for vim
Plug 'wellle/targets.vim' "adds more targets like [ or ,
Plug 'Yggdroot/indentLine' "indent lines like atom. See python file for ex
call plug#end()

"Global settings
filetype plugin indent on
syntax on "activates syntax highlighting among other things
set background=dark "set hg group to dark
set backspace=indent,eol,start "Fixes the backspace
set conceallevel=1 "Allows me to conceal latex syntax if not on line
set encoding=utf-8 "required by YCM
set expandtab
set foldlevel=99
set foldmethod=indent "fold your code.
set hidden "work with multiple unsaved buffers.
set incsearch "highlights as you search
set ignorecase
set smartcase
set rnu nu "sets line numbers
set splitbelow splitright
set termguicolors "True colors term support
set viminfo+=n~/.vim/viminfo
set omnifunc=syntaxcomplete#Complete
set undodir="~/.vim/undo/"
set undofile
set laststatus=2
set showcmd
set guifont=MesloLGMDZ\ Nerd\ Font\ Bold\ 16
source ~/.config/nvim/fzfConfig.vim

"Key remapping
let mapleader = ","
noremap <leader>s :source ~/.vim/vimrc<cr>
noremap <leader>e <C-w><C-w>
noremap <leader>z [s1z=
noremap <leader>p "+p
noremap <leader>P "+P
noremap <leader>f :Files<cr>
noremap <leader>c :cd %:p:h<cr>:pwd<cr>
noremap <leader><cr> o<Esc>
noremap <space>h <C-w>h
noremap <space>j <C-w>j
noremap <space>k <C-w>k
noremap <space>l <C-w>l
noremap <down> :resize +2<Cr>
noremap <up> :resize -2<cr>
noremap <right> :vertical resize +2<CR>
noremap <left> :vertical resize -2<CR>
inoremap jk <Esc>
vnoremap <leader>y "*y :let @+=@*<cr>
map <leader>1 :bn<cr>
map <leader>2 :bp<cr>
map <leader>3 :retab<cr>
map <leader>5 :setlocal spell spelllang=en_us<cr>

"Extra
let g:gruvbox_italic='1'
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
let g:gruvbox_termcolors='256'
let g:AutoPairsFlyMode=0
colorscheme gruvbox "colorscheme

if executable('rg')
        set grepprg=rg\ --vimgrep
        set grepformat^=%f:%l:%c:%m
endif
"Java Support!
augroup javaSu
	autocmd!
	au Filetype java set makeprg=javac\ %
	set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
	au FileType java noremap <buffer> <leader>8 :make<cr>:copen<cr>
	au FileType java noremap <buffer> <leader>6 :cprevious<cr>
	au FileType java noremap <buffer> <leader>7 :cnext<cr>
	au FileType java noremap <buffer> <leader>9 :!echo %\|awk -F. '{print $1}'\|xargs java<cr>
augroup end

"python Support!
augroup pythonSupport "shuould go in after ftde but i'm lazy rn
	autocmd!
	au FileType python noremap <buffer> <leader>9 <esc>:w<cr>:!clear;python %<cr>
	au FileType python set tabstop=4 softtabstop=4 shiftwidth=4 fileformat=unix textwidth=79
	au BufWritePre *.py :%s/\s\+$//e
augroup end

"Full stack development should go in after
augroup full
	autocmd!
	au FileType javascript,html,css set tabstop=2 softtabstop=2 shiftwidth=2
augroup end


" statusline
set noshowmode
let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ '' : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'Replace ',
       \ 'r'  : 'Replace ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \ 't'  : 'Terminal ',
       \ 's'  : 'Select ',
       \ '!'  : 'Shell '
       \}

set statusline=%{toupper(g:currentmode[mode()])}%{toupper(&spelllang)}\ %{toupper(fugitive#head())}\ %<%F%h%m%r%=%-5.(%l,%c%V%)\ %y
