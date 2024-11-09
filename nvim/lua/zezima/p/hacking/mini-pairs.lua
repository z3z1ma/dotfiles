-- Repo: https://github.com/echasnovski/mini.pairs
-- Description: Neovim Lua plugin to automatically manage character pairs. Part of 'mini.nvim' library.
return {
  "echasnovski/mini.pairs",
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "scheme",
      },
      callback = function()
        vim.b.minipairs_disable = true
      end,
    })
  end,
}
