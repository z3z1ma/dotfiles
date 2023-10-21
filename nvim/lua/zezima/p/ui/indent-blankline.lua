-- Repo: https://github.com/lukas-reineke/indent-blankline.nvim
-- Description: This plugin adds indentation guides to Neovim. It uses Neovim's virtual text feature and no conceal
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
  }
}
