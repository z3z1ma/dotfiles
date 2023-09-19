local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local exclude = { "gitcommit" }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
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

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- when using `dd` in the quickfix list, remove the item from the quickfix list
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
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

-- manipulate the Trouble quickfix list too
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "Trouble",
  callback = function(event)
    if require("trouble.config").options.mode ~= "telescope" then
      return
    end

    local function delete()
      local folds = require("trouble.folds")
      local telescope = require("trouble.providers.telescope")

      local ord = { "" }                   -- { filename, ... }
      local files = { [""] = { 1, 1, 0 } } -- { [filename] = { start, end, start_index } }
      for i, result in ipairs(telescope.results) do
        if files[result.filename] == nil then
          local next = files[ord[#ord]][2] + 1
          files[result.filename] = { next, next, i }
          table.insert(ord, result.filename)
        end
        if not folds.is_folded(result.filename) then
          files[result.filename][2] = files[result.filename][2] + 1
        end
      end

      local line = unpack(vim.api.nvim_win_get_cursor(0))
      for i, id in ipairs(ord) do
        if line == files[id][1] then -- Group
          local next = ord[i + 1]
          for _ = files[id][3], next and files[next][3] - 1 or #telescope.results do
            table.remove(telescope.results, files[id][3])
          end
          break
        elseif line <= files[id][2] then -- Item
          table.remove(telescope.results, files[id][3] + (line - files[id][1]) - 1)
          break
        end
      end

      if #telescope.results == 0 then
        require("trouble").close()
      else
        require("trouble").refresh({ provider = "telescope", auto = false })
      end
    end

    vim.keymap.set("n", "x", delete, { buffer = event.buf })
  end,
})
