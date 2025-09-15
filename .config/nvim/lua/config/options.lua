-- Appearance
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Relative line numbers for easier navigation
vim.o.cursorline = true -- Highlight current line
vim.o.termguicolors = true -- Enable 24-bit RGB colors (terminal support required)
vim.o.signcolumn = "yes" -- Always show sign column to prevent shifting

-- Tabs and indentation
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.shiftwidth = 2 -- Number of spaces to indent per level
vim.o.tabstop = 2 -- Number of spaces per tab character
vim.o.smartindent = true -- Enable smart indentation
vim.o.autoindent = true -- Auto-indent new lines

-- Search
vim.o.ignorecase = true -- Case-insensitive search
vim.o.smartcase = true -- But case-sensitive if uppercase letters present
vim.o.hlsearch = true -- Highlight search matches
vim.o.incsearch = true -- Incremental search feedback

-- Wrapping and scrolling
vim.o.wrap = true -- Disable line wrapping by default
vim.o.scrolloff = 8 -- Keep 8 lines visible above/below cursor
vim.o.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor

-- Undo and backups
vim.o.undofile = true -- Enable persistent undo
-- vim.o.backup = false -- Disable backup files
-- vim.o.writebackup = false -- Disable backup before overwriting files

-- Clipboard and mouse
vim.o.clipboard = "unnamedplus" -- Use system clipboard for all operations
vim.o.mouse = "a" -- Enable mouse support in all modes

-- Splits
vim.o.splitright = true -- Vertical splits open to the right
vim.o.splitbelow = true -- Horizontal splits open below

-- Other
vim.o.timeoutlen = 300 -- Faster timeout for mapped sequences (ms)
vim.o.updatetime = 250 -- Faster completion and CursorHold events (ms)

-- Disable swapfile (optional)
-- vim.o.swapfile = false

-- Enable syntax highlighting (modern Neovim usually handles this automatically)
vim.cmd("syntax enable")

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- This line is disabling the spacebar in Normal and Visual modes by
-- mapping it to do nothing (<Nop>). This is typically done to prepare
-- the spacebar for use as a "leader" key for custom keybindings.
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = "<Space>"
vim.g.maplocalleader = "<Space>"


-- [[ Basic Keymaps ]]

-- Custom useful commands

-- switch between .h and .cc/.cpp files 
vim.api.nvim_create_user_command('HeaderToSource', function()
	local current = vim.api.nvim_buf_get_name(0)
	local new
	if current:match('%.h$') then
		new = current:gsub('%.h$', '.cc')
		if vim.fn.filereadable(new) == 0 then
			new = current:gsub('%.h$', '.cpp') -- fallback to .cpp if .cc doesn't exist
		end
	elseif current:match('%.cc$') or current:match('%.cpp$') then
		new = current:gsub('%.cc$', '.h'):gsub('%.cpp$', '.h')
	else
		print('[Not a ".h", ".cc", or ".cpp" buffer]')
		return
	end
	vim.cmd('edit ' .. new)
end, { desc = 'Toggle between header and source files' })

vim.cmd([[ nnoremap <leader>th :HeaderToSource<CR> ]])


-- Copy current relative path of file
vim.keymap.set('n', '<leader>cp', function()
	vim.fn.setreg('+', vim.fn.expand('%'))
end, { desc = 'Copy relative file path to clipboard' })
