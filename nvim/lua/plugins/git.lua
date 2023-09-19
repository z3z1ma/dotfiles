local M = {
  -- dedicated diff interfaces
  {
    "sindrets/diffview.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
    },
    lazy = false,
    config = function()
      vim.opt.fillchars = "diff:░"
      require("diffview").setup({
        enhanced_diff_hl = true,
      })
    end,
    keys = {
      -- use [c and [c to navigate diffs (vim built in), see :h jumpto-diffs
      -- use ]x and [x to navigate conflicts
      { "<leader>gdc", ":DiffviewOpen origin/main...HEAD",               desc = "Compare commits" },
      { "<leader>gdd", ":DiffviewClose<CR>",                             desc = "Close Diffview tab" },
      { "<leader>gdh", ":DiffviewFileHistory %<CR>",                     desc = "File history" },
      { "<leader>gdH", ":DiffviewFileHistory<CR>",                       desc = "Repo history" },
      { "<leader>gdm", ":DiffviewOpen<CR>",                              desc = "Solve merge conflicts" },
      { "<leader>gdo", ":DiffviewOpen main",                             desc = "DiffviewOpen" },
      { "<leader>gdp", ":DiffviewOpen origin/main...HEAD --imply-local", desc = "Review current PR" },
      {
        "<leader>gdP",
        ":DiffviewFileHistory --range=origin/main...HEAD --right-only --no-merges",
        desc = "Review current PR (per commit)",
      },
    },
  },

  -- git blame, inline in the buffer
  {
    "f-person/git-blame.nvim",
    keys = {
      -- toggle needs to be called twice; https://github.com/f-person/git-blame.nvim/issues/16
      { "<leader>gbe", ":GitBlameEnable<CR>",        desc = "Blame line (enable)" },
      { "<leader>gbd", ":GitBlameDisable<CR>",       desc = "Blame line (disable)" },
      { "<leader>gbs", ":GitBlameCopySHA<CR>",       desc = "Copy SHA" },
      { "<leader>gbc", ":GitBlameCopyCommitURL<CR>", desc = "Copy commit URL" },
      { "<leader>gbf", ":GitBlameCopyFileURL<CR>",   desc = "Copy file URL" },
    },
  },

  -- fugitive is a git wrapper for vim, it adds some useful commands
  -- but most actions can be accomplished with lazygit more pleasantly
  { "tpope/vim-fugitive" },
}

return M
