local M = {}

M.did_init = false
function M.init()
  if not M.did_init then
    M.did_init = true
    require("util").lazy_notify()
    require("config").load("options")
  end
end

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
  local Util = require("lazy.core.util")
  local function _load(mod)
    Util.try(function()
      require(mod)
    end, {
      msg = "Failed loading " .. mod,
      on_error = function(msg)
        local info = require("lazy.core.cache").find(mod)
        if info == nil or (type(info) == "table" and #info == 0) then
          return
        end
        Util.error(msg)
      end,
    })
  end
  _load("config." .. name)
  if vim.bo.filetype == "lazy" then
    vim.cmd([[do VimResized]])
  end
  local pattern = "LazyVim" .. name:sub(1, 1):upper() .. name:sub(2)
  vim.api.nvim_exec_autocmds("User", { pattern = pattern, modeline = false })
end

function M.setup()
  M.load("autocmds")
  M.load("keymaps")
  vim.cmd.colorscheme("catppuccin")
end

return M
