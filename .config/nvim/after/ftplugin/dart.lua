local options = {buffer = true, noremap = true}

vim.keymap.set("n", "<leader>9", function()
    vim.cmd.write()
    vim.cmd("!dart " .. vim.fn.shellescape(vim.fn.expand("%:p")))
end, options)
