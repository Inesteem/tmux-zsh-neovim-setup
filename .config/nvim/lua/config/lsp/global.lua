local utils = require("utils")

local function set_global_keymaps(client, bufnr)
	local conform = require("conform")

	-- Show hover information
	utils.set_keymap({
		key = "K",
		cmd = vim.lsp.buf.hover,
		desc = "Show hover information",
		bufnr = bufnr,
	})

	utils.set_keymap({
		key = "gq",
		cmd = function()
			conform.format({ timeout_ms = 500, lsp_fallback = true, async = true })
		end,
		desc = "Format buffer.",
		bufnr = bufnr,
	})
	-- Restart LSP
	utils.set_keymap({
		key = "<leader>lr",
		cmd = ":LspRestart<CR>",
		desc = "Restart LSP server",
		bufnr = bufnr,
	})

	utils.set_keymap({
		key = "gd",
		cmd = vim.lsp.buf.definition,
		--	cmd = ":tab split | <cmd>lua vim.lsp.buf.definition()<CR>",
		desc = "Go to definition",
		bufnr = bufnr,
	})

	-- Go to definition
	utils.set_keymap({
		key = "<leader>gd",
		cmd = ":Telescope lsp_definitions<CR>",
		desc = "Go to definition",
		bufnr = bufnr,
	})

	-- Go to type definition
	utils.set_keymap({
		key = "<leader>gt",
		-- key = "go",
		cmd = ":Telescope lsp_type_definitions<CR>",
		--	cmd = ":tab split | <cmd>lua vim.lsp.buf.type_definition()<CR>",
		--	cmd = vim.lsp.buf.type_definition,
		desc = "Go to type definition",
		bufnr = bufnr,
	})

	-- Go to definition in new tab
	utils.set_keymap({
		key = "gD",
		cmd = function()
			vim.cmd("tab split")
			vim.lsp.buf.definition()
		end,
		desc = "Go to definition in new tab",
		bufnr = bufnr,
	})

	-- Float diagnostics
	utils.set_keymap({
		key = "<leader>D",
		cmd = ":Telescope diagnostics bufnr=0<CR>",
		desc = "Show diagnostics for current buffer",
		bufnr = bufnr,
	})
	utils.set_keymap({
		key = "gl",
		cmd = vim.diagnostic.open_float,
		desc = "Show diagnostic information in hover.",
		bufnr = bufnr,
	})

	-- Go to implementation
	utils.set_keymap({
		key = "gi",
		cmd = ":Telescope lsp_implementations<CR>",
		--	cmd = ":tab split | <cmd>lua vim.lsp.buf.implementation()<CR>",
		--	cmd = vim.lsp.buf.implementation,
		desc = "Go to implementation",
		bufnr = bufnr,
	})

	-- Show signature help
	utils.set_keymap({
		key = "gs",
		cmd = vim.lsp.buf.signature_help,
		desc = "Show signature help",
		bufnr = bufnr,
	})

	-- Rename symbol
	utils.set_keymap({
		key = "<leader>rn",
		cmd = vim.lsp.buf.rename,
		desc = "Rename symbol",
		bufnr = bufnr,
	})

	-- Code actions
	utils.set_keymap({
		key = "<leader>ca",
		cmd = vim.lsp.buf.code_action,
		desc = "Show code actions",
		bufnr = bufnr,
	})

	-- Go to references
	utils.set_keymap({
		key = "gr",
		cmd = ":Telescope lsp_references<CR>",
		--	cmd = vim.lsp.buf.references,
		desc = "Go to references",
		bufnr = bufnr,
	})

	-- Show line diagnostics in a floating window
	utils.set_keymap({
		key = "<leader>ld",
		cmd = vim.diagnostic.open_float,
		desc = "Show line diagnostics",
		bufnr = bufnr,
	})

	-- Go to previous diagnostic
	utils.set_keymap({
		key = "[d",
		--		cmd = function()
		--			vim.diagnostic.jump({ count = -1 })
		--		end,
		cmd = vim.diagnostic.goto_prev,
		desc = "Go to previous diagnostic",
		bufnr = bufnr,
	})

	-- Go to next diagnostic
	utils.set_keymap({
		key = "]d",
		cmd = vim.diagnostic.goto_next,
		--		cmd = function()
		--			vim.diagnostic.jump({ count = 1 })
		--		end,
		desc = "Go to next diagnostic",
		bufnr = bufnr,
	})

	-- Format document
	utils.set_keymap({
		key = "<leader>fa",
		cmd = function()
			vim.lsp.buf.format({ async = true })
		end,
		desc = "Format document",
		bufnr = bufnr,
	})
end

local function configure_diagnostics()
	vim.diagnostic.config({
		virtual_text = { current_line = true },
		underline = true,
		update_in_insert = true,
		severity_sort = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.INFO] = "",
				[vim.diagnostic.severity.HINT] = "",
			},
		},
		float = {
			border = "rounded",
			source = "if_many",
		},
	})
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("global.lsp", { clear = true }),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		local bufnr = args.buf

		set_global_keymaps(client, bufnr)
		configure_diagnostics()
	end,
})

vim.lsp.config("*", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
