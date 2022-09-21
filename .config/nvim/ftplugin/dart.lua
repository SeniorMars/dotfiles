local map = vim.api.nvim_buf_set_keymap
local options= { noremap = true}
map(0, 'n', '<leader>9', '<Esc>:w<cr>:!dart %<cr>', options)
