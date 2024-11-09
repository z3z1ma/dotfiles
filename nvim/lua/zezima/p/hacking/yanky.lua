-- Repo: https://github.com/gbprod/yanky.nvim
-- Description: Improved Yank and Put functionalities for Neovim
local jit_windows = not jit.os:find("Windows")
return {
  "gbprod/yanky.nvim",
  lazy = true,
  dependencies = { { "kkharji/sqlite.lua", enabled = jit_windows } },
  opts = {
    highlight = { timer = 250 },
    ring = { storage = jit_windows and "shada" or "sqlite" },
  },
}
