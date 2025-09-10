local bindings = require("zezima.plugins._menu.bindings")
local config = require("zezima.plugins._menu.config")
local utils = require("zezima.plugins._menu.utils")
local M = {}

M.open = function()
  local float = utils.create_floating_win()
  local plugins = vim.pack.get()
  bindings.setup(float.buf, float.win)
  utils.populate_buf(float.buf, plugins)
end

---@param opts zezima.plugins._menu.options
M.setup = function(opts)
  config.extend_options(opts)
end

return M
