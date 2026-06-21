vim.opt_local.spell = true
vim.opt_local.spelllang = 'en_us'
vim.opt.formatoptions:append('w')
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.wrap = true
local map = vim.api.nvim_buf_set_keymap
local options = { noremap = true, silent = true}
map(0, 'n', '<leader>x', 'ZZ', options)

