vim.g["conjure#extract#tree_sitter#enabled"] = true
vim.g["conjure#log#wrap"] = true
vim.g["conjure#filetypes"] =
  { "clojure", "fennel", "janet", "hy", "julia", "racket", "scheme", "lua", "lisp", "python" }
vim.g["conjure#mapping#doc_word"] = false

require("zezima.plugins.plenary") -- Dependency: conjure uses plenary

vim.pack.add({
  {
    src = "https://github.com/Olical/conjure",
    version = "ecf783607efaf33c69c6f80a737a93d572cfc688",
  },
})
