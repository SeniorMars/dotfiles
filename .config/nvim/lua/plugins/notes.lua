 return {
  {
    "nvim-neorg/neorg",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.qol.toc"] = {},
          ["core.concealer"] = {
            config = {
              icon_preset = "diamond",
            },
          },
          ["core.keybinds"] = {
            config = {
              hook = function(keybinds)
                keybinds.remap_key("norg", "n", "<CR>", "<leader>ll")
              end,
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/Notes",
                journal = "~/Notes/",
              },
              default_workspace = "notes",
            },
          },
          ["core.journal"] = {
            config = {
              strategy = "flat",
              workspace = "journal",
            },
          },
          ["core.esupports.metagen"] = {
            config = {
              update_date = false,
            },
          },
        },
      })
    end,
  },
}
