vim.g.termdebugger = "rust-gdb"
local map = vim.api.nvim_buf_set_keymap
local options = { silent = true}

vim.keymap.set("n", "<leader>=", function()
    local src = vim.fn.expand("%:p")
    local out = vim.fn.expand("%:p:r")

    vim.cmd.write()
    vim.cmd("terminal rustc " .. vim.fn.shellescape(src) .. " -o " ..
                vim.fn.shellescape(out) .. " && " .. vim.fn.shellescape(out))
end, {buffer = true, noremap = true})
map(0, 'n', '<leader>9', ':<C-u>CocCommand rust-analyzer.run<CR>', {noremap = true})
map(0, 'n', '<leader>dc', '<Plug>VimspectorContinue', options)
map(0, 'n', '<leader>di', '<Plug>VimspectorStepInto', options)
map(0, 'n', '<leader>do', '<Plug>VimspectorStepOver', options)
map(0, 'n', '<leader>da', '<Plug>VimspectorStepOut', options)
map(0, 'n', '<leader>ds', '<Plug>VimspectorStop', options)
map(0, 'n', '<leader>db', '<Plug>VimspectorToggleBreakpoint', options)
map(0, 'n', '<leader>de', '<Plug>VimspectorBalloonEval', {})
map(0, 'x', '<leader>de', '<Plug>VimspectorBalloonEval', {})
