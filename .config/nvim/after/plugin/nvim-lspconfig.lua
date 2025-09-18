-- Lsp-zero
local luasnip = require("luasnip")
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local lsnip = require("luasnip")
local conform = require("conform")
require("luasnip.loaders.from_vscode").lazy_load()

-- LSP attach and capabilities
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local function on_attach()
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

	-- Code actions
	if vim.lsp.buf.range_code_action then
		vim.keymap.set("x", "<leader>la", vim.lsp.buf.range_code_action, { buffer = 0, desc = "Range code action." })
	else
		vim.keymap.set("x", "<leader>la", vim.lsp.buf.code_action, { buffer = 0, desc = "Code action." })
	end
end

-- Mason
mason.setup()
mason_lspconfig.setup({
	ensure_installed = {
		"eslint",
		"pyright",
		"emmet_ls",
		"cssls",
		"lua_ls",
		"clangd",
		"rust_analyzer",
		"texlab",
	},
})

-- Luasnip
require("luasnip.loaders.from_lua").load()
lsnip.setup({
	history = true,
	update_events = { "TextChanged", "TextChangedI" },
	enable_autosnippets = true,
})

-- Language servers
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = lsp_capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "s", "t", "i", "d", "c", "sn", "f" },
			},
			format = {
				enable = false,
			},
		},
	},
	root_dir = function(fname)
		-- Make ~/.config/nvim the root for any file inside that folder
		local config_path = vim.fn.expand("~/.config/nvim")
		if fname:sub(1, #config_path) == config_path then
			return config_path
		end
		-- Fallback to built-in root finder
		return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
	end,
})
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = lsp_capabilities,
	settings = {
		python = {
			analysis = {
				diagnosticMode = "workspace",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = lsp_capabilities,
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
			rustfmt = {
				extraArgs = { "--config", "max_width=120" },
			},
		},
	},
})
lspconfig.texlab.setup({
	on_attach = on_attach,
	capabilities = lsp_capabilities,
})
lspconfig.hdl_checker.setup({
	on_attach = on_attach,
	capabilities = lsp_capabilities,
})
lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = lsp_capabilities,
})
lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = lsp_capabilities,
})
lspconfig.eslint.setup({
	on_attach = on_attach,
	capabilities = lsp_capabilities,
})
lspconfig.ts_ls.setup({
	on_attach = on_attach,
	capabilities = lsp_capabilities,
})
lspconfig.jdtls.setup({
	on_attach = on_attach,
	capabilities = lsp_capabilities,
	java = {
		home = vim.fn.expand("$JAVA_HOME"),
	},
})

-- Completion setup
cmp.setup({
	sources = {
		{ name = "luasnip", option = { show_autosnippets = true } },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "neorg" },
		{ name = "path" },
	},
	mapping = {
		-- Tab autocomplete
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif lsnip.expand_or_jumpable() then
				lsnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif lsnip.jumpable(-1) then
				lsnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Enter to complete
		["<C-y>"] = cmp.mapping.confirm({ select = false }), -- Ctrl + Y to complete too
		["<C-l>"] = cmp.mapping(function(fallback) -- Move choice forward
			if lsnip.choice_active() then
				lsnip.change_choice()
			else
				fallback()
			end
		end),
		["<C-h>"] = cmp.mapping(function(fallback) -- Move choice backward
			if lsnip.choice_active() then
				lsnip.change_choice(-1)
			else
				fallback()
			end
		end),
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	-- Expands snippets
	snippet = {
		expand = function(args)
			lsnip.lsp_expand(args.body)
		end,
	},
})

-- Automatically close parenthesis on function completion
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- Styling
vim.opt.winhighlight = cmp.config.window.bordered().winhighlight -- Hover window looks nice
vim.diagnostic.config({
	float = { border = "rounded" },
	virtual_text = true,
	signs = true,
	update_in_insert = true,
	underline = true,
})

-- Override border styling for hover window globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

cmp.setup({
	sources = {
		{ name = "nvim_lsp", option = {
			php = {
				keyword_pattern = [=[[\%(\$\k*\)\|\k\+]]=],
			},
		} },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "cmdline" },
	},
	performance = {
		debounce = 50, -- Reduce from default 60
		throttle = 30, -- Reduce from default 30 (already minimal)
		fetching_timeout = 500,
	},
	preselect = cmp.PreselectMode.None, -- Avoid blocking UI
})

-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
-- TODO rest of this setup
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = {
		textDocument = {
			semanticTokens = {
				dynamicRegistration = false,
			},
		},
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
})

lspconfig.bashls.setup({
	filetypes = { "sh", "zsh", "bash" },
	cmd = { "/opt/homebrew/bin/bash-language-server", "start" },
})

lspconfig.vimls.setup({
	filetypes = { "lua" },
	cmd = { "vim-language-server", "start" },
	on_attach = function(client, bufnr)
		-- Key mappings for LSP functionality
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	end,
})
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		-- Displays hover information about the symbol under the cursor
		bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

		-- Jump to the definition
		bufmap("n", "gd", ":tab split | <cmd>lua vim.lsp.buf.definition()<cr>")

		-- Jump to declaration
		bufmap("n", "gD", ":tab split | <cmd>lua vim.lsp.buf.declaration()<cr>")

		-- Lists all the implementations for the symbol under the cursor
		bufmap("n", "gi", ":tab split | <cmd>lua vim.lsp.buf.implementation()<cr>")

		-- Jumps to the definition of the type symbol
		bufmap("n", "og", ":tab split | <cmd>lua vim.lsp.buf.type_definition()<cr>")

		-- Lists all the references
		bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

		-- Displays a function's signature information
		bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

		-- Renames all references to the symbol under the cursor
		bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")

		-- Selects a code action available at the current cursor position
		bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")

		-- Show diagnostics in a floating window
		bufmap("n", "gll", "<cmd>lua vim.diagnostic.open_float()<cr>")

		-- Move to the previous diagnostic
		bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

		-- Move to the next diagnostic
		bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
	end,
})

vim.opt.completeopt = { "menu", "menuone", "noselect" }
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp", keyword_length = 1, priority = 1000 }, -- Must be first
		{ name = "path" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				luasnip = "⋗",
				buffer = "Ω",
				path = "🖫",
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	mapping = {
		["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		["<Down>"] = cmp.mapping.select_next_item(select_opts),

		["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-n>"] = cmp.mapping.select_next_item(select_opts),

		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),

		["<C-e>"] = cmp.mapping.abort(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<CR>"] = cmp.mapping.confirm({ select = false }),

		["<C-f>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-b>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<Tab>"] = cmp.mapping(function(fallback)
			local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback()
			else
				cmp.complete()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
})
