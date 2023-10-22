-- Repo: https://github.com/epwalsh/obsidian.nvim
-- Description: Neovim plugin for Obsidian, written in Lua
return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "vaults/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. "vaults/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
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
