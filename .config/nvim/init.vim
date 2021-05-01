" firenvim
if exists('g:started_by_firenvim')
  runtime fnvim.vim
  finish
endif

" Disable settings
let g:polyglot_disabled = ['javascript', 'dart', 'css', 'java', 'c', 'typescript', 'python', 'cpp', 'rs', 'bash', 'zsh', 'html', 'lua', 'ruby', 'ocaml', 'haskell', 'go', 'yaml', 'json'] "treesitter

" plugins!
call plug#begin('~/.vim/plugged') "I use vim too so it's better to keep them in one place
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':CocUpdate'}
Plug 'gruvbox-community/gruvbox'
Plug 'junegunn/fzf.vim'
Plug 'kevinhwang91/nvim-bqf'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'} "undo tree to see recent changed
Plug 'honza/vim-snippets' " Snippets are separated from the engine
Plug 'tpope/vim-commentary' "Comment stuff
Plug 'tpope/vim-fugitive' "Git control for vim
Plug 'tpope/vim-repeat' "repeats
Plug 'tpope/vim-surround' "Allows me to change { to [ and what not
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'sheerun/vim-polyglot' "vim syntax for different languages
Plug 'ludovicchabant/vim-gutentags' "Tags Generate

Plug 'norcalli/nvim-colorizer.lua'
Plug 'lukas-reineke/indent-blankline.nvim', {'branch': 'lua'}
Plug 'jiangmiao/auto-pairs'
Plug 'wellle/targets.vim' "adds more targets like [ or ,
Plug 'Valloric/MatchTagAlways', {'for':  ['html']}
Plug 'editorconfig/editorconfig-vim'

Plug 'lervag/vimtex', {'for': ['tex']}
Plug 'vimwiki/vimwiki' "To take notes better - testing this with vimtex
Plug 'junegunn/goyo.vim' "Distraction free
Plug 'junegunn/limelight.vim' "color free
Plug 'mattn/webapi-vim'
Plug 'dpelle/vim-LanguageTool'
Plug 'turbio/bracey.vim', {'for': ['html', 'javascript', 'css']} "live reloading
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'kristijanhusak/vim-carbon-now-sh'

" Plug 'puremourning/vimspector' " , { 'do': 'python3 install_gadget.py --all'}
" Plug 'TimUntersberger/neogit'
" Plug 'uiiaoo/java-syntax.vim', {'for': ['java']} "better java syntax
" Plug 'yuezk/vim-js', {'for': ['javascript']} "javascript
" Plug 'tweekmonster/startuptime.vim'
call plug#end()

"Global options
set conceallevel=2 "Allows me to conceal latex syntax if not on line
set hidden "work with multiple unsaved buffers.
set ignorecase "search case
set smartcase "searching matters if Capital
set inccommand=split "for incsearch while sub
set lazyredraw "redraw off for macros
set relativenumber number "sets line numbers
set splitbelow splitright "split correction
set termguicolors "True colors term support
set undofile "undo even when it closes
set noswapfile
set wildmode=list:longest,list:full
set omnifunc=syntaxcomplete#Complete
set suffixesadd+=.java,.rs
set wildignore=*.javac,*.pyc
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set scrolloff=8
set colorcolumn=99999
set dictionary=~/.config/nvim/10k.txt
set complete+=k
set diffopt+=internal,algorithm:patience

runtime cocRC.vim "cocRC rec settings
runtime fzfConfig.vim "fzf settings
runtime myhighlights.vim
" runtime telescope.vim
" runtime extra.vim

if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat^=%f:%l:%c:%m
endif

" Key remapping
let mapleader = ","

