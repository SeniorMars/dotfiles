-- statusline in lua!
local fn = vim.fn
local api = vim.api

-- M is an object(?)
local M = {}

M.trunc_width = setmetatable({
  mode       = 80,
  git_status = 90,
  filename   = 80,
  line_col   = 60,
}, {
  __index = function ()
    return 80 -- handle edge cases, if there's any
  end
})

M.is_truncated = function (_, width)
  local current_width = api.nvim_win_get_width(0)
  return current_width < width
end

-- we make them all uppercase then we don't need to call toupper
M.modes = setmetatable({
  ['n']  = {'Normal', 'N'};
  ['no'] = {'N·Operator', 'N·P'} ;
  ['v']  = {'Visual', 'V' };
  ['V']  = {'V·Line', 'V·L' };
  ['']   = {'V·Block', 'V·B'};
  [''] = {'V·Block', 'V·B'};
  ['s']  = {'Select', 'S'};
  ['S']  = {'S·Line', 'S·L'};
  [''] = {'S·Block', 'S·B'};
  ['i']  = {'Insert', 'I'};
  ['ic'] = {'Insert', 'I'};
  ['R']  = {'Replace', 'R'};
  ['Rv'] = {'V·Replace', 'V·R'};
  ['c']  = {'Command', 'C'};
  ['cv'] = {'Vim·Ex ', 'V·E'};
  ['ce'] = {'Ex ', 'E'};
  ['r']  = {'Prompt ', 'P'};
  ['rm'] = {'More ', 'M'};
  ['r?'] = {'Confirm ', 'C'};
  ['!']  = {'Shell ', 'S'};
  ['t']  = {'Terminal ', 'T'};
}, {
  __index = function()
      return {'Unknown', 'U'} -- handle edge cases
  end
})

M.get_current_mode = function ()
  local current_mode = api.nvim_get_mode().mode
  if self:is_truncated(self.trunc_width.mode) then
    return string.format('%s ', self.modes[current_mode][2]:upper())
  end
  return string.format('%s ', self.modes[current_mode][1]:upper())
end

-- local function mode()
--  local current_mode = api.nvim_get_mode().mode
--  if mode_map[current_mode] == nil then return current_mode end
--  return mode_map[current_mode]
-- end

local function fugitive()
  if fn.exists('g:loaded_fugitive') then
    -- # are valid in lua so we have to call it as such
    local branch = fn['fugitive#head']()
    if branch ~= '' then
      return branch .. " "
    end
  end
  return ''
end


-- I'm just going to rewrite this in vimscript, but lua
-- local function filepath()
--  if fn.expand() then
-- end

-- function! FilePath() abort
--     if expand('%:h') ==# ''
--       return '[No Name]'
--     endif
--     let l:path = expand('%:p:h')
--     let l:home = '/home/' . $USER . '/'
--     if stridx(l:path, l:home) !=# -1
--       let l:path = substitute(l:path, l:home, '~/', "")
--     endif
--     if winwidth(0) <= 80
--         let l:path = pathshorten(l:path)
--     endif
--     return l:path . '/' . expand('%:t')
-- endfunction


local function statusline()
  local filepath = '%f'
end



local function spell_toggle()
  if api.nvim_win_get_option(0, 'spell') then
    api.nvim_win_set_option(0, 'spell', false)
    api.nvim_set_option('spelllang', "en")
  else
    api.nvim_win_set_option(0, 'spell', true)
    api.nvim_set_option('spelllang', "en_us")
  end
end

-- function! SpellToggle()
--     if &spell
--       setlocal spell! spelllang&
--     else
--       setlocal spell spelllang=en_us
--     endif
-- endfunction


print(M)
-- local mode_map = {
--  ['n']  = 'NORMAL ',
--  ['no'] = 'N·OPERATOR ',
--  ['v']  = 'VISUAL ',
--  ['V']  = 'V·LINE ',
--  ['']   = 'V·BLOCK ',
--  [''] = 'V·BLOCK ',
--  ['i']  = 'INSERT ',
--  ['s']  = 'SELECT ',
--  ['S']  = 'SELECT',
--  ['R']  = 'REPLACE ',
--  ['Rv'] = 'V·REPLACE ',
--  ['c']  = 'COMMAND ',
--  ['cv'] = 'VIM EX ',
--  ['ce'] = 'EX ',
--  ['r']  = 'PROMPT ',
--  ['rm'] = 'MORE ',
--  ['r?'] = 'CONFIRM ',
--  ['!']  = 'SHELL ',
--  ['t']  = 'TERMINAL '
-- }

