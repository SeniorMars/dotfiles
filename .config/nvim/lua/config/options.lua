vim.g.mapleader = ","
-- vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.writebackup = false
opt.conceallevel = 2
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"
opt.lazyredraw = true
opt.number = true
opt.relativenumber = true
opt.undofile = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""
opt.scrolloff = 8
opt.signcolumn = "number"
opt.colorcolumn = "99999"
opt.mouse = "a"
opt.shortmess:append("c")
opt.sessionoptions = {
    "blank", "buffers", "curdir", "folds", "help", "tabpages", "winsize",
    "winpos", "terminal", "localoptions"
}
opt.laststatus = 3
opt.breakindent = true
opt.breakindentopt = {shift = 2}
opt.showbreak = "↳"
opt.splitbelow = true
opt.splitright = true
opt.wildmode = "list:longest,list:full"

local wildignore = {
    ".javac", "node_modules", "*.pyc", ".aux", ".out", ".toc", ".o", ".obj",
    ".dll", ".exe", ".so", ".a", ".lib", ".pyo", ".pyd", ".swp", ".swo",
    ".class", ".DS_Store", ".git", ".hg", ".orig"
}

for _, pattern in ipairs(wildignore) do opt.wildignore:append(pattern) end

for _, suffix in ipairs({".java", ".rs"}) do opt.suffixesadd:append(suffix) end

opt.diffopt = {
    "filler", "internal", "closeoff", "algorithm:histogram", "context:5",
    "linematch:60"
}
opt.cursorline = true
opt.cursorlineopt = "number"
opt.showmode = false
opt.virtualedit = "all"
opt.shell = "/opt/homebrew/bin/fish"

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -28
vim.g.netrw_browsex_viewer = "open -a firefox"

vim.g.termdebug_popup = 0
vim.g.termdebug_wide = 163

if vim.g.neovide then
    vim.g.neovide_text_gamma = 0.0
    vim.g.neovide_text_contrast = 1
    vim.g.neovide_input_ime = true
    vim.g.neovide_input_macos_option_key_is_meta = "only_left"
end
