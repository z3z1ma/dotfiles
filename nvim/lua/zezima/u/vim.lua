-- Provides vim utilities
---@class zezima.u.vim
local M = {}

---Toggle a vim opt between two values
---@param opt string The vim option to toggle
---@param either? {[1]:any, [2]:any} A pair of explicit values to toggle between, otherwise just negate the option
function M.toggle_opt(opt, either)
  if either then
    if vim.opt_local[opt]:get() == either[1] then
      vim.opt_local[opt] = either[2]
    else
      vim.opt_local[opt] = either[1]
    end
  end
  vim.opt_local[opt] = not vim.opt_local[opt]:get()
end

-- Store the state of line numbers
local nu = { number = true, relativenumber = true }

---Toggle line numbers and relative line numbers
function M.toggle_number()
  if vim.opt_local.number:get() or vim.opt_local.relativenumber:get() then
    nu = { number = vim.opt_local.number:get(), relativenumber = vim.opt_local.relativenumber:get() }
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  else
    vim.opt_local.number = nu.number
    vim.opt_local.relativenumber = nu.relativenumber
  end
end

-- Store the state of diagnostics
local diag_enabled = true

---Toggle diagnostics
function M.toggle_diagnostics()
  diag_enabled = not diag_enabled
  if diag_enabled then
    vim.diagnostic.enable()
  else
    vim.diagnostic.enable(false)
  end
end

-- Store terms
---@type table<string,LazyFloat>
local terminals = {}

-- Opens a floating terminal (interactive by default)
---@param cmd? string[]|string
---@param opts? {interactive?:boolean, esc_esc?:false, ctrl_hjkl?:false}
function M.float_term(cmd, opts)
  opts = vim.tbl_deep_extend("force", {
    ft = "lazyterm",
    size = { width = 0.9, height = 0.9 },
  }, opts or {}, { persistent = true })
  ---@cast opts table

  local termkey = vim.inspect({ cmd = cmd or "shell", cwd = opts.cwd, env = opts.env, count = vim.v.count1 })

  if terminals[termkey] and terminals[termkey]:buf_valid() then
    terminals[termkey]:toggle()
  else
    terminals[termkey] = require("lazy.util").float_term(cmd, opts)
    local buf = terminals[termkey].buf
    vim.b[buf].lazyterm_cmd = cmd
    if opts.esc_esc == false then
      vim.keymap.set("t", "<esc>", "<esc>", { buffer = buf, nowait = true })
    end
    if opts.ctrl_hjkl == false then
      vim.keymap.set("t", "<c-h>", "<c-h>", { buffer = buf, nowait = true })
      vim.keymap.set("t", "<c-j>", "<c-j>", { buffer = buf, nowait = true })
      vim.keymap.set("t", "<c-k>", "<c-k>", { buffer = buf, nowait = true })
      vim.keymap.set("t", "<c-l>", "<c-l>", { buffer = buf, nowait = true })
    end

    vim.api.nvim_create_autocmd("BufEnter", {
      buffer = buf,
      callback = function()
        vim.cmd.startinsert()
      end,
    })
  end

  return terminals[termkey]
end

return M
