local api = vim.api

local M = {}

local group = api.nvim_create_augroup("StatusLine", {clear = true})

-- Branch is window/cwd-sensitive, so keep it as one active-window cache.
local branch_cache = ""

-- Git file status is buffer-sensitive.
-- State:
--   nil  => needs fetch
--   ""   => fetch in-flight or no status
--   text => ready, e.g. "[+3, ~1, -2]"
local git_status_cache = {}

local prose_filetypes = {
    asciidoc = true,
    gitcommit = true,
    help = true,
    latex = true,
    markdown = true,
    norg = true,
    plaintex = true,
    quarto = true,
    rmd = true,
    rst = true,
    tex = true,
    text = true,
    vimwiki = true
}

local modes = setmetatable({
    n = {"NORMAL", "N"},
    no = {"N·OPERATOR", "N·P"},
    nov = {"O·PENDING", "O·P"},
    noV = {"O·PENDING", "O·P"},
    ["no\22"] = {"O·PENDING", "O·P"},

    niI = {"NORMAL", "N"},
    niR = {"NORMAL", "N"},
    niV = {"NORMAL", "N"},
    nt = {"NORMAL", "N"},
    ntT = {"NORMAL", "N"},

    v = {"VISUAL", "V"},
    V = {"V·LINE", "V·L"},
    ["\22"] = {"V·BLOCK", "V·B"},
    ["\22s"] = {"V·BLOCK", "V·B"},

    s = {"SELECT", "S"},
    S = {"S·LINE", "S·L"},
    ["\19"] = {"S·BLOCK", "S·B"},

    i = {"INSERT", "I"},
    ic = {"INSERT", "I"},
    ix = {"INSERT", "I"},

    R = {"REPLACE", "R"},
    Rv = {"V·REPLACE", "V·R"},
    Rc = {"REPLACE", "R"},
    Rx = {"REPLACE", "R"},
    Rvc = {"V·REPLACE", "V·R"},
    Rvx = {"V·REPLACE", "V·R"},

    c = {"COMMAND", "C"},
    cv = {"VIM·EX", "V·E"},
    ce = {"EX", "E"},

    r = {"PROMPT", "P"},
    rm = {"MORE", "M"},
    ["r?"] = {"CONFIRM", "C"},

    ["!"] = {"SHELL", "S"},
    t = {"TERMINAL", "T"}
}, {__index = function() return {"UNKNOWN", "U"} end})

local function status_win()
    return tonumber(vim.g.actual_curwin) or vim.fn.win_getid()
end

local function active_win() return vim.fn.win_getid() end

local function is_active() return status_win() == active_win() end

local function status_buf()
    local win = status_win()

    if win and api.nvim_win_is_valid(win) then
        return api.nvim_win_get_buf(win)
    end

    return api.nvim_get_current_buf()
end

local function win_width()
    local win = status_win()

    if win and api.nvim_win_is_valid(win) then
        return api.nvim_win_get_width(win)
    end

    return api.nvim_win_get_width(0)
end

local function is_narrow() return win_width() <= 80 end

local function buf_name(bufnr)
    bufnr = bufnr or status_buf()
    return api.nvim_buf_get_name(bufnr)
end

local function buf_filetype(bufnr)
    bufnr = bufnr or status_buf()
    return vim.bo[bufnr].filetype
end

local function buf_buftype(bufnr)
    bufnr = bufnr or status_buf()
    return vim.bo[bufnr].buftype
end

local function refresh_branch()
    if vim.g.loaded_fugitive then
        local branch = vim.fn.FugitiveHead()
        branch_cache = branch ~= "" and branch or ""
    else
        branch_cache = ""
    end
end

local function format_git_status(stdout)
    if stdout == nil or stdout == "" then return "" end

    local added, deleted = stdout:match("(%d+)%s+(%d+)")
    added = tonumber(added)
    deleted = tonumber(deleted)

    if not added or not deleted then return "" end

    local changed = math.min(added, deleted)
    added = added - changed
    deleted = deleted - changed

    local parts = {}

    if added > 0 then table.insert(parts, "+" .. added) end

    if changed > 0 then table.insert(parts, "~" .. changed) end

    if deleted > 0 then table.insert(parts, "-" .. deleted) end

    if #parts == 0 then return "" end

    return "[" .. table.concat(parts, ", ") .. "]"
end

local function git_root(file)
    if file == "" then return nil end

    return vim.fs.root(file, ".git")
end

local function relative_to_root(root, file)
    local rel = vim.fs.relpath(root, file)

    if rel and rel ~= "" then return rel end

    return file
end

local function start_git_status_fetch(bufnr)
    local file = buf_name(bufnr)

    if file == "" or buf_buftype(bufnr) ~= "" then
        git_status_cache[bufnr] = ""
        return
    end

    local root = git_root(file)

    if not root then
        git_status_cache[bufnr] = ""
        return
    end

    local rel = relative_to_root(root, file)

    git_status_cache[bufnr] = ""

    vim.system({"git", "-C", root, "diff", "--numstat", "--", rel},
               {text = true}, function(result)
        local value = ""

        if result.code == 0 then value = format_git_status(result.stdout) end

        vim.schedule(function()
            if api.nvim_buf_is_valid(bufnr) then
                git_status_cache[bufnr] = value
                vim.cmd.redrawstatus()
            end
        end)
    end)
