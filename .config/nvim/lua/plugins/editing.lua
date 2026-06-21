return {
	{ "tpope/vim-repeat" }, { "kylechui/nvim-surround", opts = {} },
	{ "mhinz/vim-grepper" }, {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require("nvim-autopairs")
		local rule = require("nvim-autopairs.rule")
		local cond = require("nvim-autopairs.conds")

		npairs.setup({ map_cr = false, check_ts = true })

		npairs.add_rules({
			rule("$", "$", { "tex", "latex", "neorg", "md" }):with_cr(
				cond.none())
		})

		npairs.get_rules("`")[1].not_filetypes = { "tex", "latex" }
		npairs.get_rules("'")[1].not_filetypes = { "tex", "latex", "rust" }
	end
}, {
	"andymass/vim-matchup",
	config = function()
		vim.api.nvim_set_hl(0, "OffScreenPopup",
			{ fg = "#fe8019", bg = "#3c3836", italic = true })

		vim.g.matchup_matchparen_offscreen = {
			method = "popup",
			highlight = "OffScreenPopup"
		}
	end
}, {
	"chrisgrieser/nvim-various-textobjs",
	event = "VeryLazy",
	opts = { keymaps = { useDefaults = true } }
}
}
