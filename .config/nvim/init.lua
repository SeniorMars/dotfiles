local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data') ..
                         '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                install_path)
end

if vim.fn.executable('nvr') == 0 then
    execute('!pip3 install --user neovim-remote')
end

vim.api.nvim_create_augroup("Packer", {})
vim.api.nvim_create_autocmd("BufWritePost", {
    group = "Packer",
    pattern = "init.lua",
    command = "PackerCompile"
})

local use = require('packer').use
require('packer').startup(function()
    use {
        'lewis6991/impatient.nvim',
        config = function() require('impatient') end
    }
    use 'nathom/filetype.nvim'

    use 'github/copilot.vim'
    use 'wbthomason/packer.nvim' -- Package manager
    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'}
    }

    use {'neoclide/coc.nvim', branch = 'release', run = ':CocUpdate'}
    use 'rafcamlet/coc-nvim-lua'
    use 'honza/vim-snippets' -- Snippets are separated from the engine
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }
    use 'ellisonleao/gruvbox.nvim'

    use 'kevinhwang91/nvim-bqf'
    use 'sbdchd/neoformat'
    use {'mbbill/undotree', opt = true, cmd = 'UndotreeToggle'}
    use 'monaqa/dial.nvim'

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'numToStr/Comment.nvim'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'windwp/nvim-ts-autotag'
    use {'nvim-treesitter/playground'}
    use {
        'haringsrob/nvim_context_vt',
        config = function()
            require('nvim_context_vt').setup({
                disable_virtual_lines = true,
                -- disabe_virtual_lines_on_windows
                min_rows = 8
            })
        end
    }
    -- use 'p00f/nvim-ts-rainbow'
    use {"danymat/neogen", config = function() require('neogen').setup {} end}

    use {
        'rmagatti/auto-session',
        config = function()
            require('auto-session').setup {
                log_level = 'info',
                auto_session_suppress_dirs = {
                    '~/', '~/Downloads', '~/Documents'
                },
                auto_session_use_git_branch = true,
                auto_save_enabled = true
            }
        end
    }

    use {
        'nmac427/guess-indent.nvim',
        config = function() require('guess-indent').setup {} end
    }

    use 'tpope/vim-fugitive' -- Git control for vim
    use 'tpope/vim-repeat' -- repeats
    use {
        "kylechui/nvim-surround",
        config = function() require("nvim-surround").setup({}) end
    }
    use 'mhinz/vim-grepper'
    use {'gelguy/wilder.nvim', run = ':UpdateRemotePlugins'}

    use {'lewis6991/gitsigns.nvim'}

    use 'lukas-reineke/indent-blankline.nvim'
    use 'windwp/nvim-autopairs'
    use({"uga-rosa/ccc.nvim", branch = "0.7.2"})
    use 'wellle/targets.vim' -- adds more targets like [ or ,
    use 'editorconfig/editorconfig-vim'
    use {'puremourning/vimspector', run = 'python3 install_gadget.py --all'}

    use {'vimwiki/vimwiki'} -- To take notes better - testing this with vimtex
    use 'lervag/vimtex'
    use {"akinsho/toggleterm.nvim", tag = 'v2.*'}

    -- use 'sheerun/vim-polyglot' -- vim syntax for different languages
    -- use 'tweekmonster/startuptime.vim'
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
    -- use {'Valloric/MatchTagAlways', ft =  { 'html' }}
    -- use {'jalvesaq/Nvim-R', branch = 'stable'}
    -- use 'vigoux/LanguageTool.nvim'
    -- use {'turbio/bracey.vim', ft = { 'html', 'javascript', 'css' }, run = "npm install --prefix server"} -- live reloading
end)

