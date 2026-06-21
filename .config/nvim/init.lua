vim.loader.enable()
-- My init.lua
--  Layout:
--
--    lua/config/
--      options.lua     Core Vim/Neovim options.
--      globals.lua     Small global helpers used by other modules.
--      providers.lua   External provider and system-level settings.
--      keymaps.lua     General key mappings.
--      autocmds.lua    General autocommands.
--      statusline.lua  Custom statusline implementation.
--      lazy.lua        lazy.nvim bootstrap and plugin loading.
--      coc.lua         coc.nvim settings, mappings, and autocmds.
--
--    lua/plugins/
--      Plugin specs imported by config.lazy via:
--        { import = "plugins" }
--
-- Core editor options.
-- Sets leader keys and baseline Neovim behavior.
require("config.options")

-- Shared helpers.
-- Defines _G.MUtils and other cross-module utilities.
require("config.globals")

-- External providers.
-- Configures Python/Ruby/Perl, netrw, and termdebug.
require("config.providers")

-- Plugin loading.
-- Bootstraps lazy.nvim and imports lua/plugins/.
require("config.lazy")

-- General keymaps.
-- Editor-wide mappings that are not tied to one plugin.
require("config.keymaps")

-- General autocommands.
-- Cursor restore, utility buffers, resizing, terminal buffers, and timeouts.
require("config.autocmds")

-- Custom statusline.
-- StatusLine() plus cache refresh events.
require("config.statusline")

-- Coc.nvim.
-- Completion, diagnostics, code actions, hover, and Coc events.
require("config.coc")
