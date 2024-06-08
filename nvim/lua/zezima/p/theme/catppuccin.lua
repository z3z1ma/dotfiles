-- Repo: https://github.com/catppuccin/nvim
-- Description: 🍨 Soothing pastel theme for (Neo)vim
return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
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
        telescope = { enabled = true, style = "nvchad" },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    })
  end,
}
