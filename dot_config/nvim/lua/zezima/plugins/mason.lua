vim.pack.add({
  {
    src = "https://github.com/mason-org/mason.nvim",
    version = "44d1e90e1f66e077268191e3ee9d2ac97cc18e65",
  },
})

local mason = require("mason")

mason.setup({})

vim.keymap.set("", "<leader>cm", "<cmd>Mason<CR>", { desc = "Open Mason" })
