-- Generates an augroup name prefixed with zezima_ to avoid collisions
---@param name string
---@return number
local function augroup(name)
  return vim.api.nvim_create_augroup("zezima/" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"), -- Check for changes outside of Vim
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"), -- Highlight yanked text
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"), -- Resize splits on VimResized
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"), -- Go to last location when opening a file
  callback = function(event)
    local exclude = { "gitcommit", "neo-tree", "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].zvim_last_loc then
      return
    end
    vim.b[buf].zvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"), -- Close certain filetypes with q
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"), -- Make it easier to close man-files when opened inline
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"), -- Wrap and spell check certain filetypes
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.lw = "100"
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"), -- Fix conceallevel for json files
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"), -- Automatically create directories when saving
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("quickfix_remove"), -- Remove items from quickfix list
  pattern = "qf", -- Remove items from quickfix list
  callback = function()
    vim.keymap.set("n", "dd", function()
      local qf_list = vim.fn.getqflist()
      local line = vim.fn.line(".")
      if line == 1 and vim.tbl_isempty(qf_list) then
        return
      end
      table.remove(qf_list, line)
      vim.fn.setqflist(qf_list)
      vim.cmd("cprev")
    end, { buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function()
    -- set highlight for the current line for the buffer
  end,
})

if os.getenv("TMUX") then
  vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
    group = augroup("tmux_status_off"),
    callback = function()
      vim.cmd("silent !tmux set status off")
    end,
  })
  vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
    group = augroup("tmux_status_on"),
    callback = function()
      vim.cmd("silent !tmux set status on")
    end,
  })
end

-- vim.api.nvim_create_augroup("macro_visual_indication", {})
-- vim.api.nvim_create_autocmd({ "RecordingEnter", "ColorScheme" }, {
--   group = "macro_visual_indication",
--   callback = function()
--     vim.opt.cursorline = true
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("RecordingLeave", {
--   group = "macro_visual_indication",
--   callback = function()
--     vim.opt.cursorline = false
--   end,
-- })
