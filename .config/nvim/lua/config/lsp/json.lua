local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local utils = require("utils")

local cmd = { "vscode-json-languageserver", "--stdio" }
if vim.loop.os_uname().sysname == "Darwin" then
	cmd = { "/opt/homebrew/bin/vscode-json-languageserver", "--stdio" }
end

vim.lsp.config.json = {
	cmd = cmd,
	filetypes = { "json", "jsonc" },
	-- Add custom command to format entire document
	commands = {
		Format = {
			function()
				vim.lsp.buf.format({ range = { { 0, 0 }, { vim.fn.line("$"), 0 } } })
			end,
		},
	},
}

vim.lsp.enable("json")
