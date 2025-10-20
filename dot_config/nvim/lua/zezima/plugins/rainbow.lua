vim.pack.add({
  {
    src = "https://github.com/HiPhish/rainbow-delimiters.nvim",
    version = "v0.10.0",
  },
  {
    src = "https://github.com/cameron-wags/rainbow_csv.nvim",
    version = "26de78d8324f7ac6a3e478319d1eb1f17123eb5b",
  },
})

local rainbow_delims = require("rainbow-delimiters.setup")
rainbow_delims.setup({
  condition = function(bufnr)
    local max_filesize = 1 * 1024 * 1024 -- 1 MB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if ok and stats and stats.size > max_filesize then
      return false
    end
    return true
  end,
})

local rainbow_csv = require("rainbow_csv")
rainbow_csv.setup()
