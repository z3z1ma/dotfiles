-- Repo: https://github.com/xiyaowong/transparent.nvim
-- Description: Remove all background colors to make nvim transparent
return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    keys = {
      { "<leader>uT", "<cmd>TransparentToggle<cr>", desc = "Toggle transparency" },
    },
  },
}
