local utils = {}

function utils.set_keymap(opts)
	local mode = opts.mode or "n"
	local bufnr = opts.bufnr or 0
	local expr = opts.expr or false

	vim.keymap.set(mode, opts.key, opts.cmd, {
		expr = expr,
		buffer = bufnr,
		noremap = true,
		silent = true,
		desc = opts.desc,
	})
end

function utils.on_attach()
	vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local conform = require("conform")
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Show documentation in hover window." })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "Jump to definition." })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "Jump to declaration." })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0, desc = "Jump to implementation." })
	vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { buffer = 0, desc = "Jump to type definition." })
	vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = 0, desc = "Jump to signature help." })
	vim.keymap.set("n", "gq", function()
		conform.format({ timeout_ms = 500, lsp_fallback = true, async = true })
	end, { buffer = 0, desc = "Format buffer." })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0, desc = "Rename symbol under cursor." })
	vim.keymap.set(
		"n",
		"gr",
		require("telescope.builtin").lsp_references,
		{ buffer = 0, desc = "Show references in a Telescope window." }
	)

	-- Diagnostics
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = 0, desc = "Jump to next diagnostic." })
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = 0, desc = "Jump to previous diagnostic." })
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = 0, desc = "Show diagnostic information in hover." })
end

return utils
