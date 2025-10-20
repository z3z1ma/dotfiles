vim.pack.add({
  {
    src = "https://github.com/folke/sidekick.nvim",
    version = "v2.0.0",
  },
})

local sidekick = require("sidekick")

sidekick.setup({})
