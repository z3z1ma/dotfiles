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
        show_guides = true,
        manage_folds = true,
        link_folds_to_tree = true,
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
        layout = {
          resize_to_content = false,
          min_width = 32,
          win_opts = {
            winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
            signcolumn = "yes",
            statuscolumn = " ",
          },
        },
        highlight_on_jump = false,
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
          lua = false,
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
