" firenvim
if exists('g:started_by_firenvim')
  runtime! fnvim.vim
  finish
endif

"Disable settings
let g:polyglot_disabled = ['javascript', 'java', 'c', 'typescript', 'python', 'cpp', 'rs', 'bash', 'zsh', 'html', 'lua', 'ruby'] "treesitter

"plugins!
call plug#begin('~/.vim/plugged') "I use vim too so it's better to keep them in one place
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex', {'for': ['tex']}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'
Plug 'sheerun/vim-polyglot' "vim syntax for different languages
Plug 'KarlWithK/gruvbox' "Theme
Plug 'honza/vim-snippets' " Snippets are separated from the engine
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'} "undo tree to see recent changed
Plug 'tpope/vim-commentary' "Comment stuff
Plug 'tpope/vim-fugitive' "Git control for vim
Plug 'tpope/vim-repeat' "repeats
Plug 'tpope/vim-surround' "Allows me to change { to [ and what not
Plug 'vimwiki/vimwiki' "To take notes better - testing this with vimtex
Plug 'wellle/targets.vim' "adds more targets like [ or ,
Plug 'turbio/bracey.vim', {'for': ['html', 'javascript', 'css']} "live reloading
Plug 'norcalli/nvim-colorizer.lua'
Plug 'Yggdroot/indentLine' "indent lines like atom. See python file for ex
Plug 'jiangmiao/auto-pairs'
Plug 'Valloric/MatchTagAlways', {'for':  ['html']}
Plug 'dpelle/vim-LanguageTool'
Plug 'junegunn/goyo.vim' "Distraction free
Plug 'junegunn/limelight.vim' "color free
Plug 'Chiel92/vim-autoformat'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'editorconfig/editorconfig-vim'
" Plug 'TimUntersberger/neogit'
" Plug 'jackguo380/vim-lsp-cxx-highlight', {'for': ['c', 'cpp', 'h']} "colors for c
" Plug 'uiiaoo/java-syntax.vim', {'for': ['java']} "better java syntax
" Plug 'yuezk/vim-js', {'for': ['javascript']} "javascript
" Plug 'tweekmonster/startuptime.vim'
" Plug 'ludovicchabant/vim-gutentags' "Tags Generate
" Plug 'puremourning/vimspector', {'for': ['java']}
" Plug 'danilamihailov/vim-wiki-tips'
" Plug 'ron89/thesaurus_query.vim', {'for': ['vimwiki', 'text', 'tex', 'mutt']} "thesaurus
call plug#end()

"Global settings
set conceallevel=1 "Allows me to conceal latex syntax if not on line
set foldmethod=indent "fold your code.
set foldlevel=99
set hidden "work with multiple unsaved buffers.
set ignorecase "search case
set smartcase "searching matters if Capital
set inccommand=split "for incsearch while sub
set lazyredraw "redraw off for macros
set relativenumber number "sets line numbers
set splitbelow splitright "split correction
set termguicolors "True colors term support
set undofile "undo even when it closes
set wildmode=list:longest,list:full
set omnifunc=syntaxcomplete#Complete
set foldlevelstart=1
set suffixesadd=.java
set noswapfile
set wildignore=*.javac,*.pyc
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" set dictionary=~/.config/nvim/10k.txt
" set complete+=k

" The following are things I shamefully copied from others
runtime cocRC.vim "cocRC rec settings
runtime fzfConfig.vim "fzf settings
" runtime extra.vim

