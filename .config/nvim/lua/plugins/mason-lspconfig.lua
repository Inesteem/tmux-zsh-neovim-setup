return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
	after = "mason.nvim",
	config = function()
		require("mason-lspconfig").setup({
			automatic_enable = false,
			ensure_installed = {
				"eslint",
				"pyright",
				"emmet_ls",
				"cssls",
				"lua_ls",
				"clangd",
				"rust_analyzer",
				"texlab",
				"vimls",
			},
		})
	end,
}
