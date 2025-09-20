-- Lsp-zero
local luasnip = require("luasnip")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local lsnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

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

local select_opts = { behavior = cmp.SelectBehavior.Select }
vim.opt.completeopt = { "menu", "menuone", "noselect" }

--  Completion setup
cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	-- Expands snippets
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	performance = {
		debounce = 50, -- Reduce from default 60
		throttle = 30, -- Reduce from default 30 (already minimal)
		fetching_timeout = 500,
	},
	preselect = cmp.PreselectMode.None, -- Avoid blocking UI
	sources = {
		--		{ name = "neorg" },
		{ name = "nvim_lsp", keyword_length = 1, priority = 1000 }, -- Must be first
		{ name = "path" },
		--	{ name = "cmdline" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2, option = { show_autosnippets = true } },
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
	--  mapping = {
	--		-- Tab autocomplete
	--		["<Tab>"] = cmp.mapping(function(fallback)
	--			if cmp.visible() then
	--				cmp.select_next_item()
	--			elseif lsnip.expand_or_jumpable() then
	--				lsnip.expand_or_jump()
	--			else
	--				fallback()
	--			end
	--		end, { "i", "s" }),
	--		["<S-Tab>"] = cmp.mapping(function(fallback)
	--			if cmp.visible() then
	--				cmp.select_prev_item()
	--			elseif lsnip.jumpable(-1) then
	--				lsnip.jump(-1)
	--			else
	--				fallback()
	--			end
	--		end, { "i", "s" }),
	--		["<C-p>"] = cmp.mapping(function(fallback)
	--			if cmp.visible() then
	--				cmp.select_prev_item()
	--			else
	--				fallback()
	--			end
	--		end, { "i", "s" }),
	--		["<C-n>"] = cmp.mapping(function(fallback)
	--			if cmp.visible() then
	--				cmp.select_next_item()
	--			else
	--				fallback()
	--			end
	--		end, { "i", "s" }),
	--		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Enter to complete
	--		["<C-y>"] = cmp.mapping.confirm({ select = false }), -- Ctrl + Y to complete too
	--		["<C-l>"] = cmp.mapping(function(fallback) -- Move choice forward
	--			if lsnip.choice_active() then
	--				lsnip.change_choice()
	--			else
	--				fallback()
	--			end
	--		end),
	--		["<C-h>"] = cmp.mapping(function(fallback) -- Move choice backward
	--			if lsnip.choice_active() then
	--				lsnip.change_choice(-1)
	--			else
	--				fallback()
	--			end
	--		end),
	--	},

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

-- Automatically close parenthesis on function completion
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
