return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = { "pyright", "clangd" }, -- servers you want installed
		})

		local lspconfig = require("lspconfig")
		local servers = { "pyright", "clangd" }

		for _, server in ipairs(servers) do
			lspconfig[server].setup({})
		end
	end,
}
