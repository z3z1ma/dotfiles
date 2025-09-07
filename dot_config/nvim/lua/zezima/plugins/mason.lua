vim.pack.add({
  {
    src = "https://github.com/mason-org/mason.nvim",
    version = "7dc4facca9702f95353d5a1f87daf23d78e31c2a",
  },
})

local mason = require("mason")

mason.setup({})

vim.keymap.set("", "<leader>cm", "<cmd>Mason<CR>", { desc = "Open Mason" })
