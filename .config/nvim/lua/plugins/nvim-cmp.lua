return {
	"hrsh7th/nvim-cmp",
--	event = "InsertEnter", -- load on entering insert mode for speed
	dependencies = {
		"L3MON4D3/LuaSnip", -- snippet engine
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-nvim-lsp", -- LSP completions
		"hrsh7th/cmp-nvim-lua", -- Shows nvim api in completion menu
		"hrsh7th/cmp-path", -- filesystem path completions
		"saadparwaiz1/cmp_luasnip", -- snippet completions
		"windwp/nvim-autopairs", -- Automatic pairs
		"petertriho/cmp-git",
		"nvim-lua/plenary.nvim",
		"hrsh7th/cmp-cmdline",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")
		local cond = require("nvim-autopairs.conds")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local select_opts = { behavior = cmp.SelectBehavior.Select }
		npairs.setup()
		npairs.add_rules({
			Rule("{:", ":}", "norg"):with_pair(cond.after_text("}")):replace_endpair(function()
				return ":"
			end),
		})
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "git" },
			}, {
				{ name = "buffer" },
			}),
		})
		require("cmp_git").setup()

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})
		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
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
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- Use LuaSnip to expand snippets
				end,
			},
			sources = cmp.config.sources({
				--		{ name = "neorg" },
				{ name = "nvim_lsp", keyword_length = 1, priority = 1000 }, -- Must be first
				{ name = "path" },
				--	{ name = "cmdline" },
				{ name = "buffer", keyword_length = 3 },
				{ name = "luasnip", keyword_length = 2, option = { show_autosnippets = true } },
			}),
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
			performance = {
				debounce = 50, -- Reduce from default 60
				throttle = 30, -- Reduce from default 30 (already minimal)
				fetching_timeout = 500,
			},
			preselect = cmp.PreselectMode.None, -- Avoid blocking UI
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
			mapping = cmp.mapping.preset.insert({
				["<C-l>"] = cmp.mapping(function(fallback) -- Move choice forward
					if luasnip.choice_active() then
						luasnip.change_choice()
					else
						fallback()
					end
				end),
				["<C-h>"] = cmp.mapping(function(fallback) -- Move choice backward
					if luasnip.choice_active() then
						luasnip.change_choice(-1)
					else
						fallback()
					end
				end),

				["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion menu
				["<C-p>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item(select_opts)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-n>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item(select_opts)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),

				["<C-e>"] = cmp.mapping.abort(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				--["<C-y>"] = cmp.mapping.confirm({ select = false }), -- Ctrl + Y to complete too
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
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
						fallback()
					else
						cmp.complete()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item(select_opts)
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
		})
	end,
}
