" firenvim
" if exists('g:started_by_firenvim')
"   runtime fnvim.vim
"   finish
" endif

" neovim
if exists('g:vscode')
  let g:coc_start_at_startup=0
  finish
endif

" Disable settings
let g:polyglot_disabled = ['javascript', 'css', 'java', 'c', 'typescript', 'python', 'cpp', 'rs', 'bash', 'zsh', 'html', 'lua', 'ruby', 'ocaml', 'haskell', 'go', 'yaml', 'json', 'rust'] "treesitter

lua <<EOF
-- Install packer
local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.vim PackerCompile
  augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use { 'neoclide/coc.nvim', branch = 'release', run = ':CocUpdate' }
  -- use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {'nvim-treesitter/playground', cmd="TSPlaygroundToggle"}
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'gruvbox-community/gruvbox'
  use 'junegunn/fzf.vim'
  use 'kevinhwang91/nvim-bqf'
  use {'mbbill/undotree', opt = true, cmd = 'UndotreeToggle'}
  use 'honza/vim-snippets' -- Snippets are separated from the engine
  use 'tpope/vim-commentary' -- Comment stuff
  use 'tpope/vim-fugitive' -- Git control for vim
  use 'tpope/vim-repeat' -- repeats
  use 'tpope/vim-surround' -- Allows me to change { to [ and what not
  use 'tpope/vim-vinegar'
  use 'tpope/vim-rhubarb'
  -- use 'tpope/vim-obsession'
  use 'mhinz/vim-grepper'
  use 'sheerun/vim-polyglot' -- vim syntax for different languages
  use 'ludovicchabant/vim-gutentags' -- Tags Generate
  use 'skywind3000/asyncrun.vim'

  use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua' }
  use {'norcalli/nvim-colorizer.lua', config = function() require'colorizer'.setup() end}
  use 'cohama/lexima.vim'
  use 'wellle/targets.vim' -- adds more targets like [ or ,
  use {'Valloric/MatchTagAlways', ft =  { 'html' }}
  use 'editorconfig/editorconfig-vim'
  use {'puremourning/vimspector',  run = 'python3 install_gadget.py --all'}

  use 'mattn/webapi-vim'
  use {'lervag/vimtex', ft = { 'tex' }}
  use {'vimwiki/vimwiki', cmd = 'VimwikiIndex'} -- To take notes better - testing this with vimtex
  use {'junegunn/goyo.vim', cmd="Goyo"} -- Distraction free
  use {'junegunn/limelight.vim', cmd="Limelight"} -- color free
  use 'vigoux/LanguageTool.nvim'
  use {'turbio/bracey.vim', ft = { 'html', 'javascript', 'css' }, run = "npm install --prefix server"} -- live reloading

  -- use 'TimUntersberger/neogit'
  -- use {'uiiaoo/java-syntax.vim', ft = { 'java' }} -- better java syntax
  -- use {'yuezk/vim-js', ft = { 'javascript' }} -- javascript
  -- use 'kristijanhusak/vim-carbon-now-sh'
  -- use 'tweekmonster/startuptime.vim'
end)
EOF

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
set guifont=MesloLGMDZ\ Nerd\ Font\ Bold\ 16
set breakindent
set mouse=a

runtime cocRC.vim "cocRC rec settings
runtime fzfConfig.vim "fzf settings
runtime myhighlights.vim

if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat^=%f:%l:%c:%m
endif

" Key remapping
let mapleader = ","

" General
nmap <a-x> <nop>
nmap gx yiW:!xdg-open "<C-r>"" & <CR>
nmap <Leader>ww :VimwikiIndex<cr>
nmap <Leader>ll <Plug>VimwikiFollowLink
nmap <Leader>ln <Plug>VimwikiNextLink
nmap <Leader>lp <Plug>VimwikiPrevLink
nmap <leader>e :Prettier<cr>
nmap <leader>cd :cd %:p:h<cr>:pwd<cr>
nmap <leader>cn :cnext<cr>
nmap <leader>cp :cprevious<cr>
nmap <leader>P "+gP
nmap <leader>p "+gp
nmap <leader>r :AsyncRun ctags .<cr>
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
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" fugitive
nmap <silent><leader>gg :Git<cr>
nmap <silent><leader>ga :Git add %:p<cr><cr>
nmap <silent><leader>gd :Gdiff<cr>
nmap <silent><leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gw :Gwrite<cr><cr>
nmap <silent><leader>gb :GBrowse<cr><cr>
nmap <silent><leader>gp :AsyncRun git push<cr>
nmap <silent><leader>go :Git checkout<space>
nmap <silent><leader>gf :Commits<cr>

"Extra
let g:gruvbox_contrast_dark='hard' "dark mode
let g:gruvbox_italic=1
let g:gruvbox_invert_selection='0' "No highlight
let g:indent_blankline_char = '¦'
let g:indent_blankline_buftype_exclude = ['terminal', 'nofile']
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
let g:lexima_enable_basic_rules=1
let g:lexima_enable_newline_rules=1
let g:lexima_enable_endwise_rules=1
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
let g:languagetool_server_command='/usr/bin/languagetool'
let g:languagetool_server_jar='/usr/share/java/languagetool/languagetool.jar'
let g:termdebug_popup = 0
let g:termdebug_wide = 163
let g:mta_use_matchparen_group = 1
let g:languagetool_lang='en-US'
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
set statusline+=\[%{BufTotal()}\] " current buffer number
set statusline+=\[%-3.(%l,%c%V%)\] " line number, column number
set statusline+=\[%{WordCount()}\] " word count
set statusline+=\[%{strlen(&ft)?&ft[0].&ft[1:]:'None'}\] " file type

" Tree-sitter simple setup
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = true, -- <= THIS LINE is the magic!
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
      disable = {'python'},
  },
  context_commentstring = {
    enable = true,
    config = {
      lua = '-- %s'
    }
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
