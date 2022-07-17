lua << EOF
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
  use {'lewis6991/impatient.nvim', config = function() require('impatient') end}
  use 'nathom/filetype.nvim'

  use 'github/copilot.vim'
  use 'wbthomason/packer.nvim' -- Package manager
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim', 'nvim-telescope/telescope-media-files.nvim' }
  }

  use { 'neoclide/coc.nvim', branch = 'release', run = ':CocUpdate' }
  use 'honza/vim-snippets' -- Snippets are separated from the engine
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
  use 'rafcamlet/coc-nvim-lua'
  use 'ellisonleao/gruvbox.nvim'

  use 'kevinhwang91/nvim-bqf'
  use {'mbbill/undotree', opt = true, cmd = 'UndotreeToggle'}

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'numToStr/Comment.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'windwp/nvim-ts-autotag'
  use {'nvim-treesitter/playground'}
  -- use 'p00f/nvim-ts-rainbow'
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use {
      "danymat/neogen",
      config = function()
          require('neogen').setup {}
      end
  }

  use {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'info',
        auto_session_suppress_dirs = {'~/', '~/Downloads', '~/Documents'},
        auto_session_use_git_branch = true,
        auto_save_enabled = true
      }
    end
  }

  use { 'nmac427/guess-indent.nvim', config = function() require('guess-indent').setup {} end, }


  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup()
    end
  }


  use 'tpope/vim-fugitive' -- Git control for vim
  use 'tpope/vim-repeat' -- repeats
  use { "kylechui/nvim-surround", config = function() require("nvim-surround").setup({}) end }
  use 'mhinz/vim-grepper'
  use 'skywind3000/asyncrun.vim'
  use {'gelguy/wilder.nvim',  run=':UpdateRemotePlugins'}

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use 'lukas-reineke/indent-blankline.nvim'
  use 'windwp/nvim-autopairs'
  use {'norcalli/nvim-colorizer.lua', config = function() require'colorizer'.setup() end}
  use 'wellle/targets.vim' -- adds more targets like [ or ,
  use 'editorconfig/editorconfig-vim'
  use {'puremourning/vimspector',  run = 'python3 install_gadget.py --all'}

  use {'vimwiki/vimwiki'} -- To take notes better - testing this with vimtex
  use 'lervag/vimtex'
  use {"akinsho/toggleterm.nvim", tag = 'v2.*'}


  -- use {
  --   'chipsenkbeil/distant.nvim',
  --   config = function()
  --   require('distant').setup {
  --     ['*'] = vim.tbl_deep_extend('force', require('distant.settings').chip_default(), {
  --       mode = 'ssh',
  --       })
  --     }
  --   end
  -- }
  -- use 'alec-gibson/nvim-tetris'
  -- use 'sheerun/vim-polyglot' -- vim syntax for different languages
  -- use 'p00f/godbolt.nvim'
  -- use {'Valloric/MatchTagAlways', ft =  { 'html' }}
  -- use {'jalvesaq/Nvim-R', branch = 'stable'}
  -- use 'vigoux/LanguageTool.nvim'
  -- use {'turbio/bracey.vim', ft = { 'html', 'javascript', 'css' }, run = "npm install --prefix server"} -- live reloading
end)

-- global options
-- TODO: switch to own file
vim.opt.writebackup = false
vim.opt.conceallevel = 2
vim.opt.ignorecase = true -- search case
vim.opt.smartcase = true  -- search matters if capital letter
vim.opt.inccommand = "split" -- "for incsearch while sub
vim.opt.lazyredraw = true -- redraw for macros
vim.opt.number = true -- line number on
vim.opt.relativenumber = true -- relative line number on
vim.opt.termguicolors = true -- true colors term support
vim.opt.undofile = true -- undo even when it closes
vim.opt.foldmethod = "expr" -- treesiter time
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- treesiter
vim.opt.scrolloff = 8 -- number of lines to always go down
vim.opt.colorcolumn = "99999" -- fix columns
vim.opt.mouse = "a" -- set mouse to be on
vim.opt.cmdheight = 0 -- status line smaller
vim.opt.breakindent = true -- break indentation for long lines
vim.opt.breakindentopt = {shift = 2}
vim.opt.showbreak = "↳" -- character for line break
vim.opt.splitbelow = true -- split windows below
vim.opt.splitright = true -- split windows right
vim.opt.wildmode="list:longest,list:full" -- for : stuff
-- vim.opt.omnifunc="syntaxcomplete#Complete" -- for syntax completetion
vim.opt.wildignore:append({".javac", "node_modules", "*.pyc"})
vim.opt.suffixesadd:append({".java", ".rs"}) -- search for suffexes using gf
vim.opt.diffopt:append{"internal,algorithm:patience"}
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
-- vim.opt.guifont = "MesloLGMDZ Nerd Font Bold 16"

