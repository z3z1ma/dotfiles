return {
  {
    "echasnovski/mini.animate",
    version = false,
    enabled = function()
      return vim.g.neovide == nil
    end,
    config = function()
      local animate = require("mini.animate")
      animate.setup({
        resize = { enable = false },
        open = { enable = false },
        close = { enable = false },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
      })
    end,
  },
}
