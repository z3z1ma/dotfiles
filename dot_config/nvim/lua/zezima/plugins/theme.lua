vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
    version = "main",
  },
})

require("zezima.plugins.bufferline")

local catppuccin = require("catppuccin")

---@diagnostic disable-next-line: missing-fields
catppuccin.setup({
  integrations = {
    aerial = true,
    alpha = false,
    bufferline = true,
    cmp = true,
    dashboard = false,
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
