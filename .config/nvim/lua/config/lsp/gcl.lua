local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local utils = require("utils")

vim.lsp.config.gcl = {
  cmd = { "gclfmt" },
  filetypes = { "gcl" },
  capabilities = lsp_capabilities,
  root_dir = require("lspconfig.util").root_pattern("google3"),
  -- on_attach = ...,
  -- capabilities = ...,
}

vim.lsp.enable("gcl")
