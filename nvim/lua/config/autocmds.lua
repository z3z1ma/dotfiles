-- Generates an augroup name prefixed with zezima_ to avoid collisions
---@param name string
---@return number
local function augroup(name)
  return vim.api.nvim_create_augroup("zezima/" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"), -- Close certain filetypes with q
  pattern = {
    "PlenaryTestPopup",
    "grug-far",
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
    "tsplayground",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "dbout",
    "gitsigns-blame",
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

local macro_visual_indicator = augroup("macro_visual_indicator")
vim.api.nvim_create_autocmd({ "RecordingEnter", "ColorScheme" }, {
  group = macro_visual_indicator,
  callback = function()
    vim.opt.cursorline = true
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  group = macro_visual_indicator,
  callback = function()
    vim.opt.cursorline = false
  end,
})
