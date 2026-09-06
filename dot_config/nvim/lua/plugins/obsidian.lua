return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/repos/notes",
      },
    },
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    daily_notes = {
      enabled = true,
      folder = "journal",
      template = "daily.md",
      default_tags = { "daily" },
    },

    -- Disable frontmatter management for template files so variables like {{date}} are not overwritten
    disable_frontmatter = function(fname)
      local templates_dir = vim.fn.expand("~/repos/notes/templates")
      return vim.startswith(vim.fn.fnamemodify(fname, ":p"), templates_dir)
    end,
    ui = { enable = false }, -- disable UI features to avoid conflicts with render-markdown or similar
  },
  keys = {
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
    { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian" },
    { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find note" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Show backlinks" },
    { "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = "Show links" },
    { "<leader>ot", "<cmd>ObsidianTags<cr>", desc = "Search tags" },
    { "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Daily note" },
  },
}
