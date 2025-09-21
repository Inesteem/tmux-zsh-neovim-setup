local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local utils = require("utils")

vim.lsp.config.python = {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	capabilities = lsp_capabilities,
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
			},
		},
	},
}

vim.lsp.enable("python")
