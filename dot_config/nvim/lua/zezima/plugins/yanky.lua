local jit_windows = not jit.os:find("Windows")

vim.pack.add({
  {
    src = "https://github.com/gbprod/yanky.nvim",
    version = "784188e0a7363e762e53140f39124d786aec0832",
  },
})

local yanky = require("yanky")
yanky.setup({
  highlight = { timer = 250 },
  ring = { storage = jit_windows and "shada" or "sqlite" },
})
