-- Repo: https://github.com/catppuccin/nvim
-- Description: 🍨 Soothing pastel theme for (Neo)vim
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true,
      show_end_of_buffer = false,
      integration_default = true,
      integrations = {
        aerial = true,
        dap = true,
        dap_ui = true,
        dropbar = { enabled = true },
        cmp = true,
        fidget = true,
        flash = true,
        gitsigns = true,
        harpoon = true,
        illuminate = { enabled = true, lsp = true }, ---@diagnostic disable-line
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
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        octo = true,
        semantic_tokens = true,
        telescope = { enabled = true, style = z3.styles.transparent and nil or "nvchad" },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    })
    vim.cmd.colorscheme("catppuccin-macchiato")
    z3.styles.palettes = require("catppuccin.palettes").get_palette()
    vim.cmd.highlight({ "Comment", "cterm=italic", "gui=italic" })
  end,
}
