local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

if vim.fn.executable('nvr') == 0 then
  execute('!pip install --user neovim-remote')
end

vim.api.nvim_create_augroup("Packer", {})
vim.api.nvim_create_autocmd("BufWritePost", {pattern = "init.lua", command = "PackerCompile"})

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
  use 'rafcamlet/coc-nvim-lua'
  use 'honza/vim-snippets' -- Snippets are separated from the engine
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
  use 'ellisonleao/gruvbox.nvim'

  use 'kevinhwang91/nvim-bqf'
  use {'mbbill/undotree', opt = true, cmd = 'UndotreeToggle'}
  use 'monaqa/dial.nvim'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'numToStr/Comment.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'windwp/nvim-ts-autotag'
  use {'nvim-treesitter/playground'}
  use {'haringsrob/nvim_context_vt', config = function() require('nvim_context_vt').setup({ disable_virtual_lines = true, min_rows = 8}) end }
  -- use 'p00f/nvim-ts-rainbow'
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
      require('gitsigns').setup({
        signcolumn = false,
      })
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
vim.opt.guifont = "MesloLGMDZ Nerd Font Bold 16"
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

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
    ContextVt = {fg = "#878787"},
    Comment = {fg="#fe8019", italic=true},
    Folded = {italic=true, fg="#fe8019", bg="#3c3836"},
    FoldColumn = {fg="#fe8019", bg="#0E1018"},
    CocRustTypeHint = {fg="#87afaf", bg="#0E1018"},
    CocRustChainingHint =  { fg="#87afaf", bg="#0E1018" },
    DiffAdd      = {bold=true,  reverse= false, fg=""          ,bg="#2a4333"},
    DiffChange   = {bold=true,  reverse= false, fg=""          ,bg="#333841"},
    DiffDelete   = {bold=true,  reverse= false, fg="#442d30"   ,bg="#442d30"},
    DiffText     = {bold=true,  reverse= false, fg=""          ,bg="#213352"},
    StatusLine   = { bg="#ffffff",  fg="#0E1018"},
    StatusLineNC = { bg="#3c3836",  fg="#0E1018"},
    CursorLineNr = { fg="#fabd2f", bg="#0E1018" },
    CocWarningFloat = { fg="#dfaf87" },
    GruvboxOrangeSign = {fg="#dfaf87", bg="#0E1018"},
    GruvboxAquaSign = {fg="#8EC07C", bg="#0E1018"},
    GruvboxGreenSign = {fg="#b8bb26", bg="#0E1018"},
    GruvboxRedSign = {fg="#fb4934", bg="#0E1018"},
    GruvboxBlueSign = {fg="#83a598", bg="#0E1018"},
    WilderMenu = {fg = "#ebdbb2", bg = "#0E1018"},
    WilderAccent = {fg = "#f4468f", bg = "#0E1018"}
  }
})

local keyset = vim.keymap.set
vim.cmd([[
colorscheme gruvbox "colorscheme
runtime cocRC.vim " cocRC rec settings

"Commands
command! FixWhitespace :%s/\s\+$//e
command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' http://ix.io | tr -d '\n' | xclip -i -selection clipboard

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
]])

-- Key remapping
vim.g.mapleader = ","
keyset("i", "jk", "<esc>")

-- dial
keyset("n", "<C-a>", require("dial.map").inc_normal())
keyset("n", "<C-x>", require("dial.map").dec_normal())
keyset("v", "<C-a>", require("dial.map").inc_visual())
keyset("v", "<C-x>", require("dial.map").dec_visual())
keyset("v", "g<C-a>", require("dial.map").inc_gvisual())
keyset("v", "g<C-x>", require("dial.map").dec_gvisual())

-- remap to include undo and more things
keyset("i", "," ,",<C-g>U")
keyset("i", "." ,".<C-g>U")
keyset("i", "!" ,"!<C-g>U")
keyset("i", "?" ,"?<C-g>U")
keyset("x", ".", ":norm.<cr>")
keyset("x", "<leader>y", '"*y :let @+=@*<cr>')
keyset("n", "<a-x>", "<nop>")
keyset("n", "<backspace>", "<C-^")
keyset("n", "cp", "yap<S-}p")

