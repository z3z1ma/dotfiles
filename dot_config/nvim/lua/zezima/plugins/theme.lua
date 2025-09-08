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
    aerial = true,
    alpha = false,
    blink_cmp = true,
    bufferline = true,
    cmp = true,
    dashboard = false,
    dropbar = {
      enabled = true,
      color_mode = true,
    },
    flash = true,
    fzf = false,
    gitsigns = true,
    grug_far = true,
    headlines = false,
    illuminate = true,
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
    treesitter = true,
    treesitter_context = true,
    which_key = false,
  },
})

local bufferline_hl = require("bufferline.highlights")
---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
bufferline_hl.set_all({ highlights = require("catppuccin.groups.integrations.bufferline").get_theme() })

local reactive = require("reactive")
reactive.setup({
  load = { "catppuccin-mocha-cursorline" },
})

vim.api.nvim_create_user_command("CatppuccinTransparency", function()
  catppuccin.options.transparent_background = not catppuccin.options.transparent_background
  catppuccin.compile()
  vim.cmd.colorscheme(vim.g.colors_name)
end, { desc = "Toggle transparency" })
