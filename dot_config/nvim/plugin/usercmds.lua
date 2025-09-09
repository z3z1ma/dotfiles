-- Open messages in a split, these include command output
vim.api.nvim_create_user_command("Messages", function()
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd([[put= execute('messages')]])
  end)
  vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
  vim.cmd.split()
  local winnr = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(winnr, bufnr)
end, {})

-- :PyAST [file]  -> quickly validates Python AST as a sanity check
-- With no args, validates the *current buffer* contents (even if unsaved).
vim.api.nvim_create_user_command("PyAST", function(opts)
  local file_arg = opts.args
  local bufnr = vim.api.nvim_get_current_buf()
  local display, tmp_path

  if file_arg == "" then
    -- Use current buffer (unsaved changes included)
    tmp_path = vim.fn.tempname() .. ".py"
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
    vim.fn.writefile(lines, tmp_path)
    file_arg = tmp_path
    display = vim.api.nvim_buf_get_name(bufnr)
    if display == "" then
      display = "[No Name]"
    end
  else
    display = file_arg
  end

  local code = [[import ast,sys,tokenize; p=sys.argv[1]; s=tokenize.open(p).read(); ast.parse(s, filename=p)]]
  local stderr, stdout = {}, {}

  vim.fn.jobstart({ "python3", "-c", code, file_arg }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data and #data > 0 then
        table.insert(stdout, table.concat(data, "\n"))
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        table.insert(stderr, table.concat(data, "\n"))
      end
    end,
    on_exit = function(_, code)
      if tmp_path then
        vim.fn.delete(tmp_path)
      end
      if code == 0 then
        vim.notify("AST OK: " .. display, vim.log.levels.INFO, { title = "PyAST" })
      else
        local msg = table.concat(stderr, "\n")
        if msg == "" then
          msg = table.concat(stdout, "\n")
        end
        vim.notify("AST ERROR in " .. display .. "\n" .. msg, vim.log.levels.ERROR, { title = "PyAST" })
      end
    end,
  })
end, { nargs = "?", complete = "file", desc = "Validate Python parses as a valid AST" })
