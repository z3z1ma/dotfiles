vim.opt_local.foldmethod = "indent"

if vim.fn.filereadable("sql_lsp.py") == 1 then
  vim.lsp.start({
    name = "sqlmesh-lsp",
    cmd = { "python", "sql_lsp.py" },
    root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", "requirements.txt" }),
    reuse_client = true,
  })
end