end

local function invalidate_git_status(bufnr) git_status_cache[bufnr] = nil end

local function mode_component()
    local mode = modes[api.nvim_get_mode().mode]

    if is_narrow() then return mode[2] .. " " end

    return mode[1] .. " "
end

local function spell_component()
    if not vim.opt_local.spell:get() then return "" end

    local spell_lang = vim.opt_local.spelllang:get()

    if type(spell_lang) == "table" then
        spell_lang = table.concat(spell_lang, ",")
    end

    return string.upper(spell_lang) .. " "
end

local function git_branch_component()
    if branch_cache == "" then return "" end

    local branch = branch_cache

    if is_narrow() then branch = branch:sub(1, 2) end

    return string.upper(branch) .. " "
end

local function file_path_component()
    local bufnr = status_buf()
    local file = buf_name(bufnr)

    if file == "" then return "[No Name] " end

    local is_term = buf_buftype(bufnr) == "terminal"
    local dir = is_term and vim.env.PWD or vim.fs.dirname(file)

    dir = dir:gsub(vim.env.HOME, "~", 1)

    if is_narrow() or #file > 40 then dir = vim.fn.pathshorten(dir) end

    if is_term then return dir .. " " end

    return string.format("%s/%s ", dir, vim.fs.basename(file))
end

local function git_file_status_component()
    local bufnr = status_buf()
    local cached = git_status_cache[bufnr]

    if cached == nil then
        start_git_status_fetch(bufnr)
        return ""
    end

    if cached == "" then return "" end

    return cached
end

local function word_count_component()
    local bufnr = status_buf()
    local ft = buf_filetype(bufnr)

    if not prose_filetypes[ft] then return "" end

    local words = vim.fn.wordcount()
    local count = words.visual_words or words.words

    if not count or count == 0 then return "" end

    return "[" .. count .. "]"
end

local function file_size_component()
    local bufnr = status_buf()
    local file = buf_name(bufnr)

    if file == "" or buf_buftype(bufnr) ~= "" then return "" end

    local size = vim.fn.getfsize(file)

    if size <= 0 then return "" end

    local suffixes = {"B", "KB", "MB", "GB"}
    local i = 1

    while size > 1024 and i < #suffixes do
        size = size / 1024
        i = i + 1
    end

    return string.format("[%.0f%s]", size, suffixes[i])
end

local function file_type_component()
    local bufnr = status_buf()
    local ft = buf_filetype(bufnr)

    if ft == "" then return "[None]" end

    if not is_narrow() then return string.format("[%s]", ft) end

    local ext = vim.fn.fnamemodify(buf_name(bufnr), ":e")

    if ext == "" then return string.format("[%s]", ft) end

    local shorter = #ft < #ext and ft or ext
    return string.format("[%s]", shorter)
end

local function inactive_statusline()
    local bufnr = status_buf()
    local file = buf_name(bufnr)

    local path

    if file == "" then
        path = "[No Name]"
    else
        path = file:gsub(vim.env.HOME, "~", 1)
        path = vim.fn.pathshorten(path)
    end

    return table.concat({
        " ", path, " ", "%h%m%r%w", "%=", file_type_component()
    })
end

function M.render()
    if not is_active() then return inactive_statusline() end

    return table.concat({
        mode_component(), spell_component(), git_branch_component(), "%<",
        file_path_component(), "%h%m%r%w", "%=", git_file_status_component(),
        word_count_component(), "[%-3.(%l|%c%)]", file_size_component(),
        file_type_component()
    })
end

vim.opt.statusline = "%{%v:lua.require'config.statusline'.render()%}"

api.nvim_create_autocmd("WinEnter", {
    group = group,
    desc = "Refresh statusline branch cache",
    callback = function()
        refresh_branch()
        vim.cmd.redrawstatus()
    end
})

api.nvim_create_autocmd("BufEnter", {
    group = group,
    desc = "Refresh statusline buffer cache",
    callback = function(args)
        refresh_branch()
        invalidate_git_status(args.buf)
        vim.cmd.redrawstatus()
    end
})

api.nvim_create_autocmd("BufDelete", {
    group = group,
    desc = "Clear statusline git cache for deleted buffers",
    callback = function(args) git_status_cache[args.buf] = nil end
})

api.nvim_create_autocmd("BufWritePost", {
    group = group,
    desc = "Refresh statusline git file status",
    callback = function(args)
        invalidate_git_status(args.buf)
        vim.cmd.redrawstatus()
    end
})

api.nvim_create_autocmd({"ModeChanged", "WinLeave"}, {
    group = group,
    desc = "Redraw statusline",
    command = "redrawstatus"
})

return M
