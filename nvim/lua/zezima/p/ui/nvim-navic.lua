local Z = require("zezima.utils")

-- Repo: https://github.com/SmiteshP/nvim-navic
-- Description: A simple statusline/winbar component that uses LSP to show your current code context. Named after the Indian satellite navigation system.
return {
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      Z.lsp.on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = require("zezima.constants").icons.kinds,
      }
    end,
  },
}
