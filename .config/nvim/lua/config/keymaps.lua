vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic List" })
-- NOT SURE WHAT THIS DOES:
--local luasnip = require("luasnip")
--
--vim.keymap.set({ "i", "s" }, "<C-k>", function()
--	if luasnip.expand_or_jumpable() then
--		luasnip.expand_or_jump()
--	end
--end, { silent = true })
--
--vim.keymap.set({ "i", "s" }, "<C-j>", function()
--	if luasnip.jumpable(-1) then
--		luasnip.jump(-1)
--	end
--end, { silent = true })
