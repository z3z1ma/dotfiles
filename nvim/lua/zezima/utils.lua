-- This module provides generic useful utilities as well as entrypoints to more specific utilities

---@class zezima.utils
---@field public lazy zezima.utils.lazy
---@field public lsp zezima.utils.lsp
---@field public vim zezima.utils.vim
---@field public telescope zezima.utils.telescope
local M = {}

-- Pass through to zezima.u modules for more specific utilities
setmetatable(M, {
  __index = function(t, k)
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("zezima.u." .. k)
    return t[k]
  end,
})

-- Patterns used to find the root directory
M.root_patterns = { ".git", "lua" }

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        ---@cast r string
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

-- Fast implementation to check if a table is a list
---@param t table
function M.is_list(t)
  local i = 0
  ---@diagnostic disable-next-line: no-unknown
  for _ in pairs(t) do
    i = i + 1
    if t[i] == nil then
      return false
    end
  end
  return true
end

-- Extend a list
---@generic T
---@param list T[]
---@param add T[]
---@return T[]
function M.extend(list, add)
  local idx = {}
  for _, v in ipairs(list) do
    idx[v] = v
  end
  for _, a in ipairs(add) do
    if not idx[a] then
      table.insert(list, a)
    end
  end
  return list
end

local function can_merge(v)
  return type(v) == "table" and (vim.tbl_isempty(v) or not M.is_list(v))
end

--- Merges the values similar to vim.tbl_deep_extend with the **force** behavior,
--- but the values can be any type, in which case they override the values on the left.
--- Values will me merged in-place in the first left-most table. If you want the result to be in
--- a new table, then simply pass an empty table as the first argument `vim.merge({}, ...)`
--- Supports clearing values by setting a key to `vim.NIL`
---@generic T
---@param ... T
---@return T
function M.merge(...)
  local ret = select(1, ...)
  if ret == vim.NIL then
    ret = nil
  end
  for i = 2, select("#", ...) do
    local value = select(i, ...)
    if can_merge(ret) and can_merge(value) then
      for k, v in pairs(value) do
        ret[k] = M.merge(ret[k], v)
      end
    elseif value == vim.NIL then
      ret = nil
    elseif value ~= nil then
      ret = value
    end
  end
  return ret
end

---@param name string
---@return string
function M.normname(name)
  local ret = name:lower():gsub("^n?vim%-", ""):gsub("%.n?vim$", ""):gsub("%.lua", ""):gsub("[^a-z]+", "")
  return ret
end

---@return string
function M.norm(path)
  if path:sub(1, 1) == "~" then
    local home = vim.loop.os_homedir() or vim.fn.expand("$HOME")
    ---@cast home string
    if home:sub(-1) == "\\" or home:sub(-1) == "/" then
      home = home:sub(1, -2)
    end
    path = home .. path:sub(2)
  end
  path = path:gsub("\\", "/"):gsub("/+", "/")
  return path:sub(-1) == "/" and path:sub(1, -2) or path
end

