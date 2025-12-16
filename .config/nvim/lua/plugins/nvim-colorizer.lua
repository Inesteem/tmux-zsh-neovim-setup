return {
	"NvChad/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			filetypes = {
				"*", -- Enable colorizer for all file types
				lua = { names = true, rgb_fn = true },
				css = { rgb_fn = true }, -- Enable RGB functions in CSS files
				html = { names = true }, -- Enable named colors in HTML files
			},
			user_default_options = {
				names = true, -- Enable named colors like "red" or "blue"
				rgb_fn = true,
			},
		})
	end,
}
