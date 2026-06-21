local parsers = {
    "bash", "fish", "zsh", "c", "cpp", "rust", "zig", "ecma", "javascript",
    "jsx", "typescript", "tsx", "html", "html_tags", "css", "scss", "json",
    "json5", "markdown", "markdown_inline", "typst", "rst", "toml", "yaml",
    "dockerfile", "make", "cmake", "ini", "editorconfig", "git_config",
    "git_rebase", "gitcommit", "gitignore", "diff", "lua", "luadoc", "vim",
    "vimdoc", "query", "python", "go", "java", "sql", "norg", "bibtex",
    "mermaid", "regex", "ssh_config", "xml"
}

return {
    {
        "romus204/tree-sitter-manager.nvim",
        dependencies = {}, -- tree-sitter CLI must be installed system-wide
        opts = {
            ensure_installed = parsers,
            auto_install = true,
            highlight = true,

            -- -- But do not use Tree-sitter highlighting for TeX/LaTeX.
            nohighlight = {"latex", "tex", "plaintex", "context"}
        }
    }, {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = "VeryLazy",
        dependencies = {"nvim-treesitter/nvim-treesitter"},
        config = function()
            local select = require("nvim-treesitter-textobjects.select")
            local move = require("nvim-treesitter-textobjects.move")
            local swap = require("nvim-treesitter-textobjects.swap")
            local repeat_move = require(
                                    "nvim-treesitter-textobjects.repeatable_move")

            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "V",
                        ["@class.outer"] = "<c-v>"
                    },
                    include_surrounding_whitespace = false
                },
                move = {set_jumps = true}
            })

            local keymap = vim.keymap.set

            local function select_map(lhs, query, group)
                group = group or "textobjects"

                keymap({"x", "o"}, lhs,
                       function()
                    select.select_textobject(query, group)
                end, {desc = "Select " .. query})
            end

            local function move_map(lhs, method, query, group)
                group = group or "textobjects"

                keymap({"n", "x", "o"}, lhs,
                       function() move[method](query, group) end,
                       {desc = method .. " " .. query})
            end

            local function swap_map(lhs, method, query)
                keymap("n", lhs, function() swap[method](query) end,
                       {desc = method .. " " .. query})
            end

            for _, map in ipairs({
                {"af", "@function.outer"}, {"if", "@function.inner"},
                {"ac", "@class.outer"}, {"ic", "@class.inner"}
            }) do select_map(map[1], map[2]) end

            for _, map in ipairs({
                {"]m", "goto_next_start", "@function.outer"},
                {"[m", "goto_previous_start", "@function.outer"},
                {"]M", "goto_next_end", "@function.outer"},
                {"[M", "goto_previous_end", "@function.outer"},

                {"]]", "goto_next_start", "@class.outer"},
                {"[[", "goto_previous_start", "@class.outer"},
                {"][", "goto_next_end", "@class.outer"},
                {"[]", "goto_previous_end", "@class.outer"},

                {"]d", "goto_next", "@conditional.outer"},
                {"[d", "goto_previous", "@conditional.outer"}
            }) do move_map(map[1], map[2], map[3]) end

            for _, map in ipairs({
                {"<leader>an", "swap_next", "@parameter.inner"},
                {"<leader>ap", "swap_previous", "@parameter.inner"}
            }) do swap_map(map[1], map[2], map[3]) end

            keymap({"n", "x", "o"}, ";", repeat_move.repeat_last_move_next,
                   {desc = "Repeat next treesitter move"})

            keymap({"n", "x", "o"}, ",", repeat_move.repeat_last_move_previous,
                   {desc = "Repeat previous treesitter move"})

            keymap({"n", "x", "o"}, "f", repeat_move.builtin_f_expr,
                   {expr = true, desc = "Repeatable f"})

            keymap({"n", "x", "o"}, "F", repeat_move.builtin_F_expr,
                   {expr = true, desc = "Repeatable F"})

            keymap({"n", "x", "o"}, "t", repeat_move.builtin_t_expr,
                   {expr = true, desc = "Repeatable t"})

            keymap({"n", "x", "o"}, "T", repeat_move.builtin_T_expr,
                   {expr = true, desc = "Repeatable T"})
        end
    }, {"folke/ts-comments.nvim", opts = {}, event = "VeryLazy"},
    {"danymat/neogen", opts = {}}, {
        "haringsrob/nvim_context_vt",
        opts = {
            disable_ft = {"rust", "rs"},
            disable_virtual_lines = true,
            min_rows = 8
        }
    }, {"nmac427/guess-indent.nvim", opts = {}}
}

