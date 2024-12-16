-- Repo: https://github.com/HiPhish/rainbow-delimiters.nvim
-- Description: Rainbow delimiters for Neovim with Tree-sitter
return {
  "HiPhish/rainbow-delimiters.nvim",
  config = function()
    require("rainbow-delimiters.setup").setup({
      strategy = {
        -- ...
      },
      query = {
        -- ...
      },
      highlight = {
        -- ...
      },
    })
  end,
}
