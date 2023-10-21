-- Provides lazy.nvim utilities

---@class zezima.utils.lazy
local M = {}

-- Require a module only on first index access
---@param module string
function M.require(module)
  local mod = nil
  -- if already loaded, return the module
  -- otherwise return a lazy module
  return type(package.loaded[module]) == "table" and package.loaded[module]
      or setmetatable({}, {
        __index = function(_, key)
          mod = mod or require(module)
          return mod[key]
        end,
      })
end

-- Return opts for a lazy.nvim managed plugin
---@param name string
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

-- Return a boolean indicating if a plugin is managed by lazy.nvim
---@param plugin string
function M.has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

-- Append a function to be called on VeryLazy
---@param fn fun()
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  local Config = require("lazy.core.config")
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    vim.schedule(function()
      fn(name)
    end)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

return M
