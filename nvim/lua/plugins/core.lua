require("config").init()

return {
  -- lazy can manage itself
  { "folke/lazy.nvim",               version = "*" },

  -- tmux integration, navigate from vim window to tmux pane and  back
  { "christoomey/vim-tmux-navigator" },

  -- primary theme, calming pastel colors
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 10000,
    name = "catppuccin",
    config = function(_, opts)
      require("config").setup()
      require("catppuccin").setup(opts)
    end,
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
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
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
    cond = true,
  },

  -- transparent background, a personal favorite
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    keys = {
      { "<leader>ut", "<cmd>TransparentToggle<cr>", desc = "Toggle transparency" },
    },
  },

  -- theme remiscent of vscode days
  { "Mofiqul/vscode.nvim", lazy = true, name = "vscode" },
}
