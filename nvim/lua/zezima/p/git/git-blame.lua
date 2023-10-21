-- Repo: https://github.com/f-person/git-blame.nvim
-- Description: Git Blame plugin for Neovim written in Lua
return {
  {
    "f-person/git-blame.nvim",
    keys = {
      -- Toggle needs to be called twice; https://github.com/f-person/git-blame.nvim/issues/16
      { "<leader>gbe", ":GitBlameEnable<CR>",        desc = "Blame line (enable)" },
      { "<leader>gbd", ":GitBlameDisable<CR>",       desc = "Blame line (disable)" },
      { "<leader>gbs", ":GitBlameCopySHA<CR>",       desc = "Copy SHA" },
      { "<leader>gbc", ":GitBlameCopyCommitURL<CR>", desc = "Copy commit URL" },
      { "<leader>gbf", ":GitBlameCopyFileURL<CR>",   desc = "Copy file URL" },
    },
  }
}
