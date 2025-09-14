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
		--require("mason-lspconfig").setup_handlers({
		--	function(server_name) -- default handler for all servers
		--		lspconfig[server_name].setup({})
		--	end,
		--	-- You can add server-specific configs here if needed, e.g.:
		--	-- ["pyright"] = function()
		--	--   lspconfig.pyright.setup({ settings = {} })
		--	-- end,
		--})
	end,
}

--return {
--	"mason-org/mason-lspconfig.nvim",
--	opts = {},
--	dependencies = {
--		{ "mason-org/mason.nvim", opts = {} },
--		"neovim/nvim-lspconfig",
--	},
--}
