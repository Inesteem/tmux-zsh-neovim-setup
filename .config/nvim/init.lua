vim.opt.termguicolors = true
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- This line is disabling the spacebar in Normal and Visual modes by
-- mapping it to do nothing (<Nop>). This is typically done to prepare
-- the spacebar for use as a "leader" key for custom keybindings.
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = "<Space>"
vim.g.maplocalleader = "<Space>"

require("config.lazy")
require("config.keymaps")

-- Load all LSP's in "lua/config/lsp"
local lsp_path = vim.fn.stdpath("config") .. "/lua/config/lsp"

-- First, explicitly load the global configuration
require("config.lsp.global")

-- Then load all other LSP configs
for _, file in ipairs(vim.fn.readdir(lsp_path)) do
	if file:match("%.lua$") and file ~= "global.lua" then
		local module_name = "config.lsp." .. file:gsub("%.lua$", "")
		require(module_name)
	end
end

-- for virtual envs
vim.g.python3_host_prog = vim.fn.expand("~/.env/bin/python3")

require("config.options")

-- TODO: move this somewhere better
-- listen lsp-progress event and refresh lualine
vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
	group = "lualine_augroup",
	pattern = "LspProgressStatusUpdated",
	callback = require("lualine").refresh,
})
