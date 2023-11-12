-- Repo: https://github.com/catppuccin/nvim
-- Description: 🍨 Soothing pastel theme for (Neo)vim
return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 10000,
    name = "catppuccin",
    keys = {
      -- A user command in
      { "<leader>uT", "<cmd>CatppuccinTransparency<cr>", desc = "Toggle transparency" },
    },
    opts = {
      transparent_background = true,
      integrations = {
        aerial = true,
        dap = { enabled = true, enable_ui = true },
        dashboard = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        harpoon = true,
        illuminate = { enabled = true, lsp = true },
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        markdown = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
          inlay_hints = {
            background = true,
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        symbols_outline = true,
        telescope = { enabled = true },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    cond = true,
  },
}
