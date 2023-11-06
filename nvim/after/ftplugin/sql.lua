local function extract_model_name()
  -- Read the entire buffer content
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local content = table.concat(lines, "\n")

  -- Extract the model name using Lua pattern matching
  local model_name = content:match "MODEL %(%s*name%s+([^,]+),"

  -- Store the extracted string in a table
  local some = {}
  some.table = model_name

  return some
end

local function get_project_root()
  -- Search for config.py / config.yaml / config.yml going up the directory tree from filepath
  local config_path = vim.fn.findfile("config.py", vim.fn.expand "%:p:h" .. ";")
  if config_path == "" then
    config_path = vim.fn.findfile("config.yaml", vim.fn.expand "%:p:h" .. ";")
  end
  if config_path == "" then
    config_path = vim.fn.findfile("config.yml", vim.fn.expand "%:p:h" .. ";")
  end
  local some = {}
  some.table = config_path and vim.fn.fnamemodify(config_path, ":h") or nil
  return some
end

vim.keymap.set("n", "<leader>C", function()
  local Job = require "plenary.job"

  -- Get the project root path
  local project_root = get_project_root().table
  if project_root == nil then
    vim.notify "Could not find config.py / config.yaml / config.yml in the current directory or any parent directory"
    return
  end

  -- Get the model name from the current buffer
  local model_name = extract_model_name().table
  if model_name == nil then
    vim.notify "Could not find model name in the current buffer"
    return
  end

  -- Run the SQLMesh command
  Job:new({
    command = "sqlmesh",
    args = { "-p", project_root, "render", "--no-format", model_name },
    on_start = function()
      vim.notify("Compiling model " .. model_name .. " in " .. project_root)
    end,
    on_exit = function(j, code)
      if code == 0 then
        vim.notify "SQLMesh render successful"
        vim.schedule(function()
          -- Create a new buffer
          vim.cmd "vnew"
          -- Ensure buffer is temporary
          vim.bo.buftype = "nofile"
          -- Set ft to SQL
          vim.bo.filetype = "sql"
          -- Set the buffer content to the output of the SQLMesh command
          vim.api.nvim_buf_set_lines(0, 0, -1, false, j:result())
          -- Ensure buffer is not editable
          vim.bo.modifiable = false
          -- Allow close with q
          vim.bo.buflisted = false
        end)
      else
        vim.notify("SQLMesh render failed with exit code " .. code)
      end
    end,
  }):start()
end, { desc = "Compile SQLMesh Model" })
