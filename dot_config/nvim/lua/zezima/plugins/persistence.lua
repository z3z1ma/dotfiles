vim.pack.add({
  {
    src = "https://github.com/folke/persistence.nvim",
    version = "b20b2a7887bd39c1a356980b45e03250f3dce49c",
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
