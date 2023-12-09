-- Repo: https://github.com/folke/tokyonight.nvim
-- Description: 🏙 A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins.
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}
