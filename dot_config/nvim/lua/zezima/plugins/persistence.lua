vim.pack.add({
  {
    src = "https://github.com/folke/persistence.nvim",
    version = "166a79a55bfa7a4db3e26fc031b4d92af71d0b51",
  },
})

local persistence = require("persistence")
persistence.setup({})

vim.keymap.set("", "<leader>qs", function()
  require("persistence").load()
end, { desc = "Restore Session" })
vim.keymap.set("", "<leader>qS", function()
  require("persistence").select()
end, { desc = "Select Session" })
vim.keymap.set("", "<leader>ql", function()
  require("persistence").load({ last = true })
end, { desc = "Restore Last Session" })
