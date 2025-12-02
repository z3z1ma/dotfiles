vim.pack.add({
  {
    src = "https://github.com/sphamba/smear-cursor.nvim",
    version = "v0.6.0",
  },
})

if vim.g.neovide == nil then
  local smear_cursor = require("smear_cursor")
  smear_cursor.setup({
    hide_target_hack = true,
    cursor_color = "none",
  })
end
