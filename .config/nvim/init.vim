"Disable settings
let g:polyglot_disabled = ['latex', 'javascript'] "allow vimtex to work + vim-js

"plugins!
call plug#begin('~/.vim/plugged') "I use vim too so it's better to keep them in one place
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot' "vim syntax for different languages
Plug 'morhetz/gruvbox' "Theme
Plug 'honza/vim-snippets' " Snippets are separated from the engine
Plug 'jackguo380/vim-lsp-cxx-highlight', {'for': ['c', 'cpp', 'cuda','objc','objcpp']} "colors for c
Plug 'ron89/thesaurus_query.vim', {'for': ['vimwiki', 'text', 'tex', 'mutt']} "thesaurus
Plug 'junegunn/fzf' "Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak' "better s
Plug 'lervag/vimtex', {'for':'tex'} "To use latex better
Plug 'ludovicchabant/vim-gutentags' "Tags Generate
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'} "undo tree to see recent changed
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } "See dirs and files
Plug 'Xuyuanp/nerdtree-git-plugin' "git and nerd tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "color for icons
Plug 'tpope/vim-commentary' "Comment stuff
Plug 'tpope/vim-fugitive' "Git control for vim
Plug 'tpope/vim-repeat' "repeats
Plug 'tpope/vim-surround' "Allows me to change { to [ and what not
Plug 'uiiaoo/java-syntax.vim' "better java syntax
Plug 'vim-airline/vim-airline' "airline see bottom of bar
Plug 'vimwiki/vimwiki' "To take notes better - testing this with vimtex
Plug 'wellle/targets.vim' "adds more targets like [ or ,
Plug 'yuezk/vim-js' "javascript
Plug 'turbio/bracey.vim', {'on': 'Bracy'} "live reloading
Plug 'ryanoasis/vim-devicons' "Icons for plugins
Plug 'norcalli/nvim-colorizer.lua'
Plug 'Yggdroot/indentLine' "indent lines like atom. See python file for ex
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } "use nvim in firefox
" Plug 'junegunn/goyo.vim' "Distraction free
" Plug 'junegunn/limelight.vim' "color free
call plug#end()

"Global settings
set conceallevel=1 "Allows me to conceal latex syntax if not on line
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
set foldmethod=indent "fold your code.
set foldlevel=99
set hidden "work with multiple unsaved buffers.
set ignorecase "search ignores case"
set inccommand=split "for incsearch while sub
set lazyredraw "redraw off for macros
set noshowmode "make the current mode label disappear - airline has this
set rnu nu "sets line numbers
set smartcase "searching matters if Capital
set splitbelow splitright "split correction
set termguicolors "True colors term support
set undofile "undo even when it closes
set wildmode=list:longest,list:full

" The following are things I shamefully copied from others
runtime cocRC.vim "cocRC rec settings
runtime fzfConfig.vim "fzf settings

"Key remapping
let mapleader = ","
noremap <silent> Q *``cgn
noremap <leader><Bslash> ,
nmap <Leader>d :ThesaurusQueryReplaceCurrentWord<CR>
nmap <Leader>ll <Plug>VimwikiFollowLink
nmap <Leader>ln <Plug>VimwikiNextLink
nmap <Leader>lp <Plug>VimwikiPrevLink
nmap <leader>c :cd %:p:h<cr>:pwd<cr>
nmap <leader>e <C-w><C-w>
nmap <leader>f :Files<cr>
nmap <leader>P "+gP
nmap <leader>p "+gp
nmap <leader>r :!ctags .<cr>
nmap <leader>s :source $MYVIMRC<cr>
nmap <leader>t :NERDTreeToggle<cr>
nmap <leader>u :UndotreeToggle<cr>
nmap <leader>z [s1z=
nmap <space>h <C-w>h
nmap <space>j <C-w>j
nmap <space>k <C-w>k
nmap <space>l <C-w>l
nmap <Leader>wh <C-w>t<C-w>H
nmap <Leader>wk <C-w>t<C-w>K
nmap <cr> o<Esc>
nmap <expr> j (v:count? 'j' : 'gj')
nmap <expr> k (v:count? 'k' : 'gk')
nmap Y y$
imap jk <Esc>
xmap <leader>y "*y :let @+=@*<cr>
nmap <leader>1 :bp<cr>
nmap <leader>2 :bn<cr>
nmap <leader>3 :retab<cr>:FixWhitespace<cr>
nmap <leader>4 :Format<cr>
nmap <leader>5 :setlocal spell spelllang=en_us<cr>
nmap <leader>0 :silent !firefox %<cr>

"Extra
let g:airline_extensions = ['tabline', 'vimtex', 'fugitiveline', 'branch', 'wordcount' , 'whitespace', 'undotree']
let g:airline_powerline_fonts='1' "powerline fonts
let g:airline_theme='alduin' "alduin powerline theme
let g:AutoPairsFlyMode='1' "Auto pairs correction
let g:gruvbox_contrast_dark='hard' "dark mode
let g:gruvbox_invert_selection='0' "No highlight
let g:gruvbox_italic='1' "enable italics
let g:indentLine_setColors = '0' "allows indent line to change colors
let g:Hexokinase_highlighters = [ 'backgroundfull' ]
let g:NERDTreeHighlightCursorline = '0' "makes NerdTree faster
let g:powerline_pycmd="py3" "use py3
let g:tq_openoffice_en_file="~/.vim/thesaurus/Thes/th_en_US_new" "thesaurus
let g:WebDevIconsNerdTreeGitPluginForceVAlign = '1'
let g:vimwiki_table_mappings=0 "so I can tab complete
colorscheme gruvbox "colorscheme

" Gutentag
let g:gutentags_add_default_project_roots = '0'
let g:gutentags_project_root = ['package.json', '.git', 'tags']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = '1'
let g:gutentags_generate_on_missing = '1'
let g:gutentags_generate_on_write = '1'
let g:gutentags_generate_on_empty_buffer = '0'

"vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode='0'
let g:indentLine_setConceal='0'
let g:tex_conceal='abdmg'

" Other settings
let g:vimwiki_list = [{'path': '~/Work/vimwiki'}]
let g:NERDTreeIgnore = ['^node_modulues$', '.git$']
let g:python_highlight_all='1' "enable all syntax highlight
let g:ruby_host_prog = '~/.local/share/gem/bin/neovim-ruby-host' "I moved ruby

"Commands
command! FixWhitespace :%s/\s\+$//e
command! Vimrc :sp $MYVIMRC
command! Wq wq
" autocmd! User GoyoEnter Limelight "limelight activates when in Goyo mode
" autocmd! User GoyoLeave Limelight! "deactivates

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
  \ 'coc-emmet',
  \ 'coc-json',
  \ 'coc-texlab',
  \ 'coc-emoji',
  \ 'coc-pairs'
  \ ]

lua require'colorizer'.setup()
