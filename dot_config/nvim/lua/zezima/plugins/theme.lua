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
  term_colors = true,
  transparent_background = true,
  integrations = {
    telescope = true,
    dashboard = true,
    blink_cmp = true,
    dropbar = {
      enabled = true,
      color_mode = true,
    },
    gitsigns = true,
    grug_far = true,
    harpoon = true,
    leap = true,
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
    rainbow_delimiters = true,
    semantic_tokens = false,
    snacks = true,
    treesitter = true,
    treesitter_context = true,
    ts_rainbow2 = true,
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

vim.cmd.colorscheme("catppuccin-mocha")
