return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required

    -- optional
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim", -- comes with lazyvim
    --"ibhagwan/fzf-lua", -- if you want it to be faster
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
  },
}
