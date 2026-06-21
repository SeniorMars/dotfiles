vim.opt_local.textwidth=79
vim.opt_local.fileformat='unix'
vim.cmd([[autocmd BufWritePre <buffer> :FixWhitespace]])
local options = {buffer = true, noremap = true}

vim.keymap.set("n", "<leader>8", function()
    vim.cmd.write()
    vim.cmd("terminal ipython " .. vim.fn.shellescape(vim.fn.expand("%:p")))
end, options)

vim.keymap.set("n", "<leader>9", function()
    vim.cmd.write()
    vim.cmd("!python3 " .. vim.fn.shellescape(vim.fn.expand("%:p")))
end, options)
