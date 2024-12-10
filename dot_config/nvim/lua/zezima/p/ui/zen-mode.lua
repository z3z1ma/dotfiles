-- Repo: https://github.com/folke/zen-mode.nvim
-- Description: 🧘 Distraction-free coding for Neovim
return {
  "folke/zen-mode.nvim",
  lazy = true,
  enabled = false,
  cmd = { "ZenMode" },
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode", remap = true },
  },
  opts = {
    window = {
      width = 150,
    },
    plugins = {
      twilight = { enabled = false },
      gitsigns = { enabled = true },
      alacritty = { enabled = true, font_size = 15 },
    },
  },
}
