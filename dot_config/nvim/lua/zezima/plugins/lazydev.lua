vim.pack.add({
  {
    src = "https://github.com/folke/lazydev.nvim",
    version = "2367a6c0a01eb9edb0464731cc0fb61ed9ab9d2c",
  },
})

local lazydev = require("lazydev")

lazydev.setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "snacks.nvim", words = { "Snacks" } },
    { path = "mini.nvim", words = { "MiniClue" } },
  },
})
