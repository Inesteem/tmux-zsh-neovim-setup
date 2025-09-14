return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },
	build = "make install_jsregexp", -- optional, improves snippet performance if you use JS regex
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load() -- Load vscode style snippets lazy
		-- You can add further configuration here if needed
	end,
}
