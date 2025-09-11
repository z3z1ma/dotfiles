if vim.b.did_sql_ftplugin then
  return
end
vim.b.did_sql_ftplugin = 1

local buf = vim.api.nvim_get_current_buf()

vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

vim.bo[buf].commentstring = "-- %s"

vim.opt_local.foldmethod = "indent"

-- Render with sqlmesh if present (non-disruptive; opens a quick preview)
vim.api.nvim_buf_create_user_command(buf, "SqlmeshRender", function()
  local function sqlmesh_path_flags()
    local env = vim.env.SQLMESH_PATH or ""
    if env == "" then
      return {}
    end
    local flags = {}
    for p in string.gmatch(env, "([^:]+)") do
      if p ~= "" then
        table.insert(flags, "-p")
        table.insert(flags, p)
      end
    end
    return flags
  end

  local function to_qf_and_open(text)
    local lines = vim.split(text or "", "\n", { plain = true })
    local items = {}
    for _, l in ipairs(lines) do
      if l ~= "" then
        table.insert(items, { text = l })
      end
    end
    vim.fn.setqflist(items, "r")
    vim.cmd("botright copen")
  end

  if not vim.fn.executable("sqlmesh") == 1 then
    vim.notify("sqlmesh not found", vim.log.levels.WARN)
    return
  end

  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then
    vim.notify("Save buffer before rendering", vim.log.levels.WARN)
    return
  end

  vim.fn.setqflist({})
  local on_exit = function(res)
    if res.code == 0 then
      vim.schedule(function()
        vim.notify("sqlmesh: rendered ✓")
        to_qf_and_open(res.stdout)
      end)
    else
      vim.schedule(function()
        to_qf_and_open(res.stdout .. res.stderr)
      end)
    end
  end

  local cmd
  local paths = sqlmesh_path_flags()
  if vim.fn.executable("tcloud") == 1 then
    cmd = { "tcloud", "sqlmesh" }
  else
    cmd = { "sqlmesh" }
  end

  cmd = vim.list_extend(cmd, paths)
  vim.system(vim.list_extend(cmd, { "render", file }), { text = true }, on_exit)
end, { desc = "Render current SQL file with sqlmesh" })
