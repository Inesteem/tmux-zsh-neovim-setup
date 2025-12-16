local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local utils = require("utils")

vim.lsp.config.proto = {
	cmd = { "protofmt" },
	filetypes = { "proto" },
	capabilities = lsp_capabilities,
	root_dir = require("lspconfig.util").root_pattern("buf.work.yaml", ".git"),
	-- on_attach = ...,
	-- capabilities = ...,
}

vim.lsp.enable("proto")
