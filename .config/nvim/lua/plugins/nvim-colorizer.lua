return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			"*", -- Enable colorizer for all file types
			lua = { names = true, rgb_fn = true },
			css = { rgb_fn = true }, -- Enable RGB functions in CSS files
			html = { names = true }, -- Enable named colors in HTML files
		}, {
			names = true, -- Enable named colors like "red" or "blue"
			rgb_fn = true,
		})
	end,
}
