vim.pack.add({
  {
    src = "https://github.com/sphamba/smear-cursor.nvim",
    version = "4b86df8a0c5f46e708616b21a02493bb0e47ecbd",
  },
})

if vim.g.neovide == nil then
  local smear_cursor = require("smear_cursor")
  smear_cursor.setup({
    hide_target_hack = true,
    cursor_color = "none",
  })
end
