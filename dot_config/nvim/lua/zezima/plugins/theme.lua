vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
    version = "main",
  },
})

local catppuccin = require("catppuccin")

---@diagnostic disable-next-line: missing-fields
catppuccin.setup({
  integrations = {
    aerial = true,
    alpha = false,
    cmp = true,
    dashboard = false,
    flash = true,
    fzf = false,
    grug_far = true,
    gitsigns = true,
    headlines = false,
    illuminate = true,
    indent_blankline = { enabled = false },
    leap = true,
    lsp_trouble = true,
    mason = true,
    markdown = true,
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
