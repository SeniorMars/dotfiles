vim.api.nvim_command('compiler java')
-- vim.cmd('compiler java')
local map = vim.api.nvim_buf_set_keymap
map(0, 'n', '<leader>o6', '<Plug>VimspectorContinue', {})
map(0, 'n', '<leader>o7', '<Plug>VimspectorStepInto', {})
map(0, 'n', '<leader>o8', '<Plug>VimspectorStepOver', {})
map(0, 'n', '<leader>o9', '<Plug>VimspectorStepOut', {})
map(0, 'n', '<leader>o0', '<Plug>VimspectorStop', {})
map(0, 'n', '<leader>oo', '<Plug>VimspectorToggleBreakpoint', {})

local options = {buffer = true, noremap = true}
local map_options = {noremap = true}
vim.keymap.set("n", "<leader>7", function()
    vim.cmd("terminal java " .. vim.fn.shellescape(vim.fn.expand("%:p")))
end, options)
map(0, 'n', '<leader>8', ':w<cr>:make<cr>:cwindow<cr>', map_options)
vim.keymap.set("n", "<leader>9", function()
    vim.cmd("!java " .. vim.fn.shellescape(vim.fn.expand("%:p:r")))
end, options)
