-- Repo: https://github.com/stevearc/aerial.nvim
-- Description: Neovim plugin for a code outline window
return {
  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    opts = function()
      local const = require("zezima.constants")

      local icons = vim.deepcopy(const.icons.kinds)
      icons.lua = { Package = icons.Control }

      local opts = {
        attach_mode = "global",
        backends = { "lsp", "treesitter", "markdown", "man" },
        show_guides = true,
        manage_folds = true,
        link_folds_to_tree = true,
        layout = {
          resize_to_content = false,
          min_width = 28,
          win_opts = {
            winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
            signcolumn = "yes",
            statuscolumn = " ",
          },
        },
        open_automatic = true,
        icons = icons,
        filter_kind = {
          _ = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Package",
            "Property",
            "Struct",
            "Trait",
          },
          markdown = false,
          help = false,
          -- you can specify a different filter for each filetype
          lua = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            -- "Package", -- remove package since luals uses it for control flow structures
            "Property",
            "Struct",
            "Trait",
          },
        },
        -- stylua: ignore
        guides = {
          mid_item   = "├╴",
          last_item  = "└╴",
          nested_top = "│ ",
          whitespace = "  ",
        },
      }
      return opts
    end,
    keys = {
      { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
    },
  },
}
