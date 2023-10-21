-- Leader
vim.g.mapleader = " "       -- Change leader key to space
vim.g.maplocalleader = "\\" -- Change local leader key to backslash

-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Configure lazy
require("lazy").setup({
  { import = "zezima.p.ui" },
  { import = "zezima.p.ai" },
  { import = "zezima.p.git" },
  { import = "zezima.p.editor" },
  { import = "zezima.p.hacking" },
  { import = "zezima.p.testing" },
  { import = "zezima.p.core" },
  { import = "zezima.p.theme" },
}, {
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "catppuccin/nvim" } },
  checker = { enabled = true },
  performance = {
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
})

-- Theme
vim.cmd.colorscheme("catppuccin")
vim.cmd.highlight({ "Comment", "cterm=italic", "gui=italic" })
