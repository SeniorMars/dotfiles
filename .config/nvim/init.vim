"__     _____ __  __ ____   ____
"\ \   / /_ _|  \/  |  _ \ / ___|
" \ \ / / | || |\/| | |_) | |
"  \ V /  | || |  | |  _ <| |___
"   \_/  |___|_|  |_|_| \_\\____|
"
"Disable settings
let g:polyglot_disabled = ['latex', 'javascript'] "allow vimtex to work + vim-js

"plugins!
call plug#begin('~/.vim/plugged')
Plug 'AlessandroYorba/Alduin' "airline theme
Plug 'honza/vim-snippets' " Snippets are separated from the engine
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'jiangmiao/auto-pairs' "auto completes [] and ()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim' "Distraction free
Plug 'junegunn/limelight.vim' "color free
Plug 'lervag/vimtex' "To use latex better
Plug 'ludovicchabant/vim-gutentags' "Tags Generate
Plug 'mbbill/undotree' "undo tree to see recent changed
Plug 'morhetz/gruvbox' "Theme
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ron89/thesaurus_query.vim', {'on': 'ThesaurusQueryReplaceCurrentWord', 'for': ['vimwiki', 'text', 'tex', 'mutt']} "thesaurus
Plug 'ryanoasis/vim-devicons' "Icons for plugins
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } "See dirs and files
Plug 'sheerun/vim-polyglot' "vim syntax for different languages
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "color for icons
Plug 'tpope/vim-commentary' "Comment stuff
Plug 'tpope/vim-fugitive' "Git control for vim
Plug 'tpope/vim-repeat' "repeats
Plug 'tpope/vim-sleuth' "set tab settings
Plug 'tpope/vim-surround' "Allows me to change { to [ and what not
Plug 'turbio/bracey.vim', {'on': 'Bracy'} "live reloading
Plug 'uiiaoo/java-syntax.vim'
Plug 'vim-airline/vim-airline' "airline see bottom of bar
Plug 'vim-airline/vim-airline-themes' "airline theme theme
Plug 'vimwiki/vimwiki' "To take notes better - testing this with vimtex
Plug 'wellle/targets.vim' "adds more targets like [ or ,
Plug 'Xuyuanp/nerdtree-git-plugin' "git and nerd tree
Plug 'Yggdroot/indentLine' "indent lines like atom. See python file for ex
Plug 'yuezk/vim-js' "javascript
" Plug 'yuki-ycino/fzf-preview.vim'
call plug#end()

"Global settings
filetype plugin indent on "required
syntax on "activates syntax highlighting among other things
set hidden "work with multiple unsaved buffers.
set backspace=indent,eol,start "Fixes the backspace
set incsearch "highlights as you search
set inccommand=split "for incsearch while sub
set suffixesadd=.wiki
set rnu nu "sets line numbers
set foldmethod=indent "fold your code.
set foldlevel=99
set smartcase
set ignorecase
set undofile "undo even when it closes
set encoding=utf-8 "required by YCM
set noshowmode "make the current mode label disappear - I have airline for this.
set conceallevel=1 "Allows me to conceal latex syntax if not on line
set background=dark "Color scheme settings
set termguicolors "True colors term support
set splitbelow splitright "split correction
set wildmode=list:longest,list:full
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
set autoindent
set lazyredraw
so ~/.config/nvim/cocRC.vim "cocRC rec settings
so ~/.config/nvim/fzfConfig.vim "fzf settings
so ~/.config/nvim/search.vim "search
so ~/.config/nvim/extra.vim "Extra

"Key remapping
let mapleader = ","
nmap <Leader>cc :ThesaurusQueryReplaceCurrentWord<CR>
nmap <leader>cd :cd %:p:h<cr>:pwd<cr>
nmap <leader>e <C-w><C-w>
nmap <leader>f :Files<cr>
nmap <Leader>ll <Plug>VimwikiFollowLink
nmap <Leader>ln <Plug>VimwikiNextLink
nmap <Leader>lp <Plug>VimwikiPrevLink
nmap <leader>p "+gp
nmap <leader>P "+gP
nmap <leader>s :source ~/.config/nvim/init.vim<cr>
nmap <leader>t :NERDTreeToggle<cr>
nmap <leader>u :UndotreeToggle<cr>
nmap <leader>z [s1z=
nmap <cr> o<Esc>
nmap <expr> j (v:count? 'j' : 'gj')
nmap <expr> k (v:count? 'k' : 'gk')
nmap Y y$
nmap Q <M-b>
imap jk <Esc>
imap <down> <Nop>
imap <right> <Nop>
imap <left> <Nop>
imap <up> <Nop>
vmap <leader>y "*y :let @+=@*<cr>
map <leader>1 :bp<cr>
map <leader>2 :bn<cr>
map <leader>3 :retab<cr>:FixWhitespace<cr>
map <leader>4 :Format<cr>
map <leader>5 :setlocal spell spelllang=en_us<cr>
map <leader>0 :silent !firefox %<cr>

"Extra
let g:airline#extensions#coc#enabled ='0'
let g:airline#extensions#tabline#enabled='1' "Allows the top section of airline
let g:airline_powerline_fonts='1' "powerline fonts
let g:airline_theme='alduin' "alduin powerline theme
let g:AutoPairsFlyMode='1' "Auto pairs correction
" let g:fzf_preview_use_dev_icons = '1' "use dev-icons
let g:gruvbox_contrast_dark='hard' "dark mode
let g:gruvbox_invert_selection='0' "No highlight
let g:gruvbox_italic='1' "enable italics
let g:indentLine_setColors = '0' "allows indent line to change colors
let g:NERDTreeHighlightCursorline = '0'
let g:NERDTreeShowHidden='1' "hidden files
let g:powerline_pycmd="py3" "use py3
let g:python_highlight_all='1' "enable all syntax highlight
let g:ruby_host_prog = '~/.local/share/gem/ruby/2.7.0/bin/neovim-ruby-host'
let g:tq_openoffice_en_file="~/.vim/thesaurus/Thes/th_en_US_new" "thesaurus
" let g:vimwiki_table_mappings=0
colorscheme gruvbox "colorscheme

"vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode='0'
let g:indentLine_setConceal='0'
let g:tex_conceal='abdmg'

"Commands
command! FixWhitespace :%s/\s\+$//e
command! Vimrc :sp $MYVIMRC
autocmd! User GoyoEnter Limelight "limelight activates when in Goyo mode
autocmd! User GoyoLeave Limelight! "deactivates

"skeletons!
autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/skeleton.tex

" coc
let g:coc_global_extensions = [
  \ 'coc-java',
  \ 'coc-python',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-vimlsp',
  \ 'coc-tsserver',
  \ 'coc-snippets',
  \ 'coc-highlight',
  \ 'coc-emmet',
  \ 'coc-json',
  \ 'coc-texlab',
  \ 'coc-emoji'
  \ ]