require("gruvbox").setup({
    overrides = {
      Normal = {bg = "#0E1018"},
      VertSplit = { bg = '#0E1018' },
      SignColumn = {bg = "#ff9900"},
      Define = { link = "GruvboxPurple" },
      Macro = { link = "GruvboxPurple" },
      TSNote = { link = "GruvboxYellow" },
      TSConstBuiltin = {link = "GruvboxPurple"},
      CocCodeLens = {fg = "#878787"},
      Comment = {fg="#fe8019", italic=true},
      Folded = {italic=true, fg="#fe8019", bg="#3c3836"},
      FoldColumn = {fg="#fe8019", bg="#0E1018"},
      CocRustTypeHint = {fg="#87afaf", bg="#0E1018"},
      CocRustChainingHint =  { fg="#87afaf", bg="#0E1018" },
      DiffAdd      = {bold=true,  reverse= false, fg=""          ,bg="#2a4333"},
      DiffChange   = {bold=true,  reverse= false, fg=""          ,bg="#333841"},
      DiffDelete   = {bold=true,  reverse= false, fg="#442d30"   ,bg="#442d30"},
      DiffText     = {bold=true,  reverse= false, fg=""          ,bg="#213352"},
      SignColumn   = { fg="#0E1018",  bg="#0E1018"},
      StatusLine   = { bg="#ffffff",  fg="#0E1018"},
      StatusLineNC = { bg="#3c3836",  fg="#0E1018"},
      CursorLineNr = { fg="#fabd2f", bg="#0E1018" },
      CocWarningFloat = { fg="#dfaf87" },
      GruvboxOrangeSign = {fg="#dfaf87", bg="#0E1018"},
      GruvboxAquaSign = {fg="#8EC07C", bg="#0E1018"},
      GruvboxGreenSign = {fg="#b8bb26", bg="#0E1018"},
      GruvboxRedSign = {fg="#fb4934", bg="#0E1018"},
      GruvboxBlueSign = {fg="#83a598", bg="#0E1018"}
    }
})

vim.cmd([[
colorscheme gruvbox "colorscheme
runtime cocRC.vim " cocRC rec settings
]])
EOF

" Key remapping
let mapleader = ","

