" Disable settings
let g:polyglot_disabled = ['javascript', 'css', 'java', 'c', 'typescript', 'python', 'cpp', 'rs', 'bash', 'zsh', 'html', 'lua', 'ruby', 'ocaml', 'haskell', 'go', 'yaml', 'json'] "treesitter

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
  use 'nathom/filetype.nvim'
  use 'lewis6991/impatient.nvim'
  use 'wbthomason/packer.nvim' -- Package manager
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim', 'nvim-telescope/telescope-media-files.nvim' }
  }
  use { 'neoclide/coc.nvim', branch = 'release', run = ':CocUpdate' }
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {'nvim-treesitter/playground', cmd="TSPlaygroundToggle"}
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'numToStr/Comment.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'windwp/nvim-ts-autotag'
  use 'rafcamlet/coc-nvim-lua'
  use 'gruvbox-community/gruvbox'
  use 'kevinhwang91/nvim-bqf'
  use {'mbbill/undotree', opt = true, cmd = 'UndotreeToggle'}

  use 'honza/vim-snippets' -- Snippets are separated from the engine
  use 'tpope/vim-fugitive' -- Git control for vim
  use 'tpope/vim-repeat' -- repeats
  use 'tpope/vim-surround' -- Allows me to change { to [ and what not
  use 'tpope/vim-vinegar'
  use 'tpope/vim-rhubarb'
  use 'mhinz/vim-grepper'
  use 'sheerun/vim-polyglot' -- vim syntax for different languages
  use 'mboughaba/i3config.vim'
  use 'ludovicchabant/vim-gutentags' -- Tags Generate
  use 'skywind3000/asyncrun.vim'
  use {'gelguy/wilder.nvim',  run=':UpdateRemotePlugins'}

  use 'lukas-reineke/indent-blankline.nvim'
  use {'norcalli/nvim-colorizer.lua', config = function() require'colorizer'.setup() end}
  use 'cohama/lexima.vim'
  use 'wellle/targets.vim' -- adds more targets like [ or ,
  use {'Valloric/MatchTagAlways', ft =  { 'html' }}
  use 'editorconfig/editorconfig-vim'
  use {'puremourning/vimspector',  run = 'python3 install_gadget.py --all'}

  use {'vimwiki/vimwiki'} -- To take notes better - testing this with vimtex
  use 'lervag/vimtex'
  use 'vigoux/LanguageTool.nvim'
  use {'turbio/bracey.vim', ft = { 'html', 'javascript', 'css' }, run = "npm install --prefix server"} -- live reloading
  use {
  'chipsenkbeil/distant.nvim',
  config = function()
    require('distant').setup {
      ['*'] = require('distant.settings').chip_default()
    }
    end
  }

  -- use 'mattn/webapi-vim'
  -- use 'TimUntersberger/neogit'
  -- use 'tweekmonster/startuptime.vim'
  -- use 'kristijanhusak/vim-carbon-now-sh'
  -- use { "folke/twilight.nvim", config = function() require("twilight").setup() end}
  -- use 'Pocco81/TrueZen.nvim'
  -- use 'tpope/vim-obsession'
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
set cursorline cursorlineopt=number
set breakindent
set breakindentopt=shift:2
set showbreak=↳

runtime cocRC.vim "cocRC rec settings
runtime myhighlights.vim

set grepformat=%f:%l:%c:%m,%f:%l:%m
if executable('vimgrep')
  set grepprg=vimgrep
elseif executable('rg')
  set grepprg=rg\ --vimgrep\ --hidden\ --follow\ --max-columns=1000\ --case-sensitive
endif

" Key remapping
let mapleader = ","

" General
nnoremap <Backspace> <C-^>
xnoremap . :norm.<CR>
nnoremap cp yap<S-}>p
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
nmap <leader>r :!tectonic % && zathura <C-r>=expand('%:r')<cr>.pdf &<cr>
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
inoremap , ,<C-g>U
inoremap . .<C-g>U
inoremap ! !<C-g>U
inoremap ? ?<C-g>U

" Movement
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

nnoremap <space>h <C-w>h
nnoremap <space>j <C-w>j
nnoremap <space>k <C-w>k
nnoremap <space>l <C-w>l
nmap <silent> <space><space> :sp <bar> :term<cr>
nmap <silent> <space>t :vsp <bar> :term<cr>
nmap <leader>t :Lexplore<cr>
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
nmap <leader><leader>f :Telescope git_files<cr>
nmap <leader>fl :Telescope git_status<cr>
nmap <leader>ff :Telescope find_files<cr>
nmap <leader>fb :Telescope buffers<cr>
nmap <leader>fm :Telescope man_pages<cr>
nmap <leader>ft :Telescope treesitter<cr>
nmap <leader>fk :Telescope keymaps<cr>
nmap <leader>fh :Telescope help_tags<cr>
nmap <leader>fd :Telescope file_browser<cr>
nmap <leader>fi :Telescope media_files theme=get_ivy<cr>
nnoremap <leader>fs :GrepperRg "" .<Left><Left><Left>
nnoremap <leader>fS :Rg<space>
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
let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }

let g:gruvbox_contrast_dark='hard' "dark mode
let g:gruvbox_italic=1
let g:gruvbox_invert_selection='0' "No highlight
let g:indent_blankline_char = '¦'
let g:indent_blankline_buftype_exclude = ['terminal', 'nofile']
colorscheme gruvbox "colorscheme

" Vimtex config
let g:vimtex_enable=1
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode='0'
let g:indentLine_setConceal='0'
let g:tex_conceal='abdmg'


" Gutentags
let g:gutentags_file_list_command = 'fd'
let g:gutentags_add_default_project_roots = '0'
let g:gutentags_generate_on_empty_buffer = '0'
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
let g:languagetool_server_command = '/usr/bin/languagetool --http'
let g:languagetool_server_jar='/usr/share/java/languagetool/languagetool.jar'
let g:languagetool_lang='en-US'
let g:termdebug_popup = 0
let g:termdebug_wide = 163
let g:mta_use_matchparen_group = 1

call wilder#setup({'modes': [':', '/', '?']})

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline(),
      \     wilder#search_pipeline(),
      \   ),
      \ ])

