return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },
	build = "make install_jsregexp", -- optional, improves snippet performance if you use JS regex
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load() -- Load vscode style snippets lazy
		require("luasnip.loaders.from_lua").load()
		require("luasnip").setup({
			history = true,
			update_events = { "TextChanged", "TextChangedI" },
			enable_autosnippets = true,
		})
	end,
}
