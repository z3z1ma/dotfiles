-- Repo: https://github.com/folke/twilight.nvim
-- Description: 🌅 Twilight is a Lua plugin for Neovim 0.5 that dims inactive portions of the code you're editing using TreeSitter.
return {
  {
    "folke/twilight.nvim",
    opts = {
      exclude = { "help", "dashboard" },
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function",
        "method",
        "table",
        "if_statement",
        "select",
        "cte",
      },
    },
  },
}
