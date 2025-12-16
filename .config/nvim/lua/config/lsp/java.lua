local utils = require("utils")

-- Use Chromium's bundled JDK
local java_home = vim.env.HOME .. "/Chrome/src/third_party/jdk/current"
local jdtls_path = vim.env.HOME .. "/.local/share/nvim/mason/bin/jdtls"

if vim.loop.os_uname().sysname == "Darwin" then
	java_home = vim.env.HOME .. "/Code/chromium/src/third_party/jdk/current"
	-- Mason path on Mac might be standard ~/.local/share/nvim or different if using Homebrew neovim?
	-- Usually it's stdpath("data") .. "/mason/bin/jdtls".
	-- Let's stick to vim.fn.stdpath("data") to be safe for both if possible, but env HOME is fine for now.
	jdtls_path = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
end

-- Attempt to find the jdtls executable
local cmd = { "env", "JAVA_HOME=" .. java_home, jdtls_path }

-- If on Mac and installed via Homebrew, it might be different, but Mason puts it in path.
-- We can add platform specific checks if needed later.

vim.lsp.config.java = {
	cmd = cmd,
	filetypes = { "java" },
	root_markers = {
		"pom.xml",
		"gradle.build",
		".git",
		"mvnw",
		"gradlew",
	},
	init_options = {
		bundles = {},
	},
}

--vim.lsp.enable("java")
