-- No action if not in tmux
if vim.env.TMUX == "" then
  return
end

-- Get tmux buffer name
local function get_tmux_buf_name()
  local list = vim.fn.systemlist('tmux list-buffers -F"#{buffer_name}"')
  if #list == 0 then
    return ""
  elseif list == nil then
    return ""
  end
  return list[1]
end

-- Copy current tmux buffer to vim register asynchronously
local function tmux_buf_to_vim_register()
  vim.system({ "tmux", "show-buffer" }, {
    stdout = function(err, data)
      if err then
        return
      end
      vim.schedule(function()
        vim.fn.setreg('"', data)
      end)
    end,
    stdout_buffered = true,
  })
end

local last_buf_name = ""

local group = vim.api.nvim_create_augroup("VimTmuxClipboard", { clear = true })

vim.api.nvim_create_autocmd({ "FocusLost", "FocusGained" }, {
  group = group,
  pattern = "*",
  callback = function()
    local buf_name = get_tmux_buf_name()
    if buf_name ~= last_buf_name then
      tmux_buf_to_vim_register()
    end
    last_buf_name = buf_name
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  pattern = "*",
  callback = function()
    local buf_pop = vim.system({ "tmux", "load-buffer", "-" }, {
      stdin = true,
    })
    buf_pop:write(vim.fn.getreg('"'))
    buf_pop:write(nil)
    buf_pop:wait()
  end,
})
