return {
  {
    "sbdchd/neoformat",
    init = function()
      vim.g.neoformat_try_formatprg = 1
      vim.g.neoformat_enabled_python = { "ruff" }
      vim.g.latexindent_opt = "-m"
    end,
  },
}
