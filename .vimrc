"Disable settings
let g:polyglot_disabled = ['latex'] "allow vimtex to work

"Auto Download
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"plugins!
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround' "Allows me to change { to [ and what not
Plug 'tpope/vim-commentary' "Comment stuff
Plug 'tpope/vim-fugitive' "Git control for vim
Plug 'sheerun/vim-polyglot' "vim syntax for different languages
Plug 'vim-airline/vim-airline' "airline see bottom of bar
Plug 'vim-airline/vim-airline-themes' "airline theme theme
Plug 'powerline/fonts', {'do': './install.sh'}
Plug 'SirVer/ultisnips' "Track the engine.
Plug 'honza/vim-snippets' " Snippets are separated from the engine
Plug 'morhetz/gruvbox' "Theme
Plug 'AlessandroYorba/Alduin' "airline
Plug 'mattn/emmet-vim' "emmet for vim.
Plug 'jiangmiao/auto-pairs' "auto completes [] and ()
Plug 'wellle/targets.vim' "adds more targets like [ or ,
Plug 'Yggdroot/indentLine' "indent lines like atom. See python file for ex
Plug 'gko/vim-coloresque' "css html color highlighting
Plug 'Chiel92/vim-autoformat' "autoformat
Plug 'lervag/vimtex' "To use latex better
Plug 'vimwiki/vimwiki' "To take notes better - testing this with vimtex
Plug 'mbbill/undotree' "undo tree to see recent changed
Plug 'scrooloose/nerdtree' "See dirs and files
Plug 'Xuyuanp/nerdtree-git-plugin' "git and nerd tree
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim' "Distraction free
Plug 'junegunn/limelight.vim' "color free
" Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' }
call plug#end()

"Global settings
set nocp "make sure nvim doesn't act like vi
filetype plugin indent on    " required
syntax on "activates syntax highlighting among other things
set hidden "work with multiple unsaved buffers.
set backspace=indent,eol,start "Fixes the backspace
set incsearch "highlights as you search
set rnu nu "sets line numbers
set foldmethod=indent "fold your code.
set foldlevel=99
set encoding=utf-8 "required by YCM
set noshowmode "make the current mode label disappear - I have airline for this.
set conceallevel=1 "Allows me to conceal latex syntax if not on line
set background=dark "Color scheme settings
set termguicolors "True colors term support
set splitbelow splitright

"Key remapping
let mapleader = ","
noremap <leader>s :source ~/.vimrc<cr>
noremap <leader>u :UndotreeToggle<cr>
noremap <leader>t :NERDTreeToggle<cr>
noremap <leader>e <C-w><C-w>
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>
noremap <leader>g :Goyo<cr>
noremap <leader>G :Goyo!<cr>
noremap <leader>z [s1z=
noremap <leader>p "+p
noremap <leader>P "+P
noremap <space> za
noremap <cr> o<Esc>
noremap <C-p> :Files<cr>
inoremap jk <Esc>
inoremap <C-k> <Esc>O<Esc>jA
vnoremap <leader>y "*y :let @+=@*<cr>
map <leader>1 :bn<cr>
map <leader>2 :bp<cr>
map <leader>3 :retab<cr>
map <leader>4 :Autoformat<cr>
map <leader>5 :setlocal spell spelllang=en_us<cr>

"Extra
let g:airline_powerline_fonts = 1
let g:powerline_pycmd="py3"
let g:airline#extensions#tabline#enabled = 1 "airline thing
let g:airline_theme='alduin'
let g:user_emmet_leader_key='<C-,>'
let g:gruvbox_italic='1'
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
let g:gruvbox_termcolors='256'
let g:AutoPairsFlyMode = 1
let g:fzf_buffers_jump = 1
let g:fzf_vim_statusline = 0
colorscheme gruvbox "colorscheme
so ~/.config/nvim/fzfConfig.vim

"UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

"vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:indentLine_setConceal=0
let g:tex_conceal='abdmg'

"Java Support!
au Filetype java set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
au FileType java noremap <buffer> <leader>8 :make<cr>:copen<cr>
au FileType java noremap <buffer> <leader>6 :cprevious<cr>
au FileType java noremap <buffer> <leader>7 :cnext<cr>
au FileType java noremap <buffer> <leader>9 :!echo %\|awk -F. '{print $1}'\|xargs java<cr>

"python Support!
au FileType python noremap <buffer> <leader>9 <Esc>:w<cr>:!clear;python %<cr>
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set textwidth=79
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix
au BufWritePre *.py :%s/\s\+$//e

"Full stack development
au BufNewFile,BufRead *.js,*.html,*.css set tabstop=2
au BufNewFile,BufRead *.js,*.html,*.css set softtabstop=2
au BufNewFile,BufRead *.js,*.html,*.css set shiftwidth=2
au BufNewFile,BufRead *.js,*.html,*.css set expandtab
au BufNewFile,BufRead *.js,*.html,*.css set autoindent

"skeletons!
au BufNewFile *.tex -r ~/.vim/templates/skeleton.tex

"Muttrc
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set spell spelllang=en_us
autocmd BufRead,BufNewFile /tmp/neomutt* noremap <leader>x :Goyo\|x!<cr>
