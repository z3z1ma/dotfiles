if vim.b.did_yaml_ftplugin then
  return
end
vim.b.did_yaml_ftplugin = 1

local buf = vim.api.nvim_get_current_buf()

vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

vim.opt_local.foldmethod = "indent"
vim.opt_local.list = false