-- general
keyset("n", "<space><space>", ":ToggleTerm size=15<cr>", {silent = true})
keyset("n", "<space>t", ":ToggleTerm size=60 direction=vertical", {silent = true})
keyset("n", "<leader>t", ":lua require('neogen').generate()<CR>", {silent = true})
keyset("n", "<leader>u", ":UndotreeToggle<cr>")
keyset("n", "<Leader>ww", ":VimwikiIndex<cr>")
keyset("n", "<Leader>wd", ":VimwikiMakeDiaryNote<cr>")
keyset('n', '<Leader>ll', '<Plug>VimwikiFollowLink')
keyset('n', '<Leader>ln', '<Plug>VimwikiNextLink')
keyset('n', '<Leader>lp', '<Plug>VimwikiPrevLink')
keyset("n", "<leader>e", ":Prettier<cr>")
keyset("n", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>")
keyset("n", "<leader>cn", ":cnext<cr>")
keyset("n", "<leader>cp", ":cprevious<cr>")
keyset("n", "<leader>P", '"+gP')
keyset("n", "<leader>p", '"+gp')
keyset("n", "<leader>sv", ":source $MYVIMRC<cr>")
keyset("n", "<leader>z",  "[s1z=``")
keyset("n", "<leader>1",  ":bp<cr>")
keyset("n", "<leader>2",  ":bn<cr>")
keyset("n", "<leader>3",  ":retab<cr>:FixWhitespace<cr>")
keyset("n", "<leader>4",  ":Format<cr>")
keyset("n", "<leader>5",  ":call SpellToggle()<cr>")
keyset("n", "<leader>sr", ':%s/<<C-r><C-w>>//g<Left><Left>')

-- Movement
keyset("v", "J", ":m '>+1<cr>gv=gv")
keyset("v", "K", ":m '<-2<cr>gv=gv")
keyset("n", "<space>h", "<c-w>h")
keyset("n", "<space>j", "<c-w>j")
keyset("n", "<space>k", "<c-w>k")
keyset("n", "<space>l", "<c-w>l")
keyset("n", "<leader>wh", "<c-w>t<c-h>H")
keyset("n", "<leader>wk", "<c-w>t<c-h>K")
keyset("n", "<down>", ":resize +2<cr>")
keyset("n", "<up>", ":resize -2<cr>")
keyset("n", "<right>", ":vertical resize +2<cr>")
keyset("n", "<left>", ":vertical resize -2<cr>")
keyset("n", "j", "(v:count ? 'j' : 'gj')", {expr = true})
keyset("n", "k", "(v:count ? 'k' : 'gk')", {expr = true})

-- Telescope + grepper
keyset("n", "<leader><leader>f", ":Telescope git_files<cr>")
keyset("n", "<leader>fl", ":Telescope git_status<cr>")
keyset("n", "<leader>ff", ":Telescope find_files<cr>")
keyset("n", "<leader>fb", ":Telescope buffers<cr>")
keyset("n", "<leader>fm", ":Telescope man_pages<cr>")
keyset("n", "<leader>ft", ":Telescope treesitter<cr>")
keyset("n", "<leader>fk", ":Telescope keymaps<cr>")
keyset("n", "<leader>fh", ":Telescope help_tags<cr>")
keyset("n", "<leader>fd", ":Telescope file_browser<cr>")
keyset("n", "<leader>fi", ":Telescope media_files<cr>")
keyset("n", "<leader>fs", ':GrepperRg "" .<Left><Left><Left>')
keyset("n", "<leader>fS", ":Rg<space>")
keyset("n", "<leader>*", ":Grepper -tool rg -cword -noprompt<cr>")
keyset("n", "gs", "<Plug>(GrepperOperator)")
keyset("x", "gs", "<Plug>(GrepperOperator)")

-- fugitive
keyset("n", "<leader>gg", ":Git<cr>", {silent = true})
keyset("n", "<leader>ga", ":Git add %:p<cr><cr>", {silent = true})
keyset("n", "<leader>gd", ":Gdiff<cr>", {silent = true})
keyset("n", "<leader>ge", ":Gedit<cr>", {silent = true})
keyset("n", "<leader>gw", ":Gwrite<cr>", {silent = true})
keyset("n", "<leader>gf", ":Commits<cr>", {silent = true})

if vim.fn.has('mac') == 1 then
  keyset("n", "<leader>0", ":silent !open %<cr>")
else
  keyset("n", "<leader>0", ":silent !xdg-open %<cr>")
end


-- Vimtex config
vim.g.tex_flavor='latex'
vim.g.vimtex_view_method='skim'
vim.g.vimtex_quickfix_mode=0
vim.g.indentLine_setConceal=0
vim.g.tex_conceal='abdmg'

-- Other settings
vim.g.coc_global_extensions = { 'coc-java', 'coc-rust-analyzer', 'coc-html', 'coc-css', 'coc-vimlsp', 'coc-tsserver', 'coc-snippets', 'coc-emmet', 'coc-json', 'coc-texlab', 'coc-emoji' }
-- vim.g.polyglot_disabled = { 'javascript', 'css', 'java', 'c', 'typescript', 'python', 'cpp', 'rs', 'bash', 'zsh', 'html', 'lua', 'ruby', 'ocaml', 'haskell', 'go', 'yaml', 'json' } -- "treesitter
vim.g.vimwiki_list = {{path = '~/Work/vimwiki'}}
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -28
vim.g.netrw_browsex_viewer = "open"
vim.g.termdebug_popup = 0
vim.g.termdebug_wide = 163

-- wilder
local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('pipeline', {
  wilder.branch(
    wilder.python_file_finder_pipeline({
      file_command = function(_, arg)
        if string.find(arg, '.') ~= nil then
          return {'fd', '-tf', '-H'}
        else
          return {'fd', '-tf'}
        end
      end,
      dir_command = {'fd', '-td'},
      filters = {'fuzzy_filter', 'difflib_sorter'},
    }),
    wilder.cmdline_pipeline(),
    wilder.python_search_pipeline()
  ),
})

wilder.set_option('renderer', wilder.popupmenu_renderer({
  highlighter = wilder.basic_highlighter(),
  left = {' '},
  right = {' ', wilder.popupmenu_scrollbar({thumb_char = ' '})},
  highlights = {
    default = 'WilderMenu',
    accent = 'WilderAccent'
  },
}))

-- firenvim
vim.cmd 'let g:firenvim_config = { "globalSettings": { "alt": "all", }, "localSettings": { ".*": { "cmdline": "neovim", "content": "text", "priority": 0, "selector": "textarea", "takeover": "never", }, } }'

if vim.g.started_by_firenvim then
  vim.opt.laststatus = 0
  vim.g.auto_session_enabled = false
  vim.cmd([[
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

  autocmd TextChanged * ++nested call Delay_My_Write()
  autocmd TextChangedI * ++nested call Delay_My_Write()
  ]])
  vim.api.nvim_create_autocmd("BufEnter", {pattern = "github.com_*.txt", command = "set filename=markdown"})
else
  vim.opt.laststatus = 3
end

-- autocmds
vim.api.nvim_create_augroup("Random", {})
vim.api.nvim_create_autocmd('VimResized', {
  group = "Random",
  desc = 'Keep windows equally resized',
  command = 'tabdo wincmd =',
})
vim.api.nvim_create_autocmd("TermOpen", {group = "Random", command="setlocal nonumber norelativenumber signcolumn=no"})
vim.api.nvim_create_autocmd("InsertEnter", {group = "Random", command = "set timeoutlen=100"})
vim.api.nvim_create_autocmd("InsertLeave", {group = "Random", command = "set timeoutlen=1000"})

-- toggleterm
require("toggleterm").setup {
  shade_terminals = false
}

local Terminal  = require('toggleterm.terminal').Terminal

local lg_cmd = "lazygit $(pwd)"
if vim.v.servername ~= nil then
  lg_cmd = string.format("NVIM_SERVER=%s lazygit -ucf ~/.config/nvim/lazygit.toml $(pwd)", vim.v.servername)
end

vim.cmd([[let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"]])

local lazygit = Terminal:new({
  cmd = lg_cmd,
  count = 5,
  direction = "float",
  float_opts = {
    border = "double",
    width = vim.o.columns,
    height = vim.o.lines
  },

  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
})

---@diagnostic disable-next-line: lowercase-global
function _edit(fn, line_number)
  local edit_cmd = string.format(":e %s", fn)
  if line_number ~= nil then
    edit_cmd = string.format(":e +%d %s", line_number, fn)
  end
  vim.cmd(edit_cmd)
end

---@diagnostic disable-next-line: lowercase-global
function _lazygit_toggle()
  lazygit:toggle()
end

keyset("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {silent = true})

-- filteype
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
  -- ensure_installed = "maintained",
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
