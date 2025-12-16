vim.lsp.config.vim = {
	filetypes = { "lua" },
	cmd = { "vim-language-server", "start", "--stdio" },
	root_markers = {
		".git",
	},
	on_attach = function(client, bufnr)
		-- Key mappings for LSP functionality
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	end,
}
vim.lsp.enable("vim")
