local keyset = vim.keymap.set
vim.g.copilot_no_tab_map  = true
keyset("i", "<c-k>", [[copilot#Accept("\<c-k>")]], {expr = true, silent = true, script = true})

