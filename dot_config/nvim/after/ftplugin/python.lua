if vim.b.did_python_ftplugin then
  return
end
vim.b.did_python_ftplugin = 1

local buf = vim.api.nvim_get_current_buf()

vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.textwidth = 100

vim.opt_local.colorcolumn = "+1"

vim.bo[buf].commentstring = "# %s"

vim.api.nvim_create_autocmd("BufWritePost", {
  buffer = buf,
  callback = function()
    local first = (vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or "")
    if first:match("^#!.*") then
      local f = vim.api.nvim_buf_get_name(buf)
      if f ~= "" then
        pcall(vim.uv.fs_chmod, f, 493)
      end -- 0755
    end
  end,
})

if vim.fn.executable("ruff") == 1 then
  vim.bo[buf].formatprg = "ruff format -q -"
end

local function run_ty_or_ruff(which, cmd_opts)
  local title = which:sub(1, 1):upper() .. which:sub(2)
  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then
    vim.notify(title .. ": save the file first", vim.log.levels.WARN, { title = title })
    return
  end

  -- Build command tokens
  local tokens
  if vim.fn.executable(which) == 1 then
    tokens = { which, "check", file }
  elseif vim.fn.executable("uvx") == 1 then
    tokens = { "uvx", which, "check", file }
  else
    vim.notify(title .. ": neither '" .. which .. "' nor 'uvx' is installed", vim.log.levels.ERROR, { title = title })
    return
  end

  -- Project root (fallback to CWD)
  local cwd = vim.fs.root(buf, { "pyproject.toml", "uv.lock", "requirements.txt", ".git" }) or vim.fn.getcwd()

  -- If called with a bang: send to tmux pane on the RIGHT (if present)
  if cmd_opts.bang then
    if not vim.env.TMUX or vim.env.TMUX == "" then
      vim.notify(title .. "!: not inside tmux", vim.log.levels.ERROR, { title = title })
      return
    end

    -- Build shell-safe command string
    local function shesc(s)
      return vim.fn.shellescape(s)
    end
    local shell_cmd = table.concat(vim.tbl_map(shesc, tokens), " ")
    local composed = "cd " .. shesc(cwd) .. " && " .. shell_cmd

    -- Briefly hop right to grab pane id, send keys, then return.
    -- (Keeps it simple and robust across tmux versions.)
    local cur_pane = vim.fn.systemlist({ "tmux", "display-message", "-p", "#{pane_id}" })[1]
    vim.fn.system({ "tmux", "select-pane", "-R" })
    local right_pane = vim.fn.systemlist({ "tmux", "display-message", "-p", "#{pane_id}" })[1]
    vim.fn.system({ "tmux", "select-pane", "-t", cur_pane })

    if not right_pane or right_pane == "" then
      vim.notify(title .. "!: failed to resolve right pane id", vim.log.levels.ERROR, { title = title })
      return
    end

    -- Send command (Enter = C-m)
    vim.fn.system({ "tmux", "send-keys", "-t", right_pane, composed, "Enter" })
    vim.notify(title .. "!: sent to right tmux pane", vim.log.levels.INFO, { title = title })
    return
  end

  -- Default (no bang): run inside Neovim and show a scratch results split
  vim.system(tokens, { text = true, cwd = cwd }, function(proc)
    if proc.code == 0 then
      vim.notify(title .. ": no issues found", vim.log.levels.INFO, { title = title })
      return
    end
    local raw = proc.stderr .. "\n\n" .. proc.stdout
    local lines = vim.split(raw, "\n", { trimempty = true })

    vim.schedule(function()
      vim.cmd("botright vnew")
      local outbuf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_lines(outbuf, 0, -1, false, lines)
      vim.bo[outbuf].buftype = "nofile"
      vim.bo[outbuf].bufhidden = "wipe"
      vim.bo[outbuf].swapfile = false
      vim.bo[outbuf].modifiable = false
      vim.bo[outbuf].filetype = which
      vim.api.nvim_buf_set_name(outbuf, title .. " Results")
      -- Close with 'q'
      vim.keymap.set("n", "q", "<cmd>bd!<CR>", { buffer = outbuf, silent = true, nowait = true })
      vim.cmd("wincmd p")
      vim.notify(title .. ": issues found (exit " .. proc.code .. ")", vim.log.levels.WARN, { title = title })
    end)
  end)
end

-- Buffer-local :Ty for Python; use :Ty! to run in right tmux pane
vim.api.nvim_buf_create_user_command(buf, "Ty", function(cmd_opts)
  run_ty_or_ruff("ty", cmd_opts)
end, {
  desc = "Run Ty (bang: send to right tmux pane)",
  force = true,
  bang = true,
})

-- Buffer-local :Ruff for Python; use :Ruff! to run in right tmux pane
vim.api.nvim_buf_create_user_command(buf, "Ruff", function(cmd_opts)
  run_ty_or_ruff("ruff", cmd_opts)
end, {
  desc = "Run ruff (bang: send to right tmux pane)",
  force = true,
  bang = true,
})
