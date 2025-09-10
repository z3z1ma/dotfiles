if vim.b.did_python_ftplugin then
  return
end
vim.b.did_python_ftplugin = 1

local buf = vim.api.nvim_get_current_buf()

vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.textwidth = 100

vim.opt_local.colorcolumn = "+1"

vim.bo[buf].commentstring = "# %s"

vim.api.nvim_create_autocmd("BufWritePost", {
  buffer = buf,
  callback = function()
    local first = (vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or "")
    if first:match("^#!.*") then
      local f = vim.api.nvim_buf_get_name(buf)
      if f ~= "" then
        pcall(vim.loop.fs_chmod, f, 493)
      end -- 0755
    end
  end,
})

if vim.fn.executable("ruff") == 1 then
  vim.bo[buf].formatprg = "ruff format -q -"
end
