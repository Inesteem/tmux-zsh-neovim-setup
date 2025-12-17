local utils = require("utils")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic List" })

-- Smart Go to File (overrides default gf)
vim.keymap.set("n", "gf", function()
	utils.smart_find_file()
end, { desc = "Smart Go to File (try gf, fallback to fuzzy find)" })

-- Toggle between header and source files
vim.keymap.set("n", "<leader>th", "<cmd>HeaderToSource<CR>", { desc = "Toggle between header and source files" })

-- Copy current relative path of file
vim.keymap.set("n", "<leader>cp", function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	vim.fn.setreg("*", path)
	vim.fn.setreg('"', path)
	vim.notify("Copied relative path: " .. path)
end, { desc = "Copy relative file path to clipboard" })