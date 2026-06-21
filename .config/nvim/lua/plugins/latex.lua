return {
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_compiler_latexmk_engines = {
                ["_"] = "-lualatex -shell-escape"
            }
            vim.g.vimtex_indent_on_ampersands = 0
            vim.g.vimtex_view_method = "sioyek"
            vim.g.matchup_override_vimtex = 1
        end
    }
}
