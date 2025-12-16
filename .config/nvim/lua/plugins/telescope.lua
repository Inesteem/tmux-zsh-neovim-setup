return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.3",  -- or use latest stable tag
  dependencies = {
    "nvim-lua/plenary.nvim",          -- required dependency
    "nvim-telescope/telescope-fzf-native.nvim",  -- optional, for fzf sorter
  },
  cmd = "Telescope",  -- lazy load when running :Telescope command
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
    { "<leader>gbc", "<cmd>Telescope git_bcommits<cr>", desc = "Git buffer commits" },
  },
  config = function()
    -- Load fzf extension if installed
    pcall(require("telescope").load_extension, "fzf")

    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },
        },
      },
    })
  end,
}
