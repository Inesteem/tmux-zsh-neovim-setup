local cmd = { "bash-language-server", "start" }
if vim.loop.os_uname().sysname == "Darwin" then
	cmd = { "/opt/homebrew/bin/bash-language-server", "start" }
end

vim.lsp.config.bash = {
	cmd = cmd,
	filetypes = { "sh", "bash", "zsh" },
	root_markers = {
		".git",
	},
}
vim.lsp.enable("bash")
