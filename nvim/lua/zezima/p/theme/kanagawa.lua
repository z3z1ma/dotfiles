-- Repo: https://github.commarko-cerovac/material.nvim/
-- Description: A port of the Material Theme for (Neo)vim
return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    opts = {
      compile = true,
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Popup menu
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          -- Telescope
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          -- Upstream treesitter changes
          ["@string.regexp"] = { link = "@string.regex" },
          ["@variable.parameter"] = { link = "@parameter" },
          ["@exception"] = { link = "@exception" },
          ["@string.special.symbol"] = { link = "@symbol" },
          ["@markup.strong"] = { link = "@text.strong" },
          ["@markup.italic"] = { link = "@text.emphasis" },
          ["@markup.heading"] = { link = "@text.title" },
          ["@markup.raw"] = { link = "@text.literal" },
          ["@markup.quote"] = { link = "@text.quote" },
          ["@markup.math"] = { link = "@text.math" },
          ["@markup.environment"] = { link = "@text.environment" },
          ["@markup.environment.name"] = { link = "@text.environment.name" },
          ["@markup.link.url"] = { link = "Special" },
          ["@markup.link.label"] = { link = "Identifier" },
          ["@comment.note"] = { link = "@text.note" },
          ["@comment.warning"] = { link = "@text.warning" },
          ["@comment.danger"] = { link = "@text.danger" },
          ["@diff.plus"] = { link = "@text.diff.add" },
          ["@diff.minus"] = { link = "@text.diff.delete" },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      -- vim.cmd("colorscheme kanagawa")
    end,
  },
}
