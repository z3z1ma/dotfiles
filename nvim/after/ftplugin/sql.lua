vim.opt_local.foldmethod = "indent"

vim.keymap.set("n", "<leader>C", function()
  local Job = require("plenary.job")

  -- Get the project root path
  local root_marker = vim.fn.findfile("cdf_config.toml", vim.fn.expand("%:p:h") .. ";")
  local project_root = root_marker and vim.fn.fnamemodify(root_marker, ":h") or nil
  if project_root == nil then
    vim.notify("Could not find cdf_config.toml in the current directory or any parent directory")
    return
  end

  -- Get the model name from the current buffer
  local model_name = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"):match("MODEL %(%s*name%s+([^,]+),")
  if model_name == nil then
    vim.notify("Could not find model name in the current buffer")
    return
  end

  -- Run the SQLMesh command
  Job:new({
    command = "cdf",
    args = { "transform", "bigquery", "render", "--no-format", model_name },
    on_start = function()
      vim.notify("Compiling model " .. model_name .. " in " .. project_root)
    end,
    on_exit = function(j, code)
      if code == 0 then
        vim.notify("SQLMesh render successful")
        vim.schedule(function()
          -- Create a new buffer
          vim.cmd("vnew")
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
