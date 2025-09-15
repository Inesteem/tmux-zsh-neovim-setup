return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter", -- load on entering insert mode for speed
	dependencies = {
		"L3MON4D3/LuaSnip", -- snippet engine
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-nvim-lsp", -- LSP completions
		"hrsh7th/cmp-nvim-lua", -- Shows nvim api in completion menu
		"hrsh7th/cmp-path", -- filesystem path completions
		"saadparwaiz1/cmp_luasnip", -- snippet completions
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- Use LuaSnip to expand snippets
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion menu
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection with Enter
				["<Tab>"] = cmp.mapping.select_next_item(), -- Navigate next item
				["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Navigate previous item
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
				{ name = "path" },
			}),
		})
	end,
}