" General
nmap gx yiW:!xdg-open "<C-r>"" & <CR>
nmap <Leader>ll <Plug>VimwikiFollowLink
nmap <Leader>ln <Plug>VimwikiNextLink
nmap <Leader>lp <Plug>VimwikiPrevLink
nmap <leader>e :Prettier<cr>
nmap <leader>cd :cd %:p:h<cr>:pwd<cr>
nmap <leader>cn :cnext<cr>
nmap <leader>cp :cprevious<cr>
nmap <leader>P "+gP
nmap <leader>p "+gp
nmap <leader>r :!ctags .<cr>
nmap <leader>sv :source $MYVIMRC<cr>
nmap <leader>sr :%s/\<<C-r><C-w>\>//g<Left><Left>
nmap <leader>u :UndotreeToggle<cr>
nmap <leader>z [s1z=``
xmap <leader>y "*y :let @+=@*<cr>
nmap <leader>1 :bp<cr>
nmap <leader>2 :bn<cr>
nmap <leader>3 :retab<cr>:FixWhitespace<cr>
nmap <leader>4 :Format<cr>
nmap <leader>5 :call SpellToggle()<cr>
nmap <leader>0 :silent !firefox %<cr>

" Movement
nmap <silent> <space><space> :sp <bar> :term<cr>
nmap <silent> <space>t :vsp <bar> :term<cr>
nmap <leader>t :Lexplore<cr>
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
nmap Y y$
imap jk <Esc>

" Fzf + grepper
nmap <leader><leader>f :GFiles<cr>
nmap <leader>ff :Files<cr>
nmap <leader>fb :Buffers<cr>
nmap <leader>fm :Marks<cr>
nmap <leader>fk :Maps<cr>
nmap <leader>fh :Helptags<cr>
nmap <leader>ft :Tags<space>
nmap <leader>fl :BLines<space>
nmap <leader>fS :Rg<space>
nnoremap <leader>fs :Grepper -tool rg<cr>
nnoremap <leader>* :Grepper -tool rg -cword -noprompt<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" fugitive
nmap <silent><leader>gg :Git<cr>
nmap <silent><leader>ga :Git add %:p<cr><cr>
nmap <silent><leader>gd :Gdiff<cr>
nmap <silent><leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gw :Gwrite<cr><cr>
nmap <silent><leader>gb :GBrowse<cr><cr>
nmap <silent><leader>go :Git checkout<space>
nmap <silent><leader>gf :Commits<cr>

"Extra
let g:AutoPairsFlyMode='0' "Auto pairs correction
let g:gruvbox_contrast_dark='hard' "dark mode
let g:gruvbox_italic=1
let g:gruvbox_invert_selection='0' "No highlight
let g:indent_blankline_char = '¦'
" let g:indent_blankline_use_treesitter = v:true
" let g:indent_blankline_char_highlight = 'GruvboxBlue'
colorscheme gruvbox "colorscheme

" Vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode='0'
let g:indentLine_setConceal='0'
let g:tex_conceal='abdmg'

" Gutentags
let g:gutentags_file_list_command = 'fd'
let g:gutentags_add_default_project_roots = '0'
let g:gutentags_generate_on_empty_buffer = '1'
let g:gutentags_ctags_extra_args = ['-n', '-u', '--recurse', '--tag-relative=yes', '--fields=+ailmnS']
let g:gutentags_ctags_exclude = ['.git', '.svg', '.hg', '.vscode', '/tests/',
      \ 'build', 'dist', 'sites//files/', 'bin', 'node_modules', 'bower_components',
      \ 'cache', 'compiled', 'docs', 'example', 'bundle', 'vendor', '.md',
      \ '-lock.json', '.lock', 'bundle.js', 'build.js', '.rc', '.json', '.min.',
      \ '.map', '.bak', '.zip', '.pyc', '.class', '.sln', '.Master', '.csproj',
      \ '.tmp', '.csproj.user', '.cache', '.pdb', 'tags', 'cscope.', '.css', '.less',
      \ '.scss', '.exe', '.dll', '.mp3', '.ogg', '.flac', '.swp', '.swo', '.bmp',
      \ '.gif', '.ico', '.jpg', '.png', '.rar', '.zip', '.tar', '.tar.gz', '.tar.xz']
let g:gutentags_project_root = ['package.json', '.git', 'Cargo.toml']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = '1'
let g:gutentags_generate_on_missing = '1'
let g:gutentags_generate_on_write = '1'

" Other settings
" let g:vimwiki_global_ext=0 - markdown is sometimes rendered as .wiki
" let g:vimwiki_table_mappings=0 "so I can tab complete
let g:vimwiki_list = [{'path': '~/Work/vimwiki'}]
let g:python3_host_prog = '/usr/bin/python3.9'
" let g:ruby_host_prog = '~/.local/share/gem/bin/neovim-ruby-host' "I moved ruby
" let g:rustfmt_autosave = 1
let g:rust_clip_command = 'xclip -selection clipboard'
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_winsize = -28
let g:netrw_browsex_viewer= "xdg-open"
let g:languagetool_cmd='/usr/bin/languagetool'
let g:languagetool_lang='en-US'
let g:termdebug_popup = 0
let g:termdebug_wide = 163
let g:mta_use_matchparen_group = 1
" let g:grammarous#languagetool_cmd = 'languagetool'

"Commands
command! FixWhitespace :%s/\s\+$//e
command! Vimrc :sp $MYVIMRC
command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' http://ix.io | tr -d '\n' | xclip -i -selection clipboard

" autocmds
augroup Random
  autocmd!
  autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/skeleton.tex
  autocmd VimLeavePre * :call coc#rpc#kill()
  autocmd VimLeave * if get(g:, 'coc_process_pid', 0) | call system('kill -9 -'.g:coc_process_pid) | endif
  autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
augroup END

" coc
let g:coc_global_extensions = [
  \ 'coc-java',
  \ 'coc-rust-analyzer',
  \ 'coc-html',
  \ 'coc-discord-rpc',
  \ 'coc-css',
  \ 'coc-vimlsp',
  \ 'coc-tsserver',
  \ 'coc-snippets',
  \ 'coc-emmet',
  \ 'coc-json',
  \ 'coc-texlab',
  \ 'coc-emoji'
  \ ]

" statusline
set noshowmode
let g:currentmode={
  \ 'n'  : 'Normal ',
  \ 'no' : 'N·Operator ',
  \ 'v'  : 'Visual ',
  \ 'V'  : 'V·Line ',
  \ '' : 'V·Block ',
  \ 'i'  : 'Insert ',
  \ 's'  : 'Select ',
  \ 'S'  : 'Select',
  \ 'R'  : 'Replace ',
  \ 'Rv' : 'V·Replace ',
  \ 'c'  : 'Command ',
  \ 'cv' : 'Vim Ex ',
  \ 'ce' : 'Ex ',
  \ 'r'  : 'Prompt ',
  \ 'rm' : 'More ',
  \ 'r?' : 'Confirm ',
  \ '!'  : 'Shell ',
  \ 't'  : 'Terminal '}


function! SpellToggle()
    if &spell
      setlocal spell! spelllang&
    else
      setlocal spell spelllang=en_us
    endif
endfunction


function! BufTotal()
  return len(getbufinfo({'buflisted':1}))
endfunction

function! FilePath() abort
    if expand('%:h') ==# ''
      return '[No Name]'
    endif
    let l:path = expand('%:p:h')
    let l:home = '/home/' . $USER . '/'
    if stridx(l:path, l:home) !=# -1
      let l:path = substitute(l:path, l:home, '~/', "")
    endif
    if winwidth(0) <= 80
        let l:path = pathshorten(l:path)
    endif
    return l:path . '/' . expand('%:t')
endfunction

function! Fugitive() abort
    if exists('g:loaded_fugitive')
        let l:branch = fugitive#head()
        return l:branch !=# '' ? l:branch . " ": ""
    endif
    return ''
endfunction

function! WordCount() abort
    let l:currentmode = mode()
    if l:currentmode == 't' || l:currentmode == 's' || l:currentmode == 'S'
      return 0
    endif
    if !exists('g:lastmode_wc')
        let g:lastmode_wc = l:currentmode
    endif
    if &modified || !exists('b:wordcount') || l:currentmode =~? '\c.*v' || l:currentmode != g:lastmode_wc
        let g:lastmode_wc = l:currentmode
        let l:old_position = getpos('.')
        let l:old_status = v:statusmsg
        execute "silent normal g\<c-g>"
        if v:statusmsg ==# '--No lines in buffer--'
            let b:wordcount = 0
        else
            let s:split_wc = split(v:statusmsg)
            if index(s:split_wc, 'Selected') < 0
                let b:wordcount = str2nr(s:split_wc[11])
            else
                let b:wordcount = str2nr(s:split_wc[5])
            endif
            let v:statusmsg = l:old_status
        endif
        call setpos('.', l:old_position)
        return b:wordcount
    else
        return b:wordcount
    endif
endfunction

set statusline=%{toupper(g:currentmode[mode()])} " get current mode
set statusline+=%{toupper(&spelllang)} " display language and if spell is on
set statusline+=\ %{toupper(Fugitive())} " branch name
set statusline+=%<%{FilePath()} " full path filename
set statusline+=%h%m%r%w " help flag, modified, readonly, and preview
set statusline+=%= " right align remainder
set statusline+=\[%-3.(%l,%c%V%)\] " line number, column number
set statusline+=\[%{WordCount()}\] " word count
set statusline+=\[%{BufTotal()}\] " current buffer number / total buffers
set statusline+=\[%{strlen(&ft)?&ft[0].&ft[1:]:'None'}\] " file type

" Tree-sitter simple setup
lua <<EOF
require'colorizer'.setup()
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = {"latex"},
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
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
      enable = true,
      disable = {'html', 'python'},
  },
  context_commentstring = {
    enable = true
  },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
EOF