" General
nnoremap <Backspace> <C-^>
xnoremap . :norm.<CR>
nnoremap cp yap<S-}>p
" noremap gx yiW:!open "<C-r>"" & <CR>
nmap <a-x> <nop>
nmap <Leader>ww :VimwikiIndex<cr>
nmap <Leader>wd :VimwikiMakeDiaryNote<cr>
nmap <Leader>ll <Plug>VimwikiFollowLink
nmap <Leader>ln <Plug>VimwikiNextLink
nmap <Leader>lp <Plug>VimwikiPrevLink
" nmap <Leader>lg :LazyGit<cr>
nmap <leader>e :Prettier<cr>
nmap <leader>cd :cd %:p:h<cr>:pwd<cr>
nmap <leader>cn :cnext<cr>
nmap <leader>cp :cprevious<cr>
nmap <leader>P "+gP
nmap <leader>p "+gp
nmap <leader>sv :source $MYVIMRC<cr>
nmap <leader>sr :%s/\<<C-r><C-w>\>//g<Left><Left>
nmap <leader>z [s1z=``
xmap <leader>y "*y :let @+=@*<cr>
nmap <leader>1 :bp<cr>
nmap <leader>2 :bn<cr>
nmap <leader>3 :retab<cr>:FixWhitespace<cr>
nmap <leader>4 :Format<cr>
nmap <leader>5 :call SpellToggle()<cr>
nnoremap <leader>u :UndotreeToggle<cr>
inoremap , ,<C-g>U
inoremap . .<C-g>U
inoremap ! !<C-g>U
inoremap ? ?<C-g>U

" General
nnoremap <Backspace> <C-^>
xnoremap . :norm.<CR>
nnoremap cp yap<S-}>p
" noremap gx yiW:!open "<C-r>"" & <CR>
nmap <Leader>ww :VimwikiIndex<cr>
nmap <Leader>wd :VimwikiMakeDiaryNote<cr>
nmap <Leader>ll <Plug>VimwikiFollowLink
nmap <Leader>ln <Plug>VimwikiNextLink
nmap <Leader>lp <Plug>VimwikiPrevLink
nmap <Leader>lg :LazyGit<cr>
nmap <leader>e :Prettier<cr>
nmap <leader>cd :cd %:p:h<cr>:pwd<cr>
nmap <leader>cn :cnext<cr>
nmap <leader>cp :cprevious<cr>
nmap <leader>P "+gP
nmap <leader>p "+gp
nmap <leader>sv :source $MYVIMRC<cr>
nmap <leader>sr :%s/\<<C-r><C-w>\>//g<Left><Left>
nmap <leader>z [s1z=``
xmap <leader>y "*y :let @+=@*<cr>
nmap <leader>1 :bp<cr>
nmap <leader>2 :bn<cr>
nmap <leader>3 :retab<cr>:FixWhitespace<cr>
nmap <leader>4 :Format<cr>
nmap <leader>5 :call SpellToggle()<cr>
nnoremap <leader>u :UndotreeToggle<cr>
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
nmap <silent> <space><space> :ToggleTerm<cr>
nmap <silent> <space>t :ToggleTerm size=60 direction=vertical<cr>
" nmap <leader>t :Lexplore<cr>
nmap <Leader>wh <C-w>t<C-w>H
nmap <Leader>wk <C-w>t<C-w>K
nmap <down> :resize +2<cr>
nmap <up> :resize -2<cr>
nmap <right> :vertical resize +2<CR>
nmap <left> :vertical resize -2<CR>
nmap <expr> j (v:count? 'j' : 'gj')
nmap <expr> k (v:count? 'k' : 'gk')
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
nmap <leader>fi :Telescope media_files<cr>
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

if has('nvim') && executable('nvr')
  let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

if has('mac')
  nmap <leader>0 :silent !open %<cr>
elseif has('linux')
  nmap <leader>0 :silent !firefox %<cr>
else
  nmap <leader>0 :silent !firefox %<cr>
endif

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

" Vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode='0'
let g:indentLine_setConceal='0'
let g:tex_conceal='abdmg'

" Other settings
let g:polyglot_disabled = ['javascript', 'css', 'java', 'c', 'typescript', 'python', 'cpp', 'rs', 'bash', 'zsh', 'html', 'lua', 'ruby', 'ocaml', 'haskell', 'go', 'yaml', 'json'] "treesitter
let g:vimwiki_list = [{'path': '~/Work/vimwiki'}]
let g:python3_host_prog = '/opt/homebrew/bin/python3'
let g:rust_clip_command = 'xclip -selection clipboard'
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_winsize = -28
let g:netrw_browsex_viewer= "xdg-open"
let g:python3_host_prog="/usr/bin/python3"
let g:languagetool_server_command = '/usr/bin/languagetool --http'
let g:languagetool_server_jar='/usr/share/java/languagetool/languagetool.jar'
let g:languagetool_lang='en-US'
let g:termdebug_popup = 0
let g:termdebug_wide = 163

" wilder
call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'language': 'python',
      \       'fuzzy': 1,
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': wilder#python_fuzzy_pattern(),
      \       'sorter': wilder#python_difflib_sorter(),
      \       'engine': 're',
      \     }),
      \   ),
      \ ])

call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'left': [' '],
      \ 'right': [' ', wilder#popupmenu_scrollbar({'thumb_char': ' ', 'thumb_hl': 'PmenuThumb'})],
      \ 'highlights': {
      \   'default': wilder#make_hl('WilderMenu', 'Pmenu', [{}, {}, {'foreground': '#fff', 'background': '#0E1018'}]),
      \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f', 'background': '#0E1018'}]),
      \ },
      \ }))

"Commands
command! FixWhitespace :%s/\s\+$//e
command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' http://ix.io | tr -d '\n' | xclip -i -selection clipboard

