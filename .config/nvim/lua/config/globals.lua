_G.MUtils = _G.MUtils or {}

MUtils.spell_toggle = function()
  if vim.opt.spell:get() then
    vim.opt_local.spell = false
    vim.opt_local.spelllang = "en"
  else
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us" }
  end
end
