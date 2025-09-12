vim.bo.buflisted = false
vim.bo.swapfile = false
vim.keymap.set("n", "q", "<cmd>bd!<CR>", { buffer = 0, silent = true, nowait = true })
