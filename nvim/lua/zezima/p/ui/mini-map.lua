-- Repo: https://github.com/echasnovski/mini.map
-- Description: Neovim Lua plugin to manage window with buffer text overview.
return {
  "echasnovski/mini.map",
  version = false,
  event = { "VeryLazy" },
  config = function()
    local map = require("mini.map")
    map.setup({
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.diagnostic(),
        map.gen_integration.gitsigns(),
      },
      symbols = {
        encode = map.gen_encode_symbols.dot("3x2"),
      },
      window = {
        show_integration_count = true,
      },
    })
  end,
  keys = {
    {
      "<leader>mm",
      function()
        require("mini.map").toggle()
      end,
      desc = "Toggle Mini Map",
    },
  },
}
