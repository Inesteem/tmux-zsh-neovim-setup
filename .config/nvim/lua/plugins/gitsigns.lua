return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- lazy-load on file open
	dependencies = { "nvim-lua/plenary.nvim" }, -- required dependency
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			-- You can add more configuration here as needed
		})
	end,
}
