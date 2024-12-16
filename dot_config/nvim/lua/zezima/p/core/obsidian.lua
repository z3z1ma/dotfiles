-- Repo: https://github.com/epwalsh/obsidian.nvim
-- Description: Neovim plugin for Obsidian, written in Lua
return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  version = "*",
  cmd = { "ObsidianToday", "ObsidianYesterday", "ObsidianSearch", "ObsidianWorkspace" },
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/vaults/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/vaults/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    ui = { enable = false },
    new_notes_location = "current_dir",
    notes_subdir = "notes",
    daily_notes = {
      folder = "notes/dailies",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      -- template = "day.md"
    },
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },
    open_notes_in = "current", -- "current", "hsplit" or "vsplit"
    yaml_parser = "yq", -- "native" or "yq"
    sort_by = "modified",
    sort_reversed = true,
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/personal",
      },
      {
        name = "work",
        path = "~/vaults/work",
      },
    },
  },
}
