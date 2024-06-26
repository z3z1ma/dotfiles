-- Repo: https://github.com/echasnovski/mini.comment
-- Description: Neovim Lua plugin for fast and familiar per-line commenting. Part of 'mini.nvim' library.
return {
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    enabled = function()
      return vim.fn.has("nvim-0.10.0") == 0
    end,
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
}
