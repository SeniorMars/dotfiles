local map = vim.api.nvim_buf_set_keymap
local options = { noremap = true, silent = true}
map(0, 'n', '<leader>9', ':CocCommand clangd.switchSourceHeader<cr>', options)
