return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				--json = { "prettier" },
				markdown = { "mdformat" },
				c = { "clang_format" },
				cpp = { "clang-format" },
				javascript = { "prettier" },
				lua = { "stylua" },
				proto = { "protofmt" },
				python = { "isort", "black" },
				typescript = { "prettier" },
			},
			format_on_save = {
				async = false,
				timeout_ms = 1000,
				lsp_format = "fallback",
			},
		})
	end,
}
