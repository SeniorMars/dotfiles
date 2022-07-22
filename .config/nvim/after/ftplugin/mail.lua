vim.opt_local.spell = true
vim.opt_local.spelllang = 'en_us'
local map = vim.api.nvim_buf_set_keymap
local options = { noremap = true, silent = true}
map(0, 'n', '<leader>x', 'ZZ', options)
-- vim.cmd([[autocmd VimEnter <buffer> :TZAtaraxis]])
-- vim.cmd([[autocmd VimEnter <buffer> :Twilight]])
