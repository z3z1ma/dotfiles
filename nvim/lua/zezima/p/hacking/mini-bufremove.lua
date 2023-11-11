-- Repo: https://github.com/echasnovski/mini.bufremove
-- Description: Neovim Lua plugin to remove buffers. Part of 'mini.nvim' library.
return {
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>bD",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
    },
  },
}
