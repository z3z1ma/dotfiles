-- Repo: https://github.com/folke/zen-mode.nvim
-- Description: 🧘 Distraction-free coding for Neovim
return {
  {
    "folke/zen-mode.nvim",
    lazy = true,
    cmd = { "ZenMode" },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode", remap = true },
    },
    opts = {},
  },
}
