local jit_windows = not jit.os:find("Windows")

vim.pack.add({
  {
    src = "https://github.com/gbprod/yanky.nvim",
    version = "04775cc6e10ef038c397c407bc17f00a2f52b378",
  },
})

local yanky = require("yanky")
yanky.setup({
  highlight = { timer = 250 },
  ring = { storage = jit_windows and "shada" or "sqlite" },
})
