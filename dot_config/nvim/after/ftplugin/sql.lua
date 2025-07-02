vim.opt_local.foldmethod = "indent"

vim.lsp.config["sqlmesh_lsp"] = {
  cmd = { "tcloud", "exec", "sqlmesh_lsp" },
  filetypes = { "sql" },
  root_markers = { "config.py", "config.yaml", "config.yml" },
  settings = {
    -- NOTE: does this work?
    -- projectPath = "workspaces/datateam",
  },
}

-- vim.lsp.enable("sqlmesh_lsp")

vim.api.nvim_create_user_command("StartSQLMeshLSP", function(opts)
  local root = opts.args ~= "" and vim.fn.expand(opts.args)
    or vim.fs.root(0, { "config.py", "tcloud.yml", "tcloud.yaml", "config.yml", "config.yaml" })

  vim.lsp.start({
    name = "sqlmesh-lsp",
    cmd = { "sqlmesh_lsp" },
    root_dir = root,
    reuse_client = true,
    cmd_env = { SQLMESH_IGNORE_WARNINGS = "1" },
  })
end, {
  nargs = "?",
  complete = "dir",
  desc = "Start sqlmesh-lsp with optional root path",
})
