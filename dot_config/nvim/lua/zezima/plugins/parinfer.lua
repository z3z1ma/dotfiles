vim.pack.add({
  {
    src = "https://github.com/gpanders/nvim-parinfer",
    version = "5ca09287ab3f4144f78ff7977fabc27466f71044",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  -- https://github.com/gpanders/nvim-parinfer/blob/5ca09287ab3f4144f78ff7977fabc27466f71044/doc/parinfer.txt#L65-L66
  pattern = {
    "clojure",
    "scheme",
    "lisp",
    "racket",
    "hy",
    "fennel",
    "janet",
    "carp",
    "wast",
    "yuck",
  },
  callback = function()
    vim.b.minipairs_disable = true
  end,
})
