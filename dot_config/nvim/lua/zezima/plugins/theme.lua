vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
    version = "main",
  },
  {
    src = "https://github.com/rebelot/kanagawa.nvim",
    version = "master",
  },
  {
    src = "https://github.com/rasulomaroff/reactive.nvim",
    version = "e0a22a42811ca1e7aa7531f931c55619aad68b5d",
  },
})

require("zezima.plugins.bufferline")

local catppuccin = require("catppuccin")

---@diagnostic disable-next-line: missing-fields
catppuccin.setup({
  integrations = {
    aerial = false,
    alpha = false,
    blink_cmp = true,
    bufferline = true,
    cmp = false,
    dashboard = false,
    dropbar = {
      enabled = true,
      color_mode = true,
    },
    flash = false,
    fzf = false,
    gitsigns = true,
    grug_far = true,
    headlines = false,
    illuminate = false,
    indent_blankline = { enabled = false },
    leap = true,
    lsp_trouble = true,
    markdown = true,
    mason = true,
    mini = true,
    native_lsp = {
      enabled = true,
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
    navic = { enabled = false, custom_bg = "lualine" },
    neotest = false,
    neotree = false,
    noice = true,
    notify = true,
    rainbow_delimiters = true,
    ts_rainbow2 = true,
    semantic_tokens = true,
    snacks = true,
    telescope = false,
    term_colors = true,
    treesitter = true,
    treesitter_context = true,
    which_key = false,
  },
})

local reactive = require("reactive")
reactive.setup({
  load = { "catppuccin-mocha-cursorline" },
})

vim.api.nvim_create_user_command("CatppuccinTransparency", function()
  catppuccin.options.transparent_background = not catppuccin.options.transparent_background
  catppuccin.compile()
  vim.cmd.colorscheme(vim.g.colors_name)
end, { desc = "Toggle transparency" })

if vim.g.neovide then
  vim.g.terminal_color_0 = "#45475a"
  vim.g.terminal_color_1 = "#f38ba8"
  vim.g.terminal_color_2 = "#a6e3a1"
  vim.g.terminal_color_3 = "#f9e2af"
  vim.g.terminal_color_4 = "#89b4fa"
  vim.g.terminal_color_5 = "#f5c2e7"
  vim.g.terminal_color_6 = "#94e2d5"
  vim.g.terminal_color_7 = "#bac2de"
  vim.g.terminal_color_8 = "#585b70"
  vim.g.terminal_color_9 = "#f38ba8"
  vim.g.terminal_color_10 = "#a6e3a1"
  vim.g.terminal_color_11 = "#f9e2af"
  vim.g.terminal_color_12 = "#89b4fa"
  vim.g.terminal_color_13 = "#f5c2e7"
  vim.g.terminal_color_14 = "#94e2d5"
  vim.g.terminal_color_15 = "#a6adc8"
end

vim.cmd([[colorscheme catppuccin]])
