local Z = require("zezima.utils")

-- Repo: https://github.com/rcarriga/nvim-notify
-- Description: A fancy, configurable, notification manager for NeoVim
return {
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      background_colour = "#000000",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    init = function()
      -- When noice is not enabled, install notify on VeryLazy
      if not Z.lazy.has("noice.nvim") then
        Z.lazy.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end
    end,
  }
}
