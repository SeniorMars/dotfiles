local keyset = vim.keymap.set

if vim.opt.diff:get() then
    local opts = {noremap = true, silent = true}
    keyset("n", "<localleader>1", ":diffget LOCAL<CR>", opts)
    keyset("n", "<localleader>2", ":diffget BASE<CR>", opts)
    keyset("n", "<localleader>3", ":diffget REMOTE<CR>", opts)
end

vim.api.nvim_create_user_command("FixWhitespace", [[%s/\s\+$//e]], {})

keyset("i", "jk", "<esc>")

keyset("i", ",", ",<C-g>U")
keyset("i", ".", ".<C-g>U")
keyset("i", "!", "!<C-g>U")
keyset("i", "?", "?<C-g>U")
keyset("x", ".", ":norm.<cr>")
keyset("x", "<leader>y", '"*y :let @+=@*<cr>')
keyset("n", "<a-x>", "<nop>")
keyset("n", "<backspace>", "<C-^>")
keyset("n", "cp", "yap<S-}p")

keyset("n", "<leader>x", "ZZ")
keyset("n", "<space><space>", function()
    Snacks.terminal.toggle(nil, {win = {position = "bottom", height = 15}})
end, {desc = "Toggle terminal"})

keyset("n", "<space>t", function()
    Snacks.terminal.toggle(nil, {win = {position = "right", width = 70}})
end, {desc = "Toggle vertical terminal"})

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
keyset("n", "<leader>5", function() _G.MUtils.spell_toggle() end)
keyset("n", "<leader>sr", ":%s/<<C-r><C-w>>//g<Left><Left>")

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

keyset("n", "<leader>fs", ':GrepperRg "" .<Left><Left><Left>')
keyset("n", "<leader>fS", ":Rg<space>")
keyset("n", "<leader>*", ":Grepper -tool rg -cword -noprompt<cr>")
keyset("n", "gs", "<Plug>(GrepperOperator)")
keyset("x", "gs", "<Plug>(GrepperOperator)")

keyset("n", "<leader>gg", ":Git<cr>", {silent = true})
keyset("n", "<leader>ga", ":Git add %:p<cr><cr>", {silent = true})
keyset("n", "<leader>gd", ":Gdiff<cr>", {silent = true})
keyset("n", "<leader>ge", ":Gedit<cr>", {silent = true})
keyset("n", "<leader>gw", ":Gwrite<cr>", {silent = true})
keyset("n", "<leader>gf", ":Commits<cr>", {silent = true})
keyset("n", "<leader>0", ":silent !open -a Firefox %<cr>")