-- global options
vim.opt.writebackup = false
vim.opt.termguicolors = true
vim.opt.conceallevel = 2
vim.opt.ignorecase = true -- search case
vim.opt.smartcase = true -- search matters if capital letter
vim.opt.inccommand = "split" -- "for incsearch while sub
vim.opt.lazyredraw = true -- redraw for macros
vim.opt.number = true -- line number on
vim.opt.relativenumber = true -- relative line number on
vim.opt.termguicolors = true -- true colors term support
vim.opt.undofile = true -- undo even when it closes
vim.opt.foldmethod = "expr" -- treesiter time
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- treesiter
vim.opt.scrolloff = 8 -- number of lines to always go down
vim.opt.signcolumn = "number"
vim.opt.colorcolumn = "99999" -- fix columns
vim.opt.mouse = "a" -- set mouse to be on
-- vim.opt.cmdheight = 0 -- status line smaller
vim.opt.breakindent = true -- break indentation for long lines
vim.opt.breakindentopt = {shift = 2}
vim.opt.showbreak = "↳" -- character for line break
vim.opt.splitbelow = true -- split windows below
vim.opt.splitright = true -- split windows right
vim.opt.wildmode = "list:longest,list:full" -- for : stuff
vim.opt.wildignore:append({".javac", "node_modules", "*.pyc"})
vim.opt.suffixesadd:append({".java", ".rs"}) -- search for suffexes using gf
vim.opt.diffopt:append{"internal,algorithm:patience"}
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.showmode = false
vim.o.sessionoptions =
    "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- colorscheme
require("gruvbox").setup({
    overrides = {
        Normal = {bg = "#0E1018"},
        VertSplit = {bg = '#0E1018'},
        SignColumn = {bg = "#ff9900"},
        Define = {link = "GruvboxPurple"},
        Macro = {link = "GruvboxPurple"},
        TSNote = {link = "GruvboxYellow"},
        TSConstBuiltin = {link = "GruvboxPurple"},
        CocCodeLens = {fg = "#878787"},
        ContextVt = {fg = "#878787"},
        Comment = {fg = "#fe8019", italic = true},
        Folded = {italic = true, fg = "#fe8019", bg = "#3c3836"},
        FoldColumn = {fg = "#fe8019", bg = "#0E1018"},
        DiffAdd = {bold = true, reverse = false, fg = "", bg = "#2a4333"},
        DiffChange = {bold = true, reverse = false, fg = "", bg = "#333841"},
        DiffDelete = {
            bold = true,
            reverse = false,
            fg = "#442d30",
            bg = "#442d30"
        },
        DiffText = {bold = true, reverse = false, fg = "", bg = "#213352"},
        StatusLine = {bg = "#ffffff", fg = "#0E1018"},
        StatusLineNC = {bg = "#3c3836", fg = "#0E1018"},
        CursorLineNr = {fg = "#fabd2f", bg = "#0E1018"},
        CocWarningFloat = {fg = "#dfaf87"},
        CocInlayHint = {fg = "#87afaf"},
        -- DiagnosticVirtualTextInfo = {link = "GruvboxAqua"},
        -- DiagnosticVirtualTextHint = {fg = "#87afaf", bg = "#0E1018"},
        DiagnosticVirtualTextWarn = {fg = "#dfaf87"},
        GruvboxOrangeSign = {fg = "#dfaf87", bg = "#0E1018"},
        GruvboxAquaSign = {fg = "#8EC07C", bg = "#0E1018"},
        GruvboxGreenSign = {fg = "#b8bb26", bg = "#0E1018"},
        GruvboxRedSign = {fg = "#fb4934", bg = "#0E1018"},
        GruvboxBlueSign = {fg = "#83a598", bg = "#0E1018"},
        WilderMenu = {fg = "#ebdbb2", bg = "#0E1018"},
        WilderAccent = {fg = "#f4468f", bg = "#0E1018"}
    }
})

