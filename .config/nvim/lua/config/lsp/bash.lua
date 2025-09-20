vim.lsp.config.bash = {
	cmd = { "bash-language-server", "start" },
	--	cmd = { "/opt/homebrew/bin/bash-language-server", "start" },
	filetypes = { "sh", "bash", "zsh" },
	root_markers = {
		".git",
	},
}

vim.lsp.enable("bash")
