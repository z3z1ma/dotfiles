-- Repo: https://github.com/m4xshen/hardtime.nvim
-- Description: Establish good command workflow and quit bad habit
return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  enabled = false,
  opts = {
    disabled_filetypes = {
      "NvimTree",
      "TelescopePrompt",
      "aerial",
      "alpha",
      "checkhealth",
      "dapui*",
      "Diffview*",
      "Dressing*",
      "help",
      "httpResult",
      "lazy",
      "Neogit*",
      "mason",
      "neotest-summary",
      "minifiles",
      "neo-tree*",
      "netrw",
      "noice",
      "notify",
      "prompt",
      "qf",
      "oil",
      "undotree",
      "Trouble",
      "Neotree",
      "neo-tree",
    },
  },
}
