-- Generates an augroup name prefixed with zezima_ to avoid collisions
---@param name string
---@return number
local function augroup(name)
  return vim.api.nvim_create_augroup("zezima/" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("CheckTime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("HighlightYank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("ResizeSplits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("LastLoc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].zezima_last_loc then
      return
    end
    vim.b[buf].zezima_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("CloseWithQ"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("ManUnlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("WrapSpell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    local skip = {
      nofile = true,
      help = true,
      prompt = true,
      quickfix = true,
    }
    if skip[vim.bo.buftype] then
      return
    end
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("JsonConceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("AutoCreateDir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Macro visual indicator (currently disabled)
local macro_visual_indicator = augroup("MacroVisualIndicator")
vim.api.nvim_create_autocmd({ "RecordingEnter", "ColorScheme" }, {
  group = macro_visual_indicator,
  callback = function()
    -- vim.opt.cursorline = true
  end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
  group = macro_visual_indicator,
  callback = function()
    -- vim.opt.cursorline = false
  end,
})

if vim.env.TMUX ~= "" then
  -- Get tmux buffer name
  local function get_tmux_buf_name()
    local success, list = pcall(vim.fn.systemlist, 'tmux list-buffers -F"#{buffer_name}"')
    if not success or #list == 0 then
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

  local group = augroup("VimTmuxClipboard")

  vim.api.nvim_create_autocmd({ "FocusLost", "FocusGained" }, {
    group = group,
    pattern = "*",
    callback = function()
      if vim.env.TMUX == "" or vim.fn.executable("tmux") == 0 then
        return
      end
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
      if vim.env.TMUX == "" or vim.fn.executable("tmux") == 0 then
        return
      end
      local buf_pop = vim.system({ "tmux", "load-buffer", "-" }, {
        stdin = true,
      })
      buf_pop:write(vim.fn.getreg('"'))
      buf_pop:write(nil)
      buf_pop:wait()
    end,
  })
end
