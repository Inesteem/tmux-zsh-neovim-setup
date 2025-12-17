return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- lazy-load on file open
	dependencies = { "nvim-lua/plenary.nvim" }, -- required dependency
	config = function()
		require("gitsigns").setup({
			base = "origin/main",
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			signcolumn = true, -- Disable gutter signs
			linehl = true, -- Enable line highlighting
			word_diff = false, -- Toggle with <leader>tw
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				gs.toggle_deleted(true)
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Next Hunk" })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Prev Hunk" })

				-- Actions
				map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
				map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end, { desc = "Diff This ~" })

				-- Toggles
				map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Deleted" })
				map("n", "<leader>tl", gs.toggle_linehl, { desc = "Toggle Line Highlight" })
				map("n", "<leader>tw", gs.toggle_word_diff, { desc = "Toggle Word Diff" })
			end,
		})

		-- Set custom highlights
		vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = "#2d3530" })
		vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = "#282f45" })
		vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { bg = "#3b2835" })
	end,
}
