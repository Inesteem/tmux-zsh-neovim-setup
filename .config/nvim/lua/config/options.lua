-- Appearance
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Relative line numbers for easier navigation
vim.o.cursorline = true -- Highlight current line
vim.o.termguicolors = true -- Enable 24-bit RGB colors
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
vim.o.wrap = false -- Disable line wrapping by default
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
