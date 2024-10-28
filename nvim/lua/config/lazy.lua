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

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Configure lazy
require("lazy").setup({
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  { import = "lazyvim.plugins.extras.ui.mini-starter" },
  { import = "lazyvim.plugins.extras.ui.mini-animate" },
  { import = "lazyvim.plugins.extras.ui.treesitter-context" },
  { import = "lazyvim.plugins.extras.test.core" },
  { import = "lazyvim.plugins.extras.util.rest" },
  { import = "lazyvim.plugins.extras.util.startuptime" },
  { import = "lazyvim.plugins.extras.util.octo" },
  { import = "lazyvim.plugins.extras.util.project" },
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.coding.luasnip" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.coding.copilot" },
  { import = "lazyvim.plugins.extras.coding.neogen" },
  { import = "lazyvim.plugins.extras.editor.harpoon2" },
  { import = "lazyvim.plugins.extras.editor.telescope" },
  { import = "lazyvim.plugins.extras.editor.mini-diff" },
  { import = "lazyvim.plugins.extras.editor.aerial" },
  { import = "lazyvim.plugins.extras.editor.refactoring" },
  { import = "lazyvim.plugins.extras.lsp.neoconf" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.lang.nix" },
  { import = "lazyvim.plugins.extras.lang.java" },
  { import = "lazyvim.plugins.extras.lang.helm" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "zezima.p.ui" },
  { import = "zezima.p.ai" },
  { import = "zezima.p.git" },
  { import = "zezima.p.editor" },
  { import = "zezima.p.hacking" },
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
