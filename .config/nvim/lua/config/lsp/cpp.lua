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
		"src",
	},
	cmd = {
		--"clangd",
		--"/Users/hempjudith/Code/chrome/src/third_party/llvm-build/Release+Asserts/bin/clang++",
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=never",
		--"--header-insertion=iwyu",
		"--all-scopes-completion",
		"--completion-style=detailed",
		--"--suggest-missing-includes",
		"--query-driver=/Users/hempjudith/Code/chrome/src/build/toolchain", -- Update for Chromium
		-- "--compile-commands-dir=/Users/hempjudith/Code/chrome/src/out/Default",
		--		"--log=verbose",
	},
	init_options = {
		clangdFileStatus = true,
	},
	--root_dir = require("lspconfig.util").root_pattern(".git", "src"),
	-- For large codebases
	max_memory = 8192, -- In MB
}
vim.lsp.enable("clangd")
