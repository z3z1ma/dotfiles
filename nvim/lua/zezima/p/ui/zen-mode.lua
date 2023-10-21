-- Repo: https://github.com/folke/zen-mode.nvim
-- Description: 🧘 Distraction-free coding for Neovim
return {
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>z"] = { name = "+zen" },
      }
    }
  },
}
