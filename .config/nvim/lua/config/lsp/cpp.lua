local utils = require("utils")

vim.lsp.config.clangd = {
	--on_attach = utils.on_attach,
	capabilities = {
		textDocument = {
			semanticTokens = {
				dynamicRegistration = false,
			},
		},
	},
	root_markers = {
		".git",
	},
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=never",
		--"--header-insertion=iwyu",
		"--all-scopes-completion",
		"--completion-style=detailed",
		"--suggest-missing-includes",
		"--query-driver=/Users/hempjudith/Code/chromium/src/build/toolchain", -- Update for Chromium
	},
	init_options = {
		clangdFileStatus = true,
	},
	-- For large codebases
	max_memory = 4096, -- In MB
}
vim.lsp.enable("clangd")
