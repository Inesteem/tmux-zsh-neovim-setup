return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- lazy load when opening files
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				python = { "isort", "black" },
				lua = { "stylua" },
				cpp = { "clang-format" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				require("conform").format({ async = false })
			end,
			pattern = "*",
		})
	end,
}
