vim.cmd([[let termdubgger="rust-gdb"]])
local map = vim.api.nvim_buf_set_keymap
local options = { silent = true}

map(0, 'n', '<leader>=', "<Esc>:w<cr>:term rustc <c-r>=expand('%')<cr> && ./<c-r>=expand('%:r')<cr><cr>", {noremap = true})
map(0, 'n', '<leader>9', ':<C-u>CocCommand rust-analyzer.run<CR>', {noremap = true})
map(0, 'n', '<leader>o6', '<Plug>VimspectorContinue', options)
map(0, 'n', '<leader>o7', '<Plug>VimspectorStepInto', options)
map(0, 'n', '<leader>o8', '<Plug>VimspectorStepOver', options)
map(0, 'n', '<leader>o9', '<Plug>VimspectorStepOut', options)
map(0, 'n', '<leader>o0', '<Plug>VimspectorStop', options)
map(0, 'n', '<leader>oo', '<Plug>VimspectorToggleBreakpoint', options)
map(0, 'n', '<leader><leader>o', '<Plug>VimspectorBalloonEval', {})
map(0, 'x', '<leader><leader>o', '<Plug>VimspectorBalloonEval', {})
