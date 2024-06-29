local api = vim.api
local home = vim.env.HOME
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end

vim.opt.rtp:prepend(lazypath)

if not vim.fn.executable("nvr") then
    vim.api.nvim_command("!pip3 install --user neovim-remote")
end

local result = vim.fn.system("pip3 show pynvim 2> /dev/null")
if result == "" then vim.api.nvim_command("!pip3 install --user pynvim") end

vim.g.mapleader = ","

require("lazy").setup({
    {
        "zbirenbaum/copilot.lua", -- Copilot but lua
        cmd = "Copilot",
        event = "InsertEnter"
    }, {
        "robitx/gp.nvim",
        lazy = true,
        cmd = "GpNew",
        config = function()
            local key = os.getenv("GPG_KEY")
            require("gp").setup({
                openai_api_key = {
                    "gpg", "--decrypt", "-r", key, home .. "/personal/lol.gpg"
                }
            })
        end
    }, {
        "nvim-telescope/telescope.nvim",
        dependencies = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"}
    }, {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require("telescope").load_extension "frecency"
        end
    }, {
        "goolord/alpha-nvim", -- Dashboard
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            local button = dashboard.button
            dashboard.section.header.val = {
                [[                                                                       ]],
                [[  ██████   █████                   █████   █████  ███                  ]],
                [[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
                [[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
                [[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
                [[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
                [[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
                [[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
                [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
                [[                                                                       ]],
                [[                     λ it be like that sometimes λ                     ]]
            }

            dashboard.section.buttons.val = {
                button("f", "  Find file",
                       ":Telescope find_files hidden=true no_ignore=true<CR>"),
                button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                button("c", "  Configuration",
                       ":e ~/.config/nvim/init.lua <CR>"),
                button("u", "  Update plugins", ":Lazy sync<CR>"),
                button("r", "  Recently opened files",
                       ":Telescope oldfiles<CR>"),
                button("l", "  Open last session", ":RestoreSession<CR>"),
                button("q", "  Quit", ":qa<CR>")
            }

            local handle, err = io.popen("fortune -s")
            if err or handle == nil then
                dashboard.section.footer.val = "May the truth be found."
                alpha.setup(dashboard.opts)
                return
            end
            local fortune = handle:read("*a")
            handle:close()
            dashboard.section.footer.val = fortune
            alpha.setup(dashboard.opts)
        end
    }, {"neoclide/coc.nvim", branch = "release", build = ":CocUpdate"}, -- auto complete
    {"honza/vim-snippets"}, -- Snippets are separated from the engine
    {
        "ellisonleao/gruvbox.nvim", -- theme
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
                palette_overrides = {dark0_hard = "#0E1018"},
                overrides = {
                    NormalFloat = {fg = "#ebdbb2", bg = "#504945"},
                    Comment = {fg = "#81878f", italic = true, bold = true},
                    Define = {link = "GruvboxPurple"},
                    Macro = {link = "GruvboxPurple"},
                    ["@constant.builtin"] = {link = "GruvboxPurple"},
                    ["@storageclass.lifetime"] = {link = "GruvboxAqua"},
                    ["@text.note"] = {link = "TODO"},
                    ["@namespace.rust"] = {link = "Include"},
                    ["@punctuation.bracket"] = {link = "GruvboxOrange"},
                    texMathDelimZoneLI = {link = "GruvboxOrange"},
                    texMathDelimZoneLD = {link = "GruvboxOrange"},
                    luaParenError = {link = "luaParen"},
                    luaError = {link = "NONE"},
                    ContextVt = {fg = "#878788"},
                    CopilotSuggestion = {fg = "#878787"},
                    CocCodeLens = {fg = "#878787"},
                    CocWarningFloat = {fg = "#dfaf87"},
                    CocInlayHint = {fg = "#ABB0B6"},
                    CocPumShortcut = {fg = "#fe8019"},
                    CocPumDetail = {fg = "#fe8019"},
                    DiagnosticVirtualTextWarn = {fg = "#dfaf87"},
                    -- fold
                    Folded = {fg = "#fe8019", bg = "#3c3836", italic = true},
                    FoldColumn = {fg = "#fe8019", bg = "#0E1018"},
                    SignColumn = {bg = "#fe8019"},
                    -- new git colors
                    DiffAdd = {
                        bold = true,
                        reverse = false,
                        fg = "",
                        bg = "#2a4333"
                    },
                    DiffChange = {
                        bold = true,
                        reverse = false,
                        fg = "",
                        bg = "#333841"
                    },
                    DiffDelete = {
                        bold = true,
                        reverse = false,
                        fg = "#442d30",
                        bg = "#442d30"
                    },
                    DiffText = {
                        bold = true,
                        reverse = false,
                        fg = "",
                        bg = "#213352"
                    },
                    -- statusline
                    StatusLine = {bg = "#ffffff", fg = "#0E1018"},
                    StatusLineNC = {bg = "#3c3836", fg = "#0E1018"},
                    CursorLineNr = {fg = "#fabd2f", bg = ""},
                    GruvboxOrangeSign = {fg = "#dfaf87", bg = ""},
                    GruvboxAquaSign = {fg = "#8EC07C", bg = ""},
                    GruvboxGreenSign = {fg = "#b8bb26", bg = ""},
                    GruvboxRedSign = {fg = "#fb4934", bg = ""},
                    GruvboxBlueSign = {fg = "#83a598", bg = ""},
                    WilderMenu = {fg = "#ebdbb2", bg = ""},
                    WilderAccent = {fg = "#f4468f", bg = ""},
                    -- coc semantic token
                    CocSemStruct = {link = "GruvboxYellow"},
                    CocSemKeyword = {fg = "", bg = "#0E1018"},
                    CocSemEnumMember = {fg = "", bg = "#0E1018"},
                    CocSemTypeParameter = {fg = "", bg = "#0E1018"},
                    CocSemComment = {fg = "", bg = "#0E1018"},
                    CocSemMacro = {fg = "", bg = "#0E1018"},
                    CocSemVariable = {fg = "", bg = "#0E1018"},
                    CocSemFunction = {fg = "", bg = "#0E1018"},
                    -- neorg
                    ["@neorg.markup.inline_macro"] = {link = "GruvboxGreen"}
                }
            })
            vim.cmd.colorscheme("gruvbox")
        end
    }, {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}, -- :TSInstallFromGrammar
    {"nvim-treesitter/nvim-treesitter-textobjects", event = "InsertEnter"}, -- TS objects
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            require('ts_context_commentstring').setup {enable_autocmd = false}
        end
    }, -- use TS for comment.nvim
    {"nvim-treesitter/playground", lazy = true, cmd = "TSPlaygroundToggle"}, -- playing around with treesitter
    {"danymat/neogen", config = function() require("neogen").setup({}) end}, {
        "haringsrob/nvim_context_vt",
        config = function()
            require("nvim_context_vt").setup({
                disable_ft = {"rust", "rs"},
                disable_virtual_lines = true,
                min_rows = 8
            })
        end
    }, {"kevinhwang91/nvim-bqf"}, -- beter quickfix
    {"sbdchd/neoformat"}, -- format code
    {"mbbill/undotree", lazy = true, cmd = "UndotreeToggle"}, -- see undo tree
    {
        "smjonas/live-command.nvim", -- live command
        config = function()
            require("live-command").setup({commands = {Norm = {cmd = "norm"}}})
        end
    }, {
        "rmagatti/auto-session", -- auto save session
        config = function()
            require("auto-session").setup({
                log_level = "error",
                auto_session_suppress_dirs = {
                    "~/", "~/Downloads", "~/Documents"
                },
                auto_session_use_git_branch = true,
                auto_save_enabled = true
            })
        end
    }, {
        "nmac427/guess-indent.nvim", -- guess indent
        config = function() require("guess-indent").setup({}) end
    }, {"tpope/vim-repeat"}, -- repeat
    {
        "kylechui/nvim-surround", -- surround objects
        config = function() require("nvim-surround").setup({}) end
    }, {"mhinz/vim-grepper"}, -- rg support
    {"gelguy/wilder.nvim", build = ":UpdateRemotePlugins"}, -- : autocomplete
    {"tpope/vim-fugitive"}, -- Git control for vim
    {"windwp/nvim-autopairs", event = "InsertEnter"}, -- autopairs
    {
        'glacambre/firenvim',
        lazy = not vim.g.started_by_firenvim,
        build = function() vim.fn["firenvim#install"](0) end
    }, {
        'andymass/vim-matchup',
        config = function()
            api.nvim_set_hl(0, "OffScreenPopup",
                            {fg = "#fe8019", bg = "#3c3836", italic = true})
            vim.g.matchup_matchparen_offscreen = {
                method = "popup",
                highlight = "OffScreenPopup"
            }
        end
    }, {"uga-rosa/ccc.nvim"}, -- color highlighting
    {"wellle/targets.vim"}, -- adds more targets like [ or ,
    {"nvim-neorg/neorg", opts = {}}, {
        "HakonHarnes/img-clip.nvim",
        event = "BufEnter",
        keys = {
            {"<leader>i", "<cmd>PasteImage<cr>", desc = "Paste clipboard image"}
        }
    }, {"lervag/vimtex"}, -- for latex
    {"akinsho/toggleterm.nvim"}, -- for smart terminal
    {"puremourning/vimspector"} -- debugging
}, {
    performance = {
        rtp = {
            disabled_plugins = { -- disable some rtp plugins
                "gzip", "tarPlugin", "tutor", "zip Plugin", "matchit"
            }
        }
    }
})

-- global options
vim.opt.writebackup = false
vim.opt.conceallevel = 2
vim.opt.ignorecase = true -- search case
vim.opt.smartcase = true -- search matters if capital letter
vim.opt.inccommand = "split" -- "for incsearch while sub
vim.opt.lazyredraw = true -- redraw for macros
vim.opt.number = true -- line number on
vim.opt.relativenumber = true -- relative line number on
vim.opt.undofile = true -- undo even when it closes
vim.opt.foldmethod = "expr" -- treesiter time
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- treesiter
vim.opt.scrolloff = 8 -- number of lines to always go down
vim.opt.signcolumn = "number"
vim.opt.colorcolumn = "99999" -- fix columns
vim.opt.mouse = "a" -- set mouse to be on
vim.opt.shortmess = "ltToOcCF"
-- vim.opt.cmdheight = 0 -- status line smaller
vim.opt.laststatus = 3
vim.opt.breakindent = true -- break indentation for long lines
vim.opt.breakindentopt = {shift = 2}
vim.opt.showbreak = "↳" -- character for line break
vim.opt.splitbelow = true -- split windows below
vim.opt.splitright = true -- split windows right
vim.opt.wildmode = "list:longest,list:full" -- for : stuff
vim.opt.wildignore:append({".javac", "node_modules", "*.pyc"})
vim.opt.wildignore:append({".aux", ".out", ".toc"}) -- LaTeX
vim.opt.wildignore:append({
    ".o", ".obj", ".dll", ".exe", ".so", ".a", ".lib", ".pyc", ".pyo", ".pyd",
    ".swp", ".swo", ".class", ".DS_Store", ".git", ".hg", ".orig"
})
vim.opt.suffixesadd:append({".java", ".rs"}) -- search for suffexes using gf
vim.opt.diffopt:append("linematch:50")
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.showmode = false
vim.opt.virtualedit = "all"
vim.opt.shell = "/opt/homebrew/bin/fish"
api.nvim_create_user_command("FixWhitespace", [[%s/\s\+$//e]], {})

vim.filetype.add({extension = {typ = "typst"}, pattern = {["*.typ"] = "typst"}})

-- firenvim
api.nvim_create_autocmd({'UIEnter'}, {
    callback = function(_)
        local client = api.nvim_get_chan_info(vim.v.event.chan).client
        if client ~= nil and client.name == "Firenvim" then
            vim.o.laststatus = 0
        end
    end
})

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

-- global funcs
_G.MUtils = {}

-- status line cache
local cache = {}

local function refresh_cache(key)
    if cache[key] then cache[key].value = cache[key].fn() end
end

local function cache_get(key, compute_fn)
    local cached = cache[key]
    if cached then return cached.value end
    local value = compute_fn()
    cache[key] = {value = value, fn = compute_fn}
    return value
end

MUtils.spell_toggle = function()
    if vim.opt.spell:get() then
        vim.opt_local.spell = false
        vim.opt_local.spelllang = "en"
    else
        vim.opt_local.spell = true
        vim.opt_local.spelllang = {"en_us"}
    end
end
local function spell_status()
    local spellLang = vim.opt_local.spelllang:get()
    if type(spellLang) == "table" then
        spellLang = table.concat(spellLang, ", ")
    end
    return string.upper(spellLang)
end

local function git_branch()
    return cache_get("git_branch", function()
        if vim.g.loaded_fugitive then
            local branch = vim.fn.FugitiveHead()
            if branch ~= "" then
                if api.nvim_win_get_width(0) <= 80 then
                    return " " .. string.upper(branch:sub(1, 2))
                end
                return " " .. string.upper(branch)
            end
        end
        return ""
    end)
end

local function update_status_for_file(file_path)
    -- Get number of lines added and deleted using git diff --numstat
    local diff_stats = vim.fn.system("git diff --numstat " ..
                                         vim.fn.shellescape(file_path))
    if vim.v.shell_error ~= 0 or diff_stats == "" then return "" end

    local added, deleted = diff_stats:match("(%d+)%s+(%d+)%s+%S+")
    added, deleted = tonumber(added), tonumber(deleted)
    ---@diagnostic disable-next-line: param-type-mismatch
    local delta = math.min(added, deleted)

    local status = {
        changed = delta,
        added = added - delta,
        removed = deleted - delta
    }

    -- Format the status for display
    local status_txt = {}
    if status.added > 0 then table.insert(status_txt, "+" .. status.added) end
    if status.changed > 0 then
        table.insert(status_txt, "~" .. status.changed)
    end
    if status.removed > 0 then
        table.insert(status_txt, "-" .. status.removed)
    end

    if #status_txt > 1 then
        for i = 2, #status_txt do status_txt[i] = "," .. status_txt[i] end
    end

    local formatted_status = ""
    if #status_txt > 0 then
        formatted_status = string.format("[%s]", table.concat(status_txt))
    else
        formatted_status = ""
    end

    return formatted_status
end

local function status_for_file()
    return cache_get("file_status", function()
        local file_path = api.nvim_buf_get_name(0)

        if file_path == "" then return "" end
        return update_status_for_file(file_path)
    end)
end

local function human_file_size()
    return cache_get("file_size", function()
        local file = api.nvim_buf_get_name(0)
        if file == "" then return "" end

        local size = vim.fn.getfsize(file)
        local suffixes = {"B", "KB", "MB", "GB"}
        local i = 1
        while size > 1024 do
            size = size / 1024
            i = i + 1
        end

        return size <= 0 and "" or string.format("[%.0f%s]", size, suffixes[i])
    end)
end

local function smart_file_path()
    return cache_get("file_path", function()
        local buf_name = api.nvim_buf_get_name(0)
        local is_wide = api.nvim_win_get_width(0) > 80
        if buf_name == "" then return "[No Name]" end

        local file_dir = buf_name:sub(1, 5):find("term") and vim.env.PWD or
                             vim.fs.dirname(buf_name)
        file_dir = file_dir:gsub(home, "~", 1)

        if not is_wide then file_dir = vim.fn.pathshorten(file_dir) end

        if buf_name:sub(1, 5):find("term") then
            return file_dir .. " "
        else
            return string.format("%s/%s ", file_dir, vim.fs.basename(buf_name))
        end
    end)
end

local function word_count()
    local words = vim.fn.wordcount()
    if words.visual_words ~= nil then
        return string.format("[%s]", words.visual_words)
    else
        return string.format("[%s]", words.words)
    end
end

local modes = setmetatable({
    ["n"] = {"NORMAL", "N"},
    ["no"] = {"N·OPERATOR", "N·P"},
    ["v"] = {"VISUAL", "V"},
    ["V"] = {"V·LINE", "V·L"},
    [""] = {"V·BLOCK", "V·B"},
    [""] = {"V·BLOCK", "V·B"},
    ["s"] = {"SELECT", "S"},
    ["S"] = {"S·LINE", "S·L"},
    [""] = {"S·BLOCK", "S·B"},
    ["i"] = {"INSERT", "I"},
    ["ic"] = {"INSERT", "I"},
    ["R"] = {"REPLACE", "R"},
    ["Rv"] = {"V·REPLACE", "V·R"},
    ["c"] = {"COMMAND", "C"},
    ["cv"] = {"VIM·EX", "V·E"},
    ["ce"] = {"EX", "E"},
    ["r"] = {"PROMPT", "P"},
    ["rm"] = {"MORE", "M"},
    ["r?"] = {"CONFIRM", "C"},
    ["!"] = {"SHELL", "S"},
    ["t"] = {"TERMINAL", "T"}
}, {
    __index = function()
        return {"UNKNOWN", "U"} -- handle edge cases
    end
})

local function get_current_mode()
    local mode = modes[api.nvim_get_mode().mode]
    if api.nvim_win_get_width(0) <= 80 then
        return string.format("%s ", mode[2]) -- short name
    else
        return string.format("%s ", mode[1]) -- long name
    end
end

local function file_type()
    return cache_get("file_type", function()
        local buf_name = api.nvim_buf_get_name(0)
        local width = api.nvim_win_get_width(0)

        local ft = vim.bo.filetype
        if ft == "" then
            return "[None]"
        else
            if width > 80 then
                return string.format("[%s]", ft)
            else
                local ext = vim.fn.fnamemodify(buf_name, ":e")
                local shorter = (string.len(ft) < string.len(ext)) and ft or ext
                return string.format("[%s]", shorter)
            end
        end
    end)
end

function StatusLine()
    return table.concat({
        get_current_mode(), -- get current mode
        spell_status(), -- display language and if spell is on
        git_branch(), -- branch name
        " %<", -- spacing
        smart_file_path(), -- smart full path filename
        "%h%m%r%w", -- help flag, modified, readonly, and preview
        "%=", -- right align
        status_for_file(), -- git status for file
        word_count(), -- word count
        "[%-3.(%l|%c]", -- line number, column number
        human_file_size(), -- file size
        file_type() -- file type
    })
end

api.nvim_create_augroup("StatusLineCache", {})
api.nvim_create_autocmd({"BufEnter"}, {
    pattern = "*",
    group = "StatusLineCache",
    callback = function()
        refresh_cache("git_branch")
        refresh_cache("file_status")
        refresh_cache("file_size")
        refresh_cache("file_path")
        refresh_cache("file_type")
    end
})

api.nvim_create_autocmd({"BufWritePost"}, {
    pattern = "*",
    group = "StatusLineCache",
    callback = function()
        refresh_cache("file_status")
        refresh_cache("file_size")
        refresh_cache("file_path")
    end
})

api.nvim_create_autocmd({"WinResized"}, {
    pattern = "*",
    group = "StatusLineCache",
    callback = function()
        refresh_cache("git_branch")
        refresh_cache("file_path")
        refresh_cache("file_type")
    end
})

vim.opt.statusline = "%!luaeval('StatusLine()')"

-- Key remapping
local keyset = vim.keymap.set
keyset("i", "jk", "<esc>")

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
keyset("n", "<leader>x", "ZZ")
keyset("n", "<space><space>", ":ToggleTerm size=15<cr>", {silent = true})
keyset("n", "<space>t", ":ToggleTerm size=70 direction=vertical<cr>",
       {silent = true})
keyset("n", "<leader>t", ":lua require('neogen').generate()<CR>",
       {silent = true})
keyset("n", "<leader>u", ":UndotreeToggle<cr>")
keyset("n", "<leader>ww", ":Neorg workspace notes<cr>")
keyset("n", "<leader>wd", ":Neorg journal today<cr>")
keyset("n", "<leader>lc",
       ":Neorg keybind all core.looking-glass.magnify-code-block<cr>")
keyset("n", "<leader>lm", ":Neorg inject-metadata<cr>")
keyset("n", "<leader>e", ":Neoformat<cr>")
keyset("n", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>")
keyset("n", "<leader>cc", ":bdelete<cr>")
keyset("n", "<leader>cn", ":cnext<cr>")
keyset("n", "<leader>cp", ":cprevious<cr>")
keyset("n", "<leader>P", '"+gP')
keyset("n", "<leader>p", '"+gp')
keyset("n", "<leader>sf", ":source %<cr>")
keyset("n", "<leader>z", "[s1z=``")
keyset("n", "<leader>1", ":bp<cr>")
keyset("n", "<leader>2", ":bn<cr>")
keyset("n", "<leader>3", ":retab<cr>:FixWhitespace<cr>")
keyset("n", "<leader>4", ":Format<cr>")
keyset("n", "<leader>5", _G.MUtils.spell_toggle)
keyset("n", "<leader>sr", ":%s/<<C-r><C-w>>//g<Left><Left>")

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
keyset("n", "<leader>ff",
       ":Telescope frecency workspace=CWD theme=ivy layout_config={height=0.4} path_display={'shorten'}<cr>")
keyset("n", "<leader>fb", ":Telescope buffers<cr>")
keyset("n", "<leader>fm", ":Telescope man_pages<cr>")
keyset("n", "<leader>ft", ":Telescope treesitter<cr>")
keyset("n", "<leader>fk", ":Telescope keymaps<cr>")
keyset("n", "<leader>fh", ":Telescope help_tags<cr>")
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

if vim.fn.has("mac") then
    keyset("n", "<leader>0", ":silent !open -a Firefox %<cr>")
else
    keyset("n", "<leader>0", ":silent !xdg-open %<cr>")
end

--- autopairs
local npairs = require('nvim-autopairs')
npairs.setup({map_cr = false, check_ts = true})

local rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

npairs.add_rules({
    rule("$", "$", {"tex", "latex", "neorg"}):with_cr(cond.none())
})

npairs.get_rules("`")[1].not_filetypes = {"tex", "latex"}
npairs.get_rules("'")[1].not_filetypes = {"tex", "latex", "rust"}

-- coc settings
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.g.coc_node_path = "/Users/charlie/.asdf/shims/node"
vim.g.coc_enable_locationlist = 0
api.nvim_create_user_command("Format", "call CocAction('format')", {})

MUtils.check_back_space = function()
    local col = api.nvim_win_get_cursor(0)[2]
    local has_backspace =
        api.nvim_get_current_line():sub(col, col):match("%s") ~= nil
    return col == 0 or has_backspace
end

MUtils.diagnostic = function()
    vim.fn.CocActionAsync("diagnosticList", "", function(err, res)
        if err == vim.NIL then
            if vim.tbl_isempty(res) then return end
            local items = {}
            for _, d in ipairs(res) do
                local text = ""
                local type = d.severity
                local msg = d.message:match("([^\n]+)\n*")
                local code = d.code
                if code == vim.NIL or code == nil or code == "NIL" then
                    text = ("[%s] %s"):format(type, msg)
                else
                    text = ("[%s|%s] %s"):format(type, code, msg)
                end

                local item = {
                    filename = d.file,
                    lnum = d.lnum,
                    end_lnum = d.end_lnum,
                    col = d.col,
                    end_col = d.end_col,
                    text = text
                }
                table.insert(items, item)
            end
            vim.fn.setqflist({}, " ",
                             {title = "CocDiagnosticList", items = items})
            vim.cmd("bo cope")
        end
    end)
end

-- auto complete
local opts = {silent = true, noremap = true, expr = true}

MUtils.tab_complete = function()
    if vim.fn["coc#pum#visible"]() ~= 0 then
        return vim.fn["coc#pum#next"](1)
    else
        if MUtils.check_back_space() then
            local key = api.nvim_replace_termcodes("<tab>", true, true, true)
            api.nvim_feedkeys(key, "n", false)
        else
            return vim.fn["coc#refresh"]()
        end
    end
end

MUtils.back_tab_complete = function()
    if vim.fn["coc#pum#visible"]() ~= 0 then
        return vim.fn["coc#pum#prev"](1)
    else
        local key = api.nvim_replace_termcodes("<C-h>", true, true, true)
        api.nvim_feedkeys(key, "n", false)
    end
end

MUtils.enter = function()
    if vim.fn["coc#pum#visible"]() ~= 0 then
        return vim.fn["coc#_select_confirm"]()
    else
        local key = api.nvim_replace_termcodes("<C-g>u<CR>", true, true, true)
        api.nvim_feedkeys(key, "n", false)
        return vim.fn["coc#on_enter"]()
    end
end

MUtils.help = function()
    local cw = vim.fn.expand("<cword>")
    if vim.fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
        api.nvim_command("h " .. cw)
    elseif api.nvim_eval("coc#rpc#ready()") then
        vim.fn.CocActionAsync("doHover")
    else
        api.nvim_command(string.format("!%s %s", vim.o.keywordprg, cw))
    end
end

keyset("i", "<Tab>", _G.MUtils.tab_complete, opts)
keyset("i", "<S-Tab>", _G.MUtils.back_tab_complete, opts)
keyset("i", "<CR>", _G.MUtils.enter, opts)
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- scroll through documentation
opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"',
       opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"',
       opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"',
       opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"',
       opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"',
       opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"',
       opts)

-- go to definition and other things
keyset("n", "<c-k>", "<Plug>(coc-rename)", {silent = true})
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

-- code actions and coc stuff
opts = {silent = true, nowait = true}
keyset("n", "<space>a", "<Plug>(coc-codeaction-cursor)", opts)
keyset("n", "<space>s", "<Plug>(coc-codeaction-refactor)", opts)
keyset("n", "<space>x", "<Plug>(coc-codeaction-line)", opts)
keyset("n", "<space>g", "<Plug>(coc-codelens-action)", opts)
keyset("n", "<space>f", "<Plug>(coc-fix-current)", opts)
keyset({'n', 'x'}, "<space>z", "<Plug>(coc-codeaction-selected", opts)
keyset({'n', 'x'}, "<space>r", "<Plug>(coc-codeaction-refactor-selected", opts)
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
keyset("n", "<space>q", ":<C-u>CocList<cr>", opts)
keyset("n", "<space>d", _G.MUtils.diagnostic, opts)
keyset("n", "K", _G.MUtils.help, {silent = true})
-- Vimtex config
vim.g.vimtex_quickfix_mode = 2
vim.g.vimtex_compiler_latexmk_engines = {["_"] = "-lualatex -shell-escape"}
vim.g.vimtex_indent_on_ampersands = 0
vim.g.vimtex_view_method = 'sioyek'
vim.g.matchup_override_vimtex = 1

-- Other settings
vim.g.neoformat_try_formatprg = 1
vim.g.latexindent_opt = "-m" -- for neorg
vim.g.python3_host_prog = "~/.asdf/shims/python3"
vim.g.node_host_prog = "/Users/charlie/.local/share/npm/bin/neovim-node-host"
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -28
vim.g.netrw_browsex_viewer = "open -a firefox"
vim.g.termdebug_popup = 0
vim.g.termdebug_wide = 163
vim.g.vimspector_install_gadgets = {"debugpy", "vscode-cpptools", "CodeLLDB"}

-- ccc color picker
local ccc = require("ccc")
ccc.setup({
    highlighter = {auto_enable = true},
    pickers = {
        ccc.picker.hex, ccc.picker.css_rgb, ccc.picker.css_hsl,
        ccc.picker.css_name
    }
})

-- wilder
local wilder = require("wilder")
wilder.setup({modes = {":", "/", "?"}})
wilder.set_option("pipeline", {
    wilder.branch(wilder.python_file_finder_pipeline({
        file_command = function(_, arg)
            if string.find(arg, ".") ~= nil then
                return {"fd", "-tf", "-H"}
            else
                return {"fd", "-tf"}
            end
        end,
        dir_command = {"fd", "-td"},
        filters = {"fuzzy_filter", "difflib_sorter"}
    }), wilder.cmdline_pipeline(), wilder.python_search_pipeline())
})

wilder.set_option("renderer", wilder.popupmenu_renderer({
    highlighter = wilder.basic_highlighter(),
    left = {" "},
    right = {" ", wilder.popupmenu_scrollbar({thumb_char = " "})},
    highlights = {default = "WilderMenu", accent = "WilderAccent"}
}))

-- autocmds
local autocmd = api.nvim_create_autocmd
api.nvim_create_augroup("Random", {clear = true})

autocmd("User", {
    group = "Random",
    pattern = "AlphaReady",
    callback = function()
        vim.opt.cmdheight = 0
        vim.opt.laststatus = 0
        vim.wo.fillchars = "eob: "

        autocmd("BufUnload", {
            pattern = "<buffer>",
            callback = function()
                vim.opt.cmdheight = 1
                vim.opt.laststatus = 3
                vim.wo.fillchars = "eob:~"
            end
        })
    end,
    desc = "Disable Bufferline in Alpha"
})

autocmd("VimResized", {
    group = "Random",
    desc = "Keep windows equally resized",
    command = "tabdo wincmd ="
})

autocmd("TermOpen", {
    group = "Random",
    command = "setlocal nonumber norelativenumber signcolumn=no"
})

autocmd("InsertEnter", {group = "Random", command = "set timeoutlen=100"})
autocmd("InsertLeave", {group = "Random", command = "set timeoutlen=1000"})

--- coc auto commands
api.nvim_create_augroup("CocGroup", {})

autocmd("User", {
    group = "CocGroup",
    pattern = "CocLocationsChange",
    desc = "Update location list on locations change",
    callback = function()
        local locs = vim.g.coc_jump_locations
        vim.fn.setloclist(0, {}, " ", {title = "CocLocationList", items = locs})
        local winid = vim.fn.getloclist(0, {winid = 0}).winid
        if winid == 0 then
            vim.cmd("bel lw")
        else
            api.nvim_set_current_win(winid)
        end
    end
})

autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- toggleterm
require("toggleterm").setup({
    shade_terminals = false,
    -- shell = "/opt/homebrew/bin/fish",
    highlights = {
        StatusLine = {guifg = "#ffffff", guibg = "#0E1018"},
        StatusLineNC = {guifg = "#ffffff", guibg = "#0E1018"}
    }
})

-- copilot
require("copilot").setup({
    panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<leader>ck"
        },
        layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
        }
    },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
            accept = "<C-v>",
            accept_word = false,
            accept_line = "<C-q>",
            next = false,
            prev = false,
            dismiss = "<C-]>"
        }
    },
    filetypes = {
        markdown = true,
        gitcommit = false,
        yaml = false,
        help = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        VimspectorPrompt = false,
        ["."] = false
    },
    copilot_node_command = "node",
    server_opts_overrides = {}
})

keyset("n", "<leader>ck",
       ':lua require("copilot.suggestion").toggle_auto_trigger()<cr>')

local Terminal = require("toggleterm.terminal").Terminal

local lg_cmd = "lazygit -w $PWD"
if vim.v.servername ~= nil then
    lg_cmd = string.format(
                 "NVIM_SERVER=%s lazygit -ucf ~/.config/nvim/lazygit.toml -w $PWD",
                 vim.v.servername)
end

vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"

local lazygit = Terminal:new({
    cmd = lg_cmd,
    count = 5,
    direction = "float",
    float_opts = {
        border = "double",
        width = function() return vim.o.columns end,
        height = function() return vim.o.lines end
    },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
        api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>",
                                {noremap = true, silent = true})
    end
})

MUtils.edit = function(fn, line_number)
    local edit_cmd = string.format(":e %s", fn)
    if line_number ~= nil then
        edit_cmd = string.format(":e +%d %s", line_number, fn)
    end
    vim.cmd(edit_cmd)
end

MUtils.lazygit = function() lazygit:toggle() end

keyset("n", "<leader>lg", _G.MUtils.lazygit, {silent = true})

-- https://github-wiki-see.page/m/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local _bad = {".*%.csv"} -- Put all filetypes that slow you down in this array
local bad_files = function(filepath)
    for _, v in ipairs(_bad) do if filepath:match(v) then return false end end
    return true
end

---@diagnostic disable-next-line: redefined-local
local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}
    if opts.use_ft_detect == nil then opts.use_ft_detect = true end
    opts.use_ft_detect = opts.use_ft_detect == false and false or
                             bad_files(filepath)
    filepath = vim.fn.expand(filepath)

    Job:new({
        command = "file",
        args = {"--mime-type", "-b", filepath},
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], "/")[1]
            if mime_type == "text" then
                vim.loop.fs_stat(filepath, function(_, stat)
                    if not stat then return end
                    if stat.size > 100000 then
                        vim.schedule(function()
                            api.nvim_buf_set_lines(bufnr, 0, -1, false,
                                                   {"FILE TOO LARGE"})
                        end)
                    else
                        previewers.buffer_previewer_maker(filepath, bufnr, opts)
                    end
                end)
            else
                -- maybe we want to write something to the buffer here
                vim.schedule(function()
                    api.nvim_buf_set_lines(bufnr, 0, -1, false, {"BINARY"})
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
                ["<C-j>"] = actions.move_selection_next,
                ["<C-d>"] = actions.delete_buffer + actions.move_to_top
            }
        }
    },
    pickers = {
        find_files = {theme = "ivy", layout_config = {height = 0.4}},
        git_files = {theme = "ivy", layout_config = {height = 0.4}},
        live_grep = {theme = "ivy", layout_config = {height = 0.4}},
        buffers = {theme = "ivy", layout_config = {height = 0.4}},
        keymaps = {theme = "ivy", layout_config = {height = 0.4}},
        file_browser = {theme = "ivy", layout_config = {height = 0.4}},
        treesitter = {theme = "ivy", layout_config = {height = 0.4}},
        help_tags = {theme = "ivy", layout_config = {height = 0.5}},
        man_pages = {
            sections = {"1", "2", "3"},
            theme = "ivy",
            layout_config = {height = 0.4}
        }
    },
    extensions = {
        frecency = {
            auto_validate = false,
            matcher = "fuzzy",
            path_display = {"shorten"}
        }
    }
})

-- Neovim now has built-in comments. let's use it with treesitter
vim.g.skip_ts_context_commentstring_module = true
local get_option = vim.filetype.get_option
---@diagnostic disable-next-line: duplicate-set-field
vim.filetype.get_option = function(filetype, option)
    return option == "commentstring" and
               require("ts_context_commentstring.internal").calculate_commentstring() or
               get_option(filetype, option)
end

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
keyset({"n", "x", "o"}, ";", ts_repeat_move.repeat_last_move_next)
keyset({"n", "x", "o"}, ",", ts_repeat_move.repeat_last_move_previous)
keyset({"n", "x", "o"}, "f", ts_repeat_move.builtin_f)
keyset({"n", "x", "o"}, "F", ts_repeat_move.builtin_F)
keyset({"n", "x", "o"}, "t", ts_repeat_move.builtin_t)
keyset({"n", "x", "o"}, "T", ts_repeat_move.builtin_T)

require("nvim-treesitter.configs").setup({
    highlight = {enable = true, disable = {"latex"}},
    playground = {
        enable = true,
        updatetime = 25 -- Debounced time for highlighting nodes in the playground from source code
    },
    indent = {enable = true, disable = {"python"}},
    textobjects = {
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = {query = "@class.outer", desc = "Next class start"},
                ["]s"] = {
                    query = "@scope",
                    query_group = "locals",
                    desc = "Next scope"
                }
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer"
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer"
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer"
            },
            goto_next = {["]d"] = "@conditional.outer"},
            goto_previous = {["[d"] = "@conditional.outer"}
        },
        swap = {
            enable = true,
            swap_next = {["<leader>a"] = "@parameter.inner"},
            swap_previous = {["<leader>A"] = "@parameter.inner"}
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            },
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V", -- linewise
                ["@class.outer"] = "<c-v>" -- blockwise
            }
        }
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<space>i",
            scope_incremental = "<space>i",
            node_incremental = "<space>n",
            node_decremental = "<space>p"
        }
    }
})

require("neorg").setup({
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.qol.toc"] = {},
        ["core.concealer"] = {config = {icon_preset = "diamond"}},
        ["core.keybinds"] = {
            config = {
                hook = function(keybinds)
                    keybinds.remap_key("norg", "n", "<CR>", "<leader>ll")
                end
            }
        },
        ["core.export"] = {config = {export_dir = "~/Notes/export"}},
        ["core.esupports.metagen"] = {},
        ["core.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {notes = "~/Notes/notes", journal = "~/Notes"},
                index = "index.norg"
            }
        },
        ["core.journal"] = {
            config = {
                journal_folder = "~/Notes/journal",
                strategy = "flat",
                workspace = "journal"
            }
        }
    }
})
