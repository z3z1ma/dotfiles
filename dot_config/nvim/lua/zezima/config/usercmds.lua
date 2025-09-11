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

vim.api.nvim_create_user_command("PluginMenu", function()
  require("zezima.plugins._menu").open()
end, {})

-- 1) Snapshot your JIT environment and any active knob overrides
vim.api.nvim_create_user_command("JitInfo", function()
  local ok, jitlib = pcall(require, "jit")
  if not ok then
    return print("jit module not found (plain Lua build?)")
  end
  local st = { jitlib.status() } -- {enabled, ...flags...}
  print("JIT enabled:", st[1])
  print("jit.version:", jitlib.version)
  print("jit.os/arch:", jitlib.os, jitlib.arch)
  print("status flags:", table.concat(vim.list_slice(st, 2), " "))
  print("Note: flags show opts/CPU features; numeric params (hotloop=.. etc.) appear here only if overridden.")
end, {})

-- 2) Start/stop verbose trace logging (uses built-in jit.v)
local tracefile = (vim.fn.stdpath("data") .. "/jit_verbose.log")
vim.api.nvim_create_user_command("JitTraceStart", function(opts)
  local file = (opts.args ~= "" and opts.args) or tracefile
  require("jit.v").on(file)
  print("JIT verbose tracing -> " .. file .. " (do your normal actions now)")
end, { nargs = "?" })

vim.api.nvim_create_user_command("JitTraceStop", function()
  require("jit.v").off()
  print("JIT verbose tracing stopped.")
end, {})

-- 3) Summarize the trace log (roots/sides/stitches/aborts/fallbacks)
vim.api.nvim_create_user_command("JitTraceSummary", function(opts)
  local file = (opts.args ~= "" and opts.args) or tracefile
  local fh = io.open(file, "r")
  if not fh then
    return print("No trace log at " .. file)
  end
  local roots, sides, stitches, aborts, fallbacks = 0, 0, 0, 0, 0
  for line in fh:lines() do
    if line:find("^%[TRACE%s+%-%-%-") then
      aborts = aborts + 1
    end
    if line:find("%sfallback to interpreter%]$") then
      fallbacks = fallbacks + 1
    end
    if line:find("%sstitch%s") then
      stitches = stitches + 1
    end
    if line:find("%]$") and line:find(" root%]") then
      roots = roots + 1
    end
    if line:find("-> %d") and not line:find(" root%]") then
      sides = sides + 1
    end
  end
  fh:close()
  print(
    string.format(
      "Traces  root=%d  side=%d  stitch=%d  abort=%d  fallback=%d",
      roots,
      sides,
      stitches,
      aborts,
      fallbacks
    )
  )
  print("Send me this summary + the log file path.")
end, { nargs = "?" })
