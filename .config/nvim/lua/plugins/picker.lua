return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        keys = {
            {
                "<leader>lg",
                function() Snacks.lazygit.open() end,
                desc = "LazyGit"
            }, {
                "<leader><leader>f",
                function() Snacks.picker.git_files() end,
                desc = "Git Files"
            },
            {
                "<leader>fl",
                function() Snacks.picker.grep() end,
                desc = "Live Grep"
            },
            {
                "<leader>ff",
                function() Snacks.picker.smart() end,
                desc = "Recent Files"
            },
            {
                "<leader>fb",
                function() Snacks.picker.buffers() end,
                desc = "Buffers"
            },
            {
                "<leader>fm",
                function() Snacks.picker.man() end,
                desc = "Man Pages"
            },
            {
                "<leader>fk",
                function() Snacks.picker.keymaps() end,
                desc = "Keymaps"
            },
            {
                "<leader>fh",
                function() Snacks.picker.help() end,
                desc = "Help Tags"
            }
        },
        opts = {
            terminal = {
                win = {
                    style = "terminal",
                    wo = {
                        winbar = "",
                        winhighlight = table.concat({
                            "Normal:Normal", "NormalNC:Normal", "WinBar:Normal",
                            "WinBarNC:Normal", "EndOfBuffer:Normal",
                            "SignColumn:Normal"
                        }, ",")
                    }
                }
            },

            styles = {
                terminal = {
                    wo = {
                        winbar = "",
                        winhighlight = table.concat({
                            "Normal:Normal", "NormalNC:Normal", "WinBar:Normal",
                            "WinBarNC:Normal", "EndOfBuffer:Normal",
                            "SignColumn:Normal"
                        }, ",")
                    }
                }
            },

            dashboard = {
                preset = {
                    keys = {
                        {
                            icon = "󰮗 ",
                            key = "f",
                            desc = "Find File",
                            action = ":lua Snacks.dashboard.pick('files')"
                        },
                        {
                            icon = " ",
                            key = "e",
                            desc = "New File",
                            action = ":ene | startinsert"
                        }, {
                            icon = " ",
                            key = "c",
                            desc = "Configuration",
                            action = ":e ~/.config/nvim/init.lua"
                        },
                        {
                            icon = " ",
                            key = "u",
                            desc = "Update Plugins",
                            action = ":Lazy sync"
                        }, {
                            icon = " ",
                            key = "r",
                            desc = "Recent Files",
                            action = ":lua Snacks.dashboard.pick('oldfiles')"
                        },
                        -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        {
                            icon = "󰗼 ",
                            key = "q",
                            desc = "Quit",
                            action = ":qa"
                        }
                    },
                    header = [[
                                                                       
  ██████   █████                   █████   █████  ███                  
 ░░██████ ░░███                   ░░███   ░░███  ░░░                   
  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   
  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  
  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  
  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  
  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ 
 ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  
                                                                       
                     λ it be like that sometimes λ                     ]]
                },
                -- header = [[
                --                                                                    
                --       ████ ██████           █████      ██                 btw
                --      ███████████             █████                            
                --      █████████ ███████████████████ ███   ███████████  
                --     █████████  ███    █████████████ █████ ██████████████  
                --    █████████ ██████████ █████████ █████ █████ ████ █████  
                --  ███████████ ███    ███ █████████ █████ █████ ████ █████ 
                -- ██████  █████████████████████ ████ █████ █████ ████ ██████
                --
                --                     λ it be like that sometimes λ                     
                -- ]]},
                formats = {
                    header = {"%s", align = "center", hl = "GruvboxYellow"},
                    icon = {"%s", hl = "normal"},
                    desc = {"%s", hl = "normal"},
                    key = {"%s", hl = "GruvboxRed"}
                },
                sections = {
                    {section = "header"},
                    {section = "keys", gap = 1, padding = 1}, {
                        section = "terminal",
                        ttl = 0, -- disable cache
                        cmd = "fortune -s",
                        hl = "SnacksDashboardKey"
                    }
                }
            },
            bigfile = {enabled = true},
            quickfile = {enabled = true},
            lazygit = {win = {width = 0, height = 0}},
            image = {doc = {enabled = true}, math = {enabled = false}},
            picker = {
                matcher = {
                    cwd_bonus = true,
                    frecency = true,
                    history_bonus = true
                },
                layout = {preset = "ivy"},
                win = {
                    input = {keys = {["<Esc>"] = {"close", mode = {"n", "i"}}}}
                }
            }
            -- picker = { enabled = true },
        }
    }
}