---@param opts? {level?: number}
function M.pretty_trace(opts)
  opts = opts or {}
  local Config = require("lazy.core.config")
  local trace = {}
  local level = opts.level or 2
  while true do
    local info = debug.getinfo(level, "Sln")
    if not info then
      break
    end
    if info.what ~= "C" and not info.source:find("lazy.nvim") then
      local source = info.source:sub(2)
      if source:find(Config.options.root, 1, true) == 1 then
        source = source:sub(#Config.options.root + 1)
      end
      source = vim.fn.fnamemodify(source, ":p:~:.") --[[@as string]]
      local line = "  - " .. source .. ":" .. info.currentline
      if info.name then
        line = line .. " _in_ **" .. info.name .. "**"
      end
      table.insert(trace, line)
    end
    level = level + 1
  end
  return #trace > 0 and ("\n\n# stacktrace:\n" .. table.concat(trace, "\n")) or ""
end

---@alias ZNotifyOpts {lang?:string, title?:string, level?:number, once?:boolean, stacktrace?:boolean, stacklevel?:number}

---@param msg string|string[]
---@param opts? ZNotifyOpts
function M.notify(msg, opts)
  if vim.in_fast_event() then
    return vim.schedule(function()
      M.notify(msg, opts)
    end)
  end

  opts = opts or {}
  if type(msg) == "table" then
    msg = table.concat(
      vim.tbl_filter(function(line)
        return line or false
      end, msg),
      "\n"
    )
  end
  if opts.stacktrace then
    msg = msg .. M.pretty_trace({ level = opts.stacklevel or 2 })
  end
  local lang = opts.lang or "markdown"
  local n = opts.once and vim.notify_once or vim.notify
  n(msg, opts.level or vim.log.levels.INFO, {
    on_open = function(win)
      local ok = pcall(function()
        vim.treesitter.language.add("markdown")
      end)
      if not ok then
        pcall(require, "nvim-treesitter")
      end
      vim.wo[win].conceallevel = 3
      vim.wo[win].concealcursor = ""
      vim.wo[win].spell = false
      local buf = vim.api.nvim_win_get_buf(win)
      if not pcall(vim.treesitter.start, buf, lang) then
        vim.bo[buf].filetype = lang
        vim.bo[buf].syntax = lang
      end
    end,
    title = opts.title or "zezima.nvim",
  })
end

---@param msg string|string[]
---@param opts? ZNotifyOpts
function M.error(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.ERROR
  M.notify(msg, opts)
end

---@param msg string|string[]
---@param opts? ZNotifyOpts
function M.info(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.INFO
  M.notify(msg, opts)
end

---@param msg string|string[]
---@param opts? ZNotifyOpts
function M.warn(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.WARN
  M.notify(msg, opts)
end

---@param msg string|table
---@param opts? ZNotifyOpts
function M.debug(msg, opts)
  if not require("lazy.core.config").options.debug then
    return
  end
  opts = opts or {}
  if opts.title then
    opts.title = "lazy.nvim: " .. opts.title
  end
  if type(msg) == "string" then
    M.notify(msg, opts)
  else
    opts.lang = "lua"
    M.notify(vim.inspect(msg), opts)
  end
end

---@alias ZProfile {data: string|{[string]:string}, time: number, [number]:ZProfile}

---@type ZProfile[]
M._profiles = { { name = "zezima" } }

---@param data (string|{[string]:string})?
---@param time number?
function M.track(data, time)
  if data then
    local entry = {
      data = data,
      time = time or vim.loop.hrtime(),
    }
    table.insert(M._profiles[#M._profiles], entry)

    if not time then
      table.insert(M._profiles, entry)
    end
    return entry
  else
    ---@type ZProfile
    local entry = table.remove(M._profiles)
    entry.time = vim.loop.hrtime() - entry.time
    return entry
  end
end

---@generic F: fun()
---@param data (string|{[string]:string})?
---@param fn F
---@return F
function M.trackfn(data, fn)
  return function(...)
    M.track(data)
    local ok, ret = pcall(fn, ...)
    M.track()
    if not ok then
      error(ret)
    end
    return ret
  end
end

---@param opts? string|{msg:string, on_error:fun(msg)}
function M.try(fn, opts)
  opts = type(opts) == "string" and { msg = opts } or opts or {}
  local msg = opts.msg
  -- error handler
  local error_handler = function(err)
    msg = (msg and (msg .. "\n\n") or "") .. err .. M.pretty_trace()
    if opts.on_error then
      opts.on_error(msg)
    else
      vim.schedule(function()
        M.error(msg)
      end)
    end
    return err
  end
  ---@type boolean, any
  local ok, result = xpcall(fn, error_handler)
  return ok and result or nil
end

---@alias FileType "file"|"directory"|"link"
---@param path string
---@param fn fun(path: string, name:string, type:FileType):boolean?
function M.ls(path, fn)
  local handle = vim.loop.fs_scandir(path)
  while handle do
    local name, t = vim.loop.fs_scandir_next(handle)
    if not name then
      break
    end

    local fname = path .. "/" .. name

    -- HACK: type is not always returned due to a bug in luv,
    -- so fetch it with fs_stat instead when needed.
    -- see https://github.com/folke/lazy.nvim/issues/306
    if fn(fname, name, t or vim.loop.fs_stat(fname).type) == false then
      break
    end
  end
end

---@param path string
---@param fn fun(path: string, name:string, type:FileType)
function M.walk(path, fn)
  M.ls(path, function(child, name, type)
    if type == "directory" then
      M.walk(child, fn)
    end
    fn(child, name, type)
  end)
end

---@param root string
---@param fn fun(modname:string, modpath:string)
---@param modname? string
function M.walkmods(root, fn, modname)
  modname = modname and (modname:gsub("%.$", "") .. ".") or ""
  M.ls(root, function(path, name, type)
    if name == "init.lua" then
      fn(modname:gsub("%.$", ""), path)
    elseif (type == "file" or type == "link") and name:sub(-4) == ".lua" then
      fn(modname .. name:sub(1, -5), path)
    elseif type == "directory" then
      M.walkmods(path, fn, modname .. name .. ".")
    end
  end)
end

---@param name string
function M.fg(name)
  ---@type {foreground?:number}?
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  local fg = hl and hl.fg or hl.foreground
  return fg and { fg = string.format("#%06x", fg) }
end

return M
