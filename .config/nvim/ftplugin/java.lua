vim.api.nvim_command('compiler java')
-- vim.cmd('compiler java')
local map = vim.api.nvim_buf_set_keymap
map(0, 'n', '<leader>o6', '<Plug>VimspectorContinue', {})
map(0, 'n', '<leader>o7', '<Plug>VimspectorStepInto', {})
map(0, 'n', '<leader>o8', '<Plug>VimspectorStepOver', {})
map(0, 'n', '<leader>o9', '<Plug>VimspectorStepOut', {})
map(0, 'n', '<leader>o0', '<Plug>VimspectorStop', {})
map(0, 'n', '<leader>oo', '<Plug>VimspectorToggleBreakpoint', {})

local options = { noremap = true}
map(0, 'n', '<leader>7', ':term java %<cr>', options)
map(0, 'n', '<leader>8', ':w<cr>:make<cr>:cwindow<cr>', options)
map(0, 'n', '<leader>9', ":!echo <C-r>=expand('%:r')<cr> <bar> xargs java<cr>", options)
