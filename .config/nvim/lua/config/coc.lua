local api = vim.api
local keyset = vim.keymap.set

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300

vim.g.coc_enable_locationlist = 0

api.nvim_create_user_command("Format", "call CocAction('format')", {})

MUtils.check_back_space = function()
    local col = api.nvim_win_get_cursor(0)[2]
    local has_backspace =
        api.nvim_get_current_line():sub(col, col):match("%s") ~= nil

    return col == 0 or has_backspace
end

local function coc_is_nil(value) return value == nil or value == vim.NIL end

local function coc_string(value)
    if coc_is_nil(value) then return "" end

    value = tostring(value)

    if value == "NIL" then return "" end

    return value
end

local function first_line(value)
    value = coc_string(value)
    return value:match("([^\n]+)") or value
end

local function diagnostic_label(diagnostic)
    local severity = coc_string(diagnostic.severity)
    local code = coc_string(diagnostic.code)

    if severity == "" then severity = "Diagnostic" end

    if code == "" then return ("[%s]"):format(severity) end

    return ("[%s|%s]"):format(severity, code)
end

local function diagnostic_text(diagnostic)
    local label = diagnostic_label(diagnostic)
    local message = first_line(diagnostic.message)

    return ("%s %s"):format(label, message)
end

MUtils.diagnostic = function()
    vim.fn.CocActionAsync("diagnosticList", "", function(err, diagnostics)
        if not coc_is_nil(err) then
            vim.schedule(function()
                vim.notify("Failed to fetch Coc diagnostics: " .. tostring(err),
                           vim.log.levels.ERROR)
            end)
            return
        end

        vim.schedule(function()
            if coc_is_nil(diagnostics) or vim.tbl_isempty(diagnostics) then
                vim.fn
                    .setqflist({}, "r", {title = "CocDiagnostics", items = {}})

                vim.notify("No Coc diagnostics", vim.log.levels.INFO)
                return
            end

            local items = {}

            for _, diagnostic in ipairs(diagnostics) do
                local filename = coc_string(diagnostic.file)

                if filename ~= "" then
                    table.insert(items, {
                        filename = filename,
                        lnum = diagnostic.lnum or 1,
                        col = diagnostic.col or 1,
                        end_lnum = diagnostic.end_lnum,
                        end_col = diagnostic.end_col,
                        text = diagnostic_text(diagnostic)
                    })
                end
            end

            vim.fn.setqflist({}, "r", {title = "CocDiagnostics", items = items})

            if #items > 0 then
                vim.cmd("botright copen")
            else
                vim.notify("No Coc diagnostics", vim.log.levels.INFO)
            end
        end)
    end)
end

MUtils.tab_complete = function()
    if vim.fn["coc#pum#visible"]() ~= 0 then return vim.fn["coc#pum#next"](1) end

    if MUtils.check_back_space() then
        local key = api.nvim_replace_termcodes("<Tab>", true, true, true)
        api.nvim_feedkeys(key, "n", false)
        return ""
    end

    return vim.fn["coc#refresh"]()
end

MUtils.back_tab_complete = function()
    if vim.fn["coc#pum#visible"]() ~= 0 then return vim.fn["coc#pum#prev"](1) end

    local key = api.nvim_replace_termcodes("<C-h>", true, true, true)
    api.nvim_feedkeys(key, "n", false)
    return ""
end

MUtils.enter = function()
    if vim.fn["coc#pum#visible"]() ~= 0 then
        return vim.fn["coc#_select_confirm"]()
    end

    local ok, npairs = pcall(require, "nvim-autopairs")

    if ok then
        local key = api.nvim_replace_termcodes("<C-g>u", true, true, true) ..
                        npairs.autopairs_cr()

        api.nvim_feedkeys(key, "n", false)
    end

    return vim.fn["coc#on_enter"]()
end

MUtils.help = function()
    local cw = vim.fn.expand("<cword>")

    if vim.fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
        api.nvim_command("h " .. cw)
    elseif vim.fn["coc#rpc#ready"]() then
        vim.fn.CocActionAsync("doHover")
    else
        api.nvim_command(string.format("!%s %s", vim.o.keywordprg, cw))
    end
end

local opts = {silent = true, noremap = true, expr = true}

keyset("i", "<Tab>", _G.MUtils.tab_complete, opts)
keyset("i", "<S-Tab>", _G.MUtils.back_tab_complete, opts)
keyset("i", "<CR>", _G.MUtils.enter, opts)
keyset("i", "<C-j>", "<Plug>(coc-snippets-expand-jump)")
keyset("i", "<C-Space>", "coc#refresh()", {silent = true, expr = true})

opts = {silent = true, nowait = true, expr = true}

keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"',
       opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"',
       opts)

keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<C-r>=coc#float#scroll(1)<CR>" : "<Right>"',
       opts)

keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<C-r>=coc#float#scroll(0)<CR>" : "<Left>"',
       opts)

keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"',
       opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"',
       opts)

keyset("n", "<C-k>", "<Plug>(coc-rename)", {silent = true})
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

opts = {silent = true, nowait = true}

keyset("n", "<Space>a", "<Plug>(coc-codeaction-cursor)", opts)
keyset("n", "<Space>s", "<Plug>(coc-codeaction-refactor)", opts)
keyset("n", "<Space>x", "<Plug>(coc-codeaction-line)", opts)
keyset("n", "<Space>g", "<Plug>(coc-codelens-action)", opts)
keyset("n", "<Space>f", "<Plug>(coc-fix-current)", opts)

keyset({"n", "x"}, "<Space>z", "<Plug>(coc-codeaction-selected)", opts)
keyset({"n", "x"}, "<Space>r", "<Plug>(coc-codeaction-refactor-selected)", opts)

keyset("n", "<Space>e", ":<C-u>CocList extensions<CR>", opts)
keyset("n", "<Space>c", ":<C-u>CocList commands<CR>", opts)
keyset("n", "<Space>o", ":<C-u>CocList outline<CR>", opts)
keyset("n", "<Space>q", ":<C-u>CocList<CR>", opts)
keyset("n", "<Space>d", _G.MUtils.diagnostic, opts)

keyset("n", "<leader>wd", "<cmd>CocCommand coc-writing.definition<CR>", opts)
keyset("n", "<leader>ww", "<cmd>CocCommand coc-writing.searchDictionary<CR>",
       opts)
keyset("n", "<leader>ws", "<cmd>CocCommand coc-writing.searchThesaurus<CR>",
       opts)
keyset("n", "<leader>wh", "<cmd>CocCommand coc-writing.health<CR>", opts)

keyset("n", "K", _G.MUtils.help, {silent = true})

local group = api.nvim_create_augroup("CocGroup", {clear = true})

api.nvim_create_autocmd("User", {
    group = group,
    pattern = "CocLocationsChange",
    desc = "Update location list on locations change",
    callback = function()
        local locs = vim.g.coc_jump_locations

        vim.fn.setloclist(0, {}, " ", {title = "CocLocationList", items = locs})

        local winid = vim.fn.getloclist(0, {winid = 0}).winid

        if winid == 0 then
            vim.cmd("bel lw")
        else
            api.nvim_set_current_win(winid)
        end
    end
})

api.nvim_create_autocmd("User", {
    group = group,
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

api.nvim_create_autocmd("CursorHold", {
    group = group,
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})
