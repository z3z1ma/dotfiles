vim.pack.add({
  {
    src = "https://github.com/folke/lazydev.nvim",
    version = "ff2cbcba459b637ec3fd165a2be59b7bbaeedf0d",
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
