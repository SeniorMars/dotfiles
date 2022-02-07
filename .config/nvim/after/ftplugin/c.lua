local map = vim.api.nvim_buf_set_keymap
options = { noremap = true, silent = true}
map(0, 'n', '<leader>9', ':CocCommand clangd.switchSourceHeader<cr>', options)
