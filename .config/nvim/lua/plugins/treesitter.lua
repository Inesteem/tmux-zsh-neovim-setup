return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" }, -- Lazy-load
	run = ":TSUpdate", -- Automatically update parsers on install
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"cpp",
				"javascript",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"vim",
				"vimdoc",
			},
			highlight = {
				enable = true, -- Enable syntax highlighting
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
