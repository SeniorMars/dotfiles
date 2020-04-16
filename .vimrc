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
Plug 'AlessandroYorba/Alduin' "airline
Plug 'jiangmiao/auto-pairs' "auto completes [] and ()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox' "Theme
Plug 'powerline/fonts', {'do': './install.sh'}
Plug 'scrooloose/nerdtree' "See dirs and files
Plug 'sheerun/vim-polyglot' "vim syntax for different languages
Plug 'tpope/vim-commentary' "Comment stuff
Plug 'tpope/vim-surround' "Allows me to change { to [ and what not
Plug 'vim-airline/vim-airline' "airline see bottom of bar
Plug 'vim-airline/vim-airline-themes' "airline theme theme
Plug 'wellle/targets.vim' "adds more targets like [ or ,
Plug 'Yggdroot/indentLine' "indent lines like atom. See python file for ex
call plug#end()

"Global settings
set nocp "make sure nvim doesn't act like vi
filetype plugin indent on    " required
syntax on "activates syntax highlighting among other things
set autoindent
set background=dark "Color scheme settings
set backspace=indent,eol,start "Fixes the backspace
set conceallevel=1 "Allows me to conceal latex syntax if not on line
set encoding=utf-8 "required by YCM
set expandtab
set foldlevel=99
set foldmethod=indent "fold your code.
set hidden "work with multiple unsaved buffers.
set incsearch "highlights as you search
set noshowmode "make the current mode label disappear - I have airline for this.
set rnu nu "sets line numbers
set splitbelow splitright
set termguicolors "True colors term support
so ~/.config/nvim/fzfConfig.vim

"Key remapping
let mapleader = ","
noremap <leader>t :NERDTreeToggle<cr>
noremap <leader>e <c-w><c-w>
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>
noremap <leader>z [s1z=
noremap <leader>p "+p
noremap <leader>P "+P
noremap <C-p> :Files<cr>
noremap <cr> o<esc>
inoremap jk <esc>
vnoremap <leader>y "*y :let @+=@*<cr>
map <leader>1 :bn<cr>
map <leader>2 :bp<cr>
map <leader>3 :retab<cr>
map <leader>5 :setlocal spell spelllang=en_us<cr>

"Extra
let g:airline_powerline_fonts = 1
let g:powerline_pycmd="py3"
let g:airline#extensions#tabline#enabled = 1 "airline thing
let g:airline_theme='alduin'
let g:gruvbox_italic='1'
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
let g:gruvbox_termcolors='256'
let g:AutoPairsFlyMode = 1
let g:fzf_buffers_jump = 1
let g:fzf_vim_statusline = 0
colorscheme gruvbox "colorscheme

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