call wilder#set_option('renderer', wilder#wildmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ }))

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
  autocmd BufEnter github.com_*.txt set filetype=markdown
  autocmd VimResized * wincmd =
augroup END

let g:dont_write = v:false
function! My_Write(timer) abort
  let g:dont_write = v:false
  write
endfunction

function! Delay_My_Write() abort
  if g:dont_write
    return
  end
  let g:dont_write = v:true
  call timer_start(10000, 'My_Write')
endfunction

if exists('g:started_by_firenvim')
  set laststatus=0
  autocmd TextChanged * ++nested call Delay_My_Write()
  autocmd TextChangedI * ++nested call Delay_My_Write()
else
  set laststatus=2
endif

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
require('filetype').setup({
    overrides = {
        extensions = {
            emojic = 'markdown'
        },
        literal = {
            MyBackupFile = 'lua',
        },
        complex = {
            [".*git/config"] = "gitconfig",  -- Included in the plugin
            [".*i3/config"] = "i3config",
            [".gitignore"] = "gitignore",
            ["/tmp/neomutt*"] = "mail"
        },
    }
})

require('distant').setup {
    ['*'] = vim.tbl_deep_extend('force', require('distant.settings').chip_default(), {
        mode = 'ssh',
    })
}

require('Comment').setup {
    pre_hook = function()
        return require('ts_context_commentstring.internal').calculate_commentstring()
    end
}

-- https://github-wiki-see.page/m/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
local actions = require('telescope.actions')
require('telescope').load_extension('media_files')
require("telescope").setup({
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    layout_config = {
      prompt_position = "bottom",
    },
    mappings = {
      i = {
        ["<C-o>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
      layout_config = {
        height = 0.4,
      },
    },
    git_files = {
      theme = "ivy",
      layout_config = {
        height = 0.4,
      },
    },
    buffers = {
      theme = "ivy",
      layout_config = {
        height = 0.4,
      },
    },
    man_pages = {
      theme = "ivy",
      layout_config = {
        height = 0.4,
      },
    },
    keymaps = {
      theme = "ivy",
      layout_config = {
        height = 0.4,
      },
    },
    file_browser = {
      theme = "ivy",
      layout_config = {
        height = 0.4,
      },
    },
    treesitter = {
      theme = "ivy",
      layout_config = {
        height = 0.4,
      },
    },
    helptags = {
      theme = "ivy",
      layout_config = {
        height = 0.4,
      },
    },
  },
  extensions = {
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg", "ppm"},
      find_cmd = "rg --no-ignore",
    }
  },
})

require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = true, -- <= THIS LINE is the magic!
    disable = {"latex", "vim"},
    custom_captures = {
      ["function.macro"] = "GruvboxPurple",
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
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
  autotag = { enable = true, },
}
EOF
