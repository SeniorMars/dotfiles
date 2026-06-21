return {
    {"kevinhwang91/nvim-bqf"},
    {"mbbill/undotree", lazy = true, cmd = "UndotreeToggle"}, {
        "rmagatti/auto-session",
        opts = {
            auto_save = true,
            log_level = "error",
            suppressed_dirs = {"~/", "~/Downloads", "~/Documents"},
            use_git_branch = true,
            bypass_save_filetypes = {"snacks_dashboard"}
        }
    }, {
        "uga-rosa/ccc.nvim",
        config = function()
            local ccc = require("ccc")

            ccc.setup({
                highlighter = {auto_enable = true},
                pickers = {
                    ccc.picker.hex, ccc.picker.css_rgb, ccc.picker.css_hsl,
                    ccc.picker.css_name
                }
            })
        end
    }, {
        "gelguy/wilder.nvim",
        build = ":UpdateRemotePlugins",
        config = function()
            local wilder = require("wilder")

            wilder.setup({modes = {":", "/", "?"}})

            wilder.set_option("pipeline", {
                wilder.branch(wilder.python_file_finder_pipeline({
                    file_command = function(_, arg)
                        if string.find(arg, ".") ~= nil then
                            return {"fd", "-tf", "-H"}
                        end
                        return {"fd", "-tf"}
                    end,
                    dir_command = {"fd", "-td"},
                    filters = {"fuzzy_filter", "difflib_sorter"}
                }), wilder.cmdline_pipeline(), wilder.python_search_pipeline())
            })

            wilder.set_option("renderer", wilder.popupmenu_renderer({
                highlighter = wilder.basic_highlighter(),
                left = {" "},
                right = {" ", wilder.popupmenu_scrollbar({thumb_char = " "})},
                highlights = {default = "WilderMenu", accent = "WilderAccent"}
            }))
        end
    }, {"3rd/image.nvim"}, {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        keys = {
            {"<leader>i", "<cmd>PasteImage<cr>", desc = "Paste clipboard image"}
        },
        opts = {
            default = {
                embed_image_as_base64 = false,
                prompt_for_file_name = false,
                drag_and_drop = {insert_mode = true},
                use_absolute_path = true
            }
        }
    }, {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = {"markdown"},
        opts = {file_types = {"markdown"}, latex = {enabled = false}}
    }
}
