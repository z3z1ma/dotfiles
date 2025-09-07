vim.pack.add({
  {
    src = "https://github.com/folke/ts-comments.nvim",
    version = "1bd9d0ba1d8b336c3db50692ffd0955fe1bb9f0c",
  },
})

if vim.fn.has("nvim-0.10.0") == 1 then
  local comments = require("ts-comments")
  comments.setup({})
end
