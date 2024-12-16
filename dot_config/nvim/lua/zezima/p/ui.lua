return {
  {
    "folke/edgy.nvim",
    opts = {
      keys = {
        -- increase width
        ["<A-l>"] = function(win)
          win:resize("width", 2)
        end,
        -- decrease width
        ["<A-h>"] = function(win)
          win:resize("width", -2)
        end,
        -- increase height
        ["<A-k>"] = function(win)
          win:resize("height", 2)
        end,
        -- decrease height
        ["<A-j>"] = function(win)
          win:resize("height", -2)
        end,
      },
    },
  },

  {
    "cameron-wags/rainbow_csv.nvim",
    opts = {},
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
    cmd = {
      "RainbowDelim",
      "RainbowDelimSimple",
      "RainbowDelimQuoted",
      "RainbowMultiDelim",
    },
  },

  -- Repo: https://github.com/HiPhish/rainbow-delimiters.nvim
  -- Description: Rainbow delimiters for Neovim with Tree-sitter
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({
        strategy = {
          -- ...
        },
        query = {
          -- ...
        },
        highlight = {
          -- ...
        },
      })
    end,
  },
}
