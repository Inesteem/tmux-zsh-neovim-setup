local utils = require("utils")

local query_driver = vim.env.HOME .. "/Chrome/src/third_party/llvm-build/Release+Asserts/bin/clang*"
if vim.loop.os_uname().sysname == "Darwin" then
	query_driver = vim.env.HOME .. "/Code/chromium/src/build/toolchain"
end

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
		"--query-driver=" .. query_driver, -- Update for Chromium
	},
	init_options = {
		clangdFileStatus = true,
	},
	-- For large codebases
	max_memory = 4096, -- In MB
}
vim.lsp.enable("clangd")
