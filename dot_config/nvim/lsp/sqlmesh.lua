---@brief
---
--- https://github.com/Tobikodata/sqlmesh
---
--- A Language Server Protocol implementation for SQLMesh

---@type vim.lsp.Config
return {
  cmd = { "tcloud", "exec", "sqlmesh_lsp" },
  filetypes = { "sql" },
  root_markers = {
    "config.py",
    "tcloud.yml",
    "tcloud.yaml",
    "config.yml",
    "config.yaml",
  },
  settings = {},
}