" autocmds
augroup Random
  autocmd!
  " autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/skeleton.tex
  autocmd VimLeavePre * :call coc#rpc#kill()
  autocmd VimLeave * if get(g:, 'coc_process_pid', 0) | call system('kill -9 -'.g:coc_process_pid) | endif
  autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
  autocmd BufEnter github.com_*.txt set filetype=markdown
  autocmd VimResized * wincmd =
  autocmd InsertEnter * set timeoutlen=100
  autocmd InsertLeave * set timeoutlen=1000
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
  let g:auto_session_enabled = v:false
  autocmd TextChanged * ++nested call Delay_My_Write()
  autocmd TextChangedI * ++nested call Delay_My_Write()
else
  set laststatus=3
endif

" coc
let g:coc_global_extensions = [
  \ 'coc-java',
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

" statusline
set noshowmode
let g:currentmode={
  \ 'n'  : 'Normal ',
  \ 'no' : 'N·Operator ',
  \ 'v'  : 'Visual ',
  \ 'V'  : 'V·Line ',
  \ '' : 'V·Block ',
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
    let l:home = '/Users/' . $USER . '/'
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
        let l:branch = FugitiveHead()
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
lua << EOF
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>t", ":lua require('neogen').generate()<CR>", opts)

require("toggleterm").setup {
  shade_terminals = false,
  open_mapping = [[<space>,]]
}

local Terminal  = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },

  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

require('filetype').setup({
    overrides = {
        extensions = {
            emojic = "markdown",
            s = "asm",
            wiki = "vimwiki"
        },
        literal = {
            known_hosts = "sshknownhosts"
        },
        complex = {
            [".gitignore"] = "gitignore",
            ["tmux.conf"] = "tmux",
            ["/tmp/neomutt*"] = "mail"
        },
    }
})

require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt"},
  map_cr = false,
})

require('Comment').setup {
    pre_hook = function()
        return require('ts_context_commentstring.internal').calculate_commentstring()
    end
}

-- https://github-wiki-see.page/m/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local Job = require('plenary.job')
local _bad = { '.*%.csv', '.*%.lua' } -- Put all filetypes that slow you down in this array
local bad_files = function(filepath)
  for _, v in ipairs(_bad) do
    if filepath:match(v) then
      return false
    end
  end

  return true
end

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then opts.use_ft_detect = true end
  opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = 'file',
    args = { '--mime-type', '-b', filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], '/')[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
        end)
      end
    end
  }):sync()
end

require('telescope').load_extension('media_files')
require("telescope").setup({
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    buffer_previewer_maker = new_maker,
    layout_config = {
      prompt_position = "bottom",
    },
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
      -- hidden = true,
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
      sections = {"ALL"},
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
    help_tags = {
      theme = "ivy",
      layout_config = {
        height = 0.5,
      },
    },
  },
  extensions = {
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg", "ppm"},
    }
  },
})

-- require("godbolt").setup({
--     c = { compiler = "cg112", options = {} },
--     cpp = { compiler = "g112", options = {} },
--     rust = { compiler = "r1560", options = {} }
-- })

require("indent_blankline").setup {
  char = '¦',
  filetype_exclude = {
    "help",
    "terminal",
    "dashboard",
    "packer",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "qf",
    },
  buftype_exclude = {"terminal", 'nofile', 'quickfix'},
  show_current_context = false,
  show_current_context_start = false,
}

local parsers = require("nvim-treesitter.parsers")
local enabled_list = {"clojure", "fennel", "commonlisp", "query"}
require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {"vim", "latex"},
    custom_captures = {
      ["@function.macro"] = "GruvboxPurple",
    },
  },
  playground = {
    enable = true,
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
  incremental_selection = {
      enable = true,
      keymaps = {
          init_selection = '<space>i',
          scope_incremental = '<space>i',
          node_incremental = '<space>n',
          node_decremental = '<space>p',
      },
  },
  refactor = {
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
  },
  rainbow = {
    enable = true,
    -- Enable only for lisp like languages
    disable = vim.tbl_filter(
      function(p)
        local disable = true
        for _, lang in pairs(enabled_list) do
          if p==lang then disable = false end
        end
        return disable
      end,
      parsers.available_parsers()
    )
  },
  autotag = { enable = true, },
}
EOF
