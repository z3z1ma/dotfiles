vim.keymap.set("n", "i", function()
  vim.cmd.bdelete()
  vim.cmd.startinsert()
end, { buffer = true, silent = true, noremap = true, desc = "dashboard.exit" })
