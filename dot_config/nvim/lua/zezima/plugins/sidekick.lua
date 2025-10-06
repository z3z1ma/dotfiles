vim.pack.add({
  {
    src = "https://github.com/folke/sidekick.nvim",
    version = "e869205ff05a8defec31175e0f7f8f923e13cde6",
  },
})

local sidekick = require("sidekick")

sidekick.setup({})
