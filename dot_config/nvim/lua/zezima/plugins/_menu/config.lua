---@private
---@class zezima.plugins._menu.config
local M = {}

---@class zezima.plugins._menu.options
M.options = {
  win = {
    border = "single",
    width = { type = "cell", value = 84 }, -- matches your content width
    height = { type = "cell", value = 15 },
    title = "Plugins",
  },
}

---@param opts zezima.plugins._menu.options
function M.extend_options(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M
