return {
  {
    "catppuccin/nvim",
    opts = {
      integrations = {
        blink_cmp = true,
        dropbar = {
          enabled = true,
          color_mode = true,
        },
        harpoon = true,
        octo = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        dadbod_ui = true,
        snacks = true,
      },
    },
  },

  -- Repo: https://github.com/projekt0n/github-nvim-theme
  -- Description: Github's Neovim themes
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    opts = {
      options = {
        styles = {
          comments = "italic",
          conditionals = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    },
  },

  -- Repo: https://github.com/rebelot/kanagawa.nvim
  -- Description: A port of the Material Theme for (Neo)vim
  {
    "rebelot/kanagawa.nvim",
    opts = {
      compile = true,
      terminalColors = true,
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          TSRainbowRed = { fg = colors.palette.autumnRed },
          TSRainbowYellow = { fg = colors.palette.carpYellow },
          TSRainbowBlue = { fg = colors.palette.dragonBlue },
          TSRainbowOrange = { fg = colors.palette.surimiOrange },
          TSRainbowGreen = { fg = colors.palette.springGreen },
          TSRainbowViolet = { fg = colors.palette.oniViolet },
          TSRainbowCyan = { fg = colors.palette.waveAqua1 },
        }
      end,
    },
  },
}
