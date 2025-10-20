vim.pack.add({
  {
    src = "https://github.com/mason-org/mason.nvim",
    version = "ad7146aa61dcaeb54fa900144d768f040090bff0",
  },
})

local mason = require("mason")

mason.setup({})

vim.keymap.set("", "<leader>cm", "<cmd>Mason<CR>", { desc = "Open Mason" })
