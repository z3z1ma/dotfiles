-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy
require("lazy").setup({
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  { import = "zezima.p.ui" },
  { import = "zezima.p.ai" },
  { import = "zezima.p.git" },
  { import = "zezima.p.editor" },
  { import = "zezima.p.hacking" },
  { import = "zezima.p.testing" },
  { import = "zezima.p.core" },
  { import = "zezima.p.theme" },
  { import = "zezima.p.productivity" },
}, {
  defaults = {
    lazy = false,
    version = false,
  },
  diff = {
    cmd = "diffview.nvim",
  },
  ui = {
    border = "double",
  },
  install = { colorscheme = { "kanagawa" }, missing = true },
  checker = { enabled = true, notify = false },
  change_detection = { enabled = false },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  debug = false,
})
