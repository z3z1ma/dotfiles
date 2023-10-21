-- Repo: https://github.com/echasnovski/mini.indentscope
-- Description: Neovim Lua plugin to visualize and operate on indent scope. Part of 'mini.nvim' library.
return {
  {
    "echasnovski/mini.indentscope",
    version = false, -- Wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  }
}