"Key remapping
let mapleader = ","
noremap <leader><Bslash> ,
noremap <leader><cr> <cr>
noremap Q :G<cr>
nmap <Leader>d :ThesaurusQueryReplaceCurrentWord<CR>
nmap <Leader>ll <Plug>VimwikiFollowLink
nmap <Leader>ln <Plug>VimwikiNextLink
nmap <Leader>lp <Plug>VimwikiPrevLink
nmap <Leader>lf :Prettier<cr>
nmap <leader>c :cd %:p:h<cr>:pwd<cr>
nmap <leader>e <C-w><C-w>
nmap <leader>f :Files<cr>
nmap <leader>P "+gP
nmap <leader>p "+gp
nmap <leader>r :!ctags .<cr>
nmap <leader>s :source $MYVIMRC<cr>
nmap <silent> <space><space> :sp <bar> :term<cr>
nmap <silent> <space>t :vsp <bar> :term<cr>
nmap <leader>t :Lexplore<cr>
nmap <leader>u :UndotreeToggle<cr>
nmap <leader>z [s1z=``
nmap <space>h <C-w>h
nmap <space>j <C-w>j
nmap <space>k <C-w>k
nmap <space>l <C-w>l
nmap <Leader>wh <C-w>t<C-w>H
nmap <Leader>wk <C-w>t<C-w>K
nmap <down> :resize +2<Cr>
nmap <up> :resize -2<cr>
nmap <right> :vertical resize +2<CR>
nmap <left> :vertical resize -2<CR>
nmap <expr> j (v:count? 'j' : 'gj')
nmap <expr> k (v:count? 'k' : 'gk')
nmap <leader><cr> o<Esc>
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
let g:AutoPairsFlyMode='0' "Auto pairs correction
let g:gruvbox_contrast_dark='hard' "dark mode
let g:gruvbox_invert_selection='0' "No highlight
let g:gruvbox_italic='1' "enable italics
let g:indentLine_setColors = '0' "allows indent line to change colors
let g:lsp_cxx_hl_use_text_props = 1
" let g:tq_openoffice_en_file="~/.vim/thesaurus/Thes/th_en_US_new" "thesaurus
let g:vimwiki_table_mappings=0 "so I can tab complete
colorscheme gruvbox "colorscheme

"vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode='0'
let g:indentLine_setConceal='0'
let g:tex_conceal='abdmg'
" let g:vimwiki_global_ext=0 - markdown is sometimes rendered as .wiki

" Other settings
let g:vimwiki_list = [{'path': '~/Work/vimwiki'}]
let g:python3_host_prog = '/usr/bin/python3.9'
let g:ruby_host_prog = '~/.local/share/gem/bin/neovim-ruby-host' "I moved ruby
let g:rustfmt_autosave = 1
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_winsize = -28
let g:netrw_browsex_viewer= "firefox"
let g:languagetool_cmd='/usr/bin/languagetool'
let g:languagetool_lang='en-US'
let g:termdebug_popup = 0
let g:termdebug_wide = 163
let g:mta_use_matchparen_group = 1
" let g:grammarous#languagetool_cmd = 'languagetool'


"Commands
command! FixWhitespace :%s/\s\+$//e
command! Vimrc :sp $MYVIMRC
command! Wq wq

"skeletons!
autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/skeleton.tex
autocmd VimLeavePre * :call coc#rpc#kill()

" coc
let g:coc_global_extensions = [
  \ 'coc-java',
  \ 'coc-actions',
  \ 'coc-python',
  \ 'coc-rust-analyzer',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-vimlsp',
  \ 'coc-tsserver',
  \ 'coc-snippets',
  \ 'coc-emmet',
  \ 'coc-json',
  \ 'coc-texlab',
  \ 'coc-emoji'
  \ ]


if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat^=%f:%l:%c:%m
endif

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

" set statusline=%{toupper(g:currentmode[mode()])}%{toupper(&spelllang)}\ %<%F%h%m%r%=%-5.(%l,%c%V%)\ %y
set statusline=%{toupper(g:currentmode[mode()])}%{toupper(&spelllang)}\ %{toupper(fugitive#head())}\ %<%F%h%m%r%=%-5.(%l,%c%V%)\ %y


" Tree-sitter simple setup
lua require'colorizer'.setup()
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { 'css' },
  },
  incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      }
  },
  indent = {
      enable = true
  }
}
EOF
