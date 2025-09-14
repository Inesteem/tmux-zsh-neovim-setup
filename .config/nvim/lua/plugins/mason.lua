return {
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup()
	end,
}
--return {
--	"mason-org/mason.nvim",
--	opts = {
--		ui = {
--			icons = {
--				package_installed = "✓",
--				package_pending = "➜",
--				package_uninstalled = "✗",
--			},
--		},
--	},
--}
