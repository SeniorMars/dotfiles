local keyset = vim.keymap.set
vim.g.copilot_no_tab_map  = true
keyset("i", "<c-v>", [[copilot#Accept("\<c-v>")]], {expr = true, silent = true, script = true})
