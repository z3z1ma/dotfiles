vim.g["conjure#extract#tree_sitter#enabled"] = true
vim.g["conjure#log#wrap"] = true
vim.g["conjure#filetypes"] =
  { "clojure", "fennel", "janet", "hy", "julia", "racket", "scheme", "lua", "lisp", "python" }

vim.pack.add({
  {
    src = "https://github.com/Olical/conjure",
    version = "e576a98e394de9418750fb897da834bc5edccd1c",
  },
})
