return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = "cd app && npm install --registry=https://registry.npmjs.org/",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
}