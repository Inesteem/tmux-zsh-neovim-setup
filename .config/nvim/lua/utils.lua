local utils = {}

function utils.set_keymap(opts)
	local mode = opts.mode or "n"
	local bufnr = opts.bufnr or 0
	local expr = opts.expr or false

	vim.keymap.set(mode, opts.key, opts.cmd, {
		expr = expr,
		buffer = bufnr,
		noremap = true,
		silent = true,
		desc = opts.desc,
	})
end

function utils.smart_find_file()
	local success, _ = pcall(function()
		vim.cmd("tab split")
		vim.cmd("normal! gf")
	end)

	if not success then
		-- Close the tab if 'tab split' succeeded but 'gf' failed (which might leave an empty tab)
		-- However, if 'tab split' succeeded, we are in a new tab. If 'gf' failed, we might want to close it.
		-- A safer way is to check if the buffer name changed or if it's empty.
		-- But 'normal! gf' failing usually throws an error, so the pcall catches it.
		-- We need to check if we are in a new tab and if so close it?
		-- Actually, if 'normal! gf' fails, the cursor stays in the previous buffer if 'tab split' hasn't happened yet?
		-- No, 'tab split' happens first. So we are in a new tab which is a copy of the old one.
		-- We should probably close that new tab.
		vim.cmd("tabclose")

		local query = vim.fn.expand("<cfile>")
		if query:match("^[a-zA-Z0-9_.]+$") and not query:match("/") then
			query = query:gsub("%.", "/")
		end

		if vim.bo.filetype == "java" and not query:match("%.java$") then
			query = query .. ".java"
		end

		-- Use Telescope to find the file
		local actions = require("telescope.actions")
		require("telescope.builtin").find_files({
			default_text = query,
			attach_mappings = function(prompt_bufnr, map)
				map({ "i", "n" }, "<CR>", actions.select_tab)
				return true
			end,
		})
	end
end

return utils
