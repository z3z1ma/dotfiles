vim.pack.add({
  {
    src = "https://github.com/folke/lazydev.nvim",
    version = "e28ce52fc7ff79fcb76f0e79ee6fb6182fca90b9",
  },
})

local lazydev = require("lazydev")

lazydev.setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "snacks.nvim", words = { "Snacks" } },
    { path = "mini.nvim", words = { "MiniClue", "MiniExtra" } },
  },
})