vim.cmd.colorscheme("gruvbox")
vim.api.nvim_create_user_command("FixWhitespace", [[%s/\s\+$//e]], {})

function SpellToggle()
    if vim.opt.spell:get() then
        vim.opt_local.spell = false
        vim.opt_local.spelllang = "en"
    else
        vim.opt_local.spell = true
        vim.opt_local.spelllang = {"en_us", "de"}
    end
end

-- statusline
local git_branch = function()
    if vim.g.loaded_fugitive then
        local branch = vim.fn.FugitiveHead()
        if branch ~= '' then return string.upper(" " .. branch) end
    end
    return ''
end

local file_path = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if buf_name == "" then return "[No Name]" end
    local home = vim.env.HOME
    local is_term = false
    local file_dir = ""

    if buf_name:sub(1, 5):find("term") ~= nil then
        file_dir = vim.env.PWD
        is_term = true
    else
        file_dir = vim.fn.expand("%:p:h")
    end

    if file_dir:find(home, 0, true) ~= nil then
        file_dir = file_dir:gsub(home, "~", 1)
    end

    if vim.api.nvim_win_get_width(0) <= 80 then
        file_dir = vim.fn.pathshorten(file_dir)
    end

    if is_term then
        return file_dir
    else
        return string.format("%s/%s", file_dir, vim.fn.expand("%:t"))
    end
end

local word_count = function()
    if vim.fn.wordcount().visual_words ~= nil then
        return vim.fn.wordcount().visual_words
    else
        return vim.fn.wordcount().words
    end
end

local modes = setmetatable({
    ['n'] = {'NORMAL', 'N'},
    ['no'] = {'N·OPERATOR', 'N·P'},
    ['v'] = {'VISUAL', 'V'},
    ['V'] = {'V·LINE', 'V·L'},
    [''] = {'V·BLOCK', 'V·B'},
    [''] = {'V·BLOCK', 'V·B'},
    ['s'] = {'SELECT', 'S'},
    ['S'] = {'S·LINE', 'S·L'},
    [''] = {'S·BLOCK', 'S·B'},
    ['i'] = {'INSERT', 'I'},
    ['ic'] = {'INSERT', 'I'},
    ['R'] = {'REPLACE', 'R'},
    ['Rv'] = {'V·REPLACE', 'V·R'},
    ['c'] = {'COMMAND', 'C'},
    ['cv'] = {'VIM·EX', 'V·E'},
    ['ce'] = {'EX', 'E'},
    ['r'] = {'PROMPT', 'P'},
    ['rm'] = {'MORE', 'M'},
    ['r?'] = {'CONFIRM', 'C'},
    ['!'] = {'SHELL', 'S'},
    ['t'] = {'TERMINAL', 'T'}
}, {
    __index = function()
        return {'UNKNOWN', 'U'} -- handle edge cases
    end
})

local get_current_mode = function()
    local current_mode = vim.api.nvim_get_mode().mode
    if vim.api.nvim_win_get_width(0) <= 80 then
        return string.format('%s ', modes[current_mode][2])
    else
        return string.format('%s ', modes[current_mode][1])
    end
end

---@diagnostic disable-next-line: lowercase-global
function status_line()
    return table.concat {
        get_current_mode(), -- get current mode
        "%{toupper(&spelllang)}", -- display language and if spell is on
        git_branch(), -- branch name
        " %<", -- spacing
        file_path(), -- smart full path filename
        "%h%m%r%w", -- help flag, modified, readonly, and preview
        "%=", -- right align
        "%{get(b:,'gitsigns_status','')}[", word_count(), -- word count
        "][%-3.(%l|%c]", -- line number, column number
        "[%{strlen(&ft)?&ft[0].&ft[1:]:'None'}]" -- file type
    }
end

vim.opt.statusline = "%!luaeval('status_line()')"

-- Key remapping
vim.g.mapleader = ","
local keyset = vim.keymap.set
keyset("i", "jk", "<esc>")
-- vim.g.copilot_no_tab_map  = true
-- keyset("i", "<c-v>", [[copilot#Accept("\<c-v>")]], {expr = true, silent = true, script = true})

-- dial
keyset("n", "<C-a>", require("dial.map").inc_normal())
keyset("n", "<C-x>", require("dial.map").dec_normal())
keyset("v", "<C-a>", require("dial.map").inc_visual())
keyset("v", "<C-x>", require("dial.map").dec_visual())
keyset("v", "g<C-a>", require("dial.map").inc_gvisual())
keyset("v", "g<C-x>", require("dial.map").dec_gvisual())

-- remap to include undo and more things
keyset("i", ",", ",<C-g>U")
keyset("i", ".", ".<C-g>U")
keyset("i", "!", "!<C-g>U")
keyset("i", "?", "?<C-g>U")
keyset("x", ".", ":norm.<cr>")
keyset("x", "<leader>y", '"*y :let @+=@*<cr>')
keyset("n", "<a-x>", "<nop>")
keyset("n", "<backspace>", "<C-^")
keyset("n", "cp", "yap<S-}p")

-- general
keyset("n", "<space><space>", ":ToggleTerm size=15<cr>", {silent = true})
keyset("n", "<space>t", ":ToggleTerm size=60 direction=vertical<cr>",
       {silent = true})
keyset("n", "<leader>t", ":lua require('neogen').generate()<CR>",
       {silent = true})
keyset("n", "<leader>u", ":UndotreeToggle<cr>")
keyset("n", "<Leader>ww", ":VimwikiIndex<cr>")
keyset("n", "<Leader>wd", ":VimwikiMakeDiaryNote<cr>")
keyset('n', '<Leader>ll', '<Plug>VimwikiFollowLink')
keyset('n', '<Leader>ln', '<Plug>VimwikiNextLink')
keyset('n', '<Leader>lp', '<Plug>VimwikiPrevLink')
keyset("n", "<leader>e", ":Neoformat<cr>")
keyset("n", "<leader>q", ":!zathura <C-r>=expand('%:r')<cr>.pdf &<cr>")
keyset("n", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>")
keyset("n", "<leader>cn", ":cnext<cr>")
keyset("n", "<leader>cp", ":cprevious<cr>")
keyset("n", "<leader>P", '"+gP')
keyset("n", "<leader>p", '"+gp')
keyset("n", "<leader>sv", ":source $MYVIMRC<cr>")
keyset("n", "<leader>z", "[s1z=``")
keyset("n", "<leader>1", ":bp<cr>")
keyset("n", "<leader>2", ":bn<cr>")
keyset("n", "<leader>3", ":retab<cr>:FixWhitespace<cr>")
keyset("n", "<leader>4", ":Format<cr>")
keyset("n", "<leader>5", ":lua SpellToggle()<cr>")
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
keyset("n", "<leader>fl", ":Telescope live_grep<cr>")
keyset("n", "<leader>ff", ":Telescope find_files<cr>")
keyset("n", "<leader>fb", ":Telescope buffers<cr>")
keyset("n", "<leader>fm", ":Telescope man_pages<cr>")
keyset("n", "<leader>ft", ":Telescope treesitter<cr>")
keyset("n", "<leader>fk", ":Telescope keymaps<cr>")
keyset("n", "<leader>fh", ":Telescope help_tags<cr>")
keyset("n", "<leader>fd", ":Telescope file_browser<cr>")
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

if vim.fn.has('mac') then
    keyset("n", "<leader>0", ":silent !open -a Firefox %<cr>")
else
    keyset("n", "<leader>0", ":silent !xdg-open %<cr>")
end

-- coc settings
local ccc = require("ccc")
ccc.setup({
    highlighter = {auto_enable = true},
    pickers = {
        ccc.picker.hex, ccc.picker.css_rgb, ccc.picker.css_hsl,
        ccc.picker.css_name
    }
})

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.shortmess:append('c') -- don't give |ins-completion-menu| messages.
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
vim.g.coc_global_extensions = {
    'coc-java', 'coc-rust-analyzer', 'coc-html', 'coc-css', 'coc-vimlsp',
    'coc-tsserver', 'coc-snippets', 'coc-emmet', 'coc-json', 'coc-texlab'
}

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

-- auto complete
local opts = {silent = true, noremap = true, expr = true}
vim.api.nvim_set_keymap("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
vim.api.nvim_set_keymap("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
vim.api.nvim_set_keymap("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- scroll through documentation
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

-- go to definition and other things
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
keyset("n", "<c-k>", "<Plug>(coc-rename)", {silent = true})
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
keyset("n", "<space>a", "<Plug>(coc-codeaction-cursor)", opts)
keyset("x", "<space>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<space>g", "<Plug>(coc-codelens-action)", opts)
keyset("n", "<space>f", "<Plug>(coc-fix-current)", opts)
keyset("n", "<space>d", ":<C-u>CocList diagnostics<cr>", opts)
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
keyset("n", "<space>q", ":<C-u>CocList<cr>", opts)

vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- Vimtex config
vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
vim.g.tex_conceal = 'abdmg'
vim.g.indentLine_setConceal = 0

-- Other settings
-- vim.g.polyglot_disabled = { 'javascript', 'css', 'java', 'c', 'typescript', 'python', 'cpp', 'rs', 'bash', 'zsh', 'html', 'lua', 'ruby', 'ocaml', 'haskell', 'go', 'yaml', 'json' } -- "treesitter
vim.g.vimwiki_list = {{path = '~/Work/vimwiki'}}
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -28
vim.g.netrw_browsex_viewer = "open -a firefox"
vim.g.termdebug_popup = 0
vim.g.termdebug_wide = 163

-- wilder
local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('pipeline', {
    wilder.branch(wilder.python_file_finder_pipeline({
        file_command = function(_, arg)
            if string.find(arg, '.') ~= nil then
                return {'fd', '-tf', '-H'}
            else
                return {'fd', '-tf'}
            end
        end,
        dir_command = {'fd', '-td'},
        filters = {'fuzzy_filter', 'difflib_sorter'}
    }), wilder.cmdline_pipeline(), wilder.python_search_pipeline())
})

wilder.set_option('renderer', wilder.popupmenu_renderer({
    highlighter = wilder.basic_highlighter(),
    left = {' '},
    right = {' ', wilder.popupmenu_scrollbar({thumb_char = ' '})},
    highlights = {default = 'WilderMenu', accent = 'WilderAccent'}
}))

-- firenvim
vim.g.firenvim_config = {
    globalSettings = {alt = "all"},
    localSettings = {
        [".*"] = {
            cmdline = "neovim",
            content = "text",
            priority = 0,
            selector = "textarea",
            takeover = "never"
        }
    }
}

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

    -- vim.api.nvim_create_autocmd("TextChanged", {
    --     command = "++nested call g:Delay_My_Write"
    -- })
    --
    -- vim.api.nvim_create_autocmd("TextChangedI", {
    --     command = "++nested call g:Delay_My_Write"
    -- })

    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "github.com_*.txt",
        command = "set filename=markdown"
    })
else
    vim.opt.laststatus = 3
end

-- autocmds
vim.api.nvim_create_augroup("Random", {})
vim.api.nvim_create_autocmd('VimResized', {
    group = "Random",
    desc = 'Keep windows equally resized',
    command = 'tabdo wincmd ='
})
-- vim.api.nvim_create_autocmd("")
vim.api.nvim_create_autocmd("TermOpen", {
    group = "Random",
    command = "setlocal nonumber norelativenumber signcolumn=no"
})
vim.api.nvim_create_autocmd("InsertEnter",
                            {group = "Random", command = "set timeoutlen=100"})
vim.api.nvim_create_autocmd("InsertLeave",
                            {group = "Random", command = "set timeoutlen=1000"})

-- toggleterm
require("toggleterm").setup {
    shade_terminals = false,
    highlights = {
        StatusLine = {guifg = "#ffffff", guibg = "#0E1018"},
        StatusLineNC = {guifg = "#ffffff", guibg = "#0E1018"}
    }
}

local Terminal = require('toggleterm.terminal').Terminal

local lg_cmd = "lazygit -w (pwd)"
if vim.v.servername ~= nil then
    lg_cmd = string.format(
                 "NVIM_SERVER=%s lazygit -ucf ~/.config/nvim/lazygit.toml -w (pwd)",
                 vim.v.servername)
end

vim.cmd(
    [[let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"]])

local lazygit = Terminal:new({
    cmd = lg_cmd,
    count = 5,
    -- dir = "git_dir",
    direction = "float",
    float_opts = {
        border = "double",
        width = function() return vim.o.columns end,
        height = function() return vim.o.lines end
    },

    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>",
                                    {noremap = true, silent = true})
    end
})

function Edit(fn, line_number)
    local edit_cmd = string.format(":e %s", fn)
    if line_number ~= nil then
        edit_cmd = string.format(":e +%d %s", line_number, fn)
    end
    vim.cmd(edit_cmd)
end

function Lazygit_toggle() lazygit:toggle() end

keyset("n", "<leader>lg", "<cmd>lua Lazygit_toggle()<CR>", {silent = true})

-- filteype
require('filetype').setup({
    overrides = {
        extensions = {emojic = "markdown", s = "asm", wiki = "vimwiki"},
        literal = {known_hosts = "sshknownhosts"},
        complex = {
            [".gitignore"] = "gitignore",
            ["tmux.conf"] = "tmux",
            ["neomutt*"] = "mail"
        }
    }
})

require('nvim-autopairs').setup({
    disable_filetype = {"TelescopePrompt"},
    map_cr = false,
    disable_in_macro = false,
    disable_in_visualblock = false
})

require('Comment').setup {
    pre_hook = function()
        return
            require('ts_context_commentstring.internal').calculate_commentstring()
    end
}

-- https://github-wiki-see.page/m/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local Job = require('plenary.job')
local _bad = {'.*%.csv', '.*%.lua'} -- Put all filetypes that slow you down in this array
local bad_files = function(filepath)
    for _, v in ipairs(_bad) do if filepath:match(v) then return false end end

    return true
end

local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}
    if opts.use_ft_detect == nil then opts.use_ft_detect = true end
    opts.use_ft_detect = opts.use_ft_detect == false and false or
                             bad_files(filepath)
    filepath = vim.fn.expand(filepath)
    Job:new({
        command = 'file',
        args = {'--mime-type', '-b', filepath},
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], '/')[1]
            if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
                -- maybe we want to write something to the buffer here
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {'BINARY'})
                end)
            end
        end
    }):sync()
end

require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        buffer_previewer_maker = new_maker,
        layout_config = {prompt_position = "bottom"},
        mappings = {
            i = {
                ["<Esc>"] = actions.close,
                ["<C-q>"] = actions.send_to_qflist,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next
            }
        }
    },
    pickers = {
        find_files = {theme = "ivy", layout_config = {height = 0.4}},
        git_files = {theme = "ivy", layout_config = {height = 0.4}},
        buffers = {theme = "ivy", layout_config = {height = 0.4}},
        man_pages = {
            sections = {"ALL"},
            theme = "ivy",
            layout_config = {height = 0.4}
        },
        keymaps = {theme = "ivy", layout_config = {height = 0.4}},
        file_browser = {theme = "ivy", layout_config = {height = 0.4}},
        treesitter = {theme = "ivy", layout_config = {height = 0.4}},
        help_tags = {theme = "ivy", layout_config = {height = 0.5}}
    }
})

require("indent_blankline").setup {
    char = '¦',
    filetype_exclude = {
        "help", "terminal", "dashboard", "packer", "lspinfo", "TelescopePrompt",
        "TelescopeResults", "qf", "tex"
    },
    buftype_exclude = {"terminal", 'nofile', 'quickfix'},
    show_current_context = false,
    show_current_context_start = false
}

require('gitsigns').setup({
    signcolumn = false,
    status_formatter = function(status)
        local added, changed, removed = status.added, status.changed,
                                        status.removed
        local status_txt = {}
        table.insert(status_txt, "[")
        if added and added > 0 then
            table.insert(status_txt, '+' .. added)
        end
        if changed and changed > 0 then
            table.insert(status_txt, '~' .. changed)
        end
        if removed and removed > 0 then
            table.insert(status_txt, '-' .. removed)
        end
        table.insert(status_txt, "]")
        return table.concat(status_txt, "")
    end
})

local parsers = require("nvim-treesitter.parsers")
local enabled_list = {"clojure", "fennel", "commonlisp", "query"}
require('nvim-treesitter.configs').setup {
    -- ensure_installed = "maintained",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = {"latex"},
        custom_captures = {["@function.macro"] = "GruvboxPurple"}
    },
    playground = {
        enable = true,
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    },
    indent = {enable = true, disable = {'python'}},
    context_commentstring = {enable = true, config = {lua = '-- %s'}},
    textobjects = {
        move = {
            enable = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer"
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer"
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer"
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer"
            }
        },
        swap = {
            enable = true,
            swap_next = {["<leader>a"] = "@parameter.inner"},
            swap_previous = {["<leader>A"] = "@parameter.inner"}
        },
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        }
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<space>i',
            scope_incremental = '<space>i',
            node_incremental = '<space>n',
            node_decremental = '<space>p'
        }
    },
    rainbow = {
        enable = true,
        -- Enable only for lisp like languages
        disable = vim.tbl_filter(function(p)
            local disable = true
            for _, lang in pairs(enabled_list) do
                if p == lang then disable = false end
            end
            return disable
        end, parsers.available_parsers())
    },
    autotag = {enable = true}
}
