-- Repo: https://github.com/catppuccin/nvim
-- Description: 🍨 Soothing pastel theme for (Neo)vim

-- Gruvbox-ified Catppuccin (optional injection via color_overrides)
local gruvcat = {
  latte = {
    rosewater = "#c14a4a",
    flamingo = "#c14a4a",
    red = "#c14a4a",
    maroon = "#c14a4a",
    pink = "#945e80",
    mauve = "#945e80",
    peach = "#c35e0a",
    yellow = "#b47109",
    green = "#6c782e",
    teal = "#4c7a5d",
    sky = "#4c7a5d",
    sapphire = "#4c7a5d",
    blue = "#45707a",
    lavender = "#45707a",
    text = "#654735",
    subtext1 = "#73503c",
    subtext0 = "#805942",
    overlay2 = "#8c6249",
    overlay1 = "#8c856d",
    overlay0 = "#a69d81",
    surface2 = "#bfb695",
    surface1 = "#d1c7a3",
    surface0 = "#e3dec3",
    base = "#f9f5d7",
    mantle = "#f0ebce",
    crust = "#e8e3c8",
  },
  mocha = {
    rosewater = "#ea6962",
    flamingo = "#ea6962",
    red = "#ea6962",
    maroon = "#ea6962",
    pink = "#d3869b",
    mauve = "#d3869b",
    peach = "#e78a4e",
    yellow = "#d8a657",
    green = "#a9b665",
    teal = "#89b482",
    sky = "#89b482",
    sapphire = "#89b482",
    blue = "#7daea3",
    lavender = "#7daea3",
    text = "#ebdbb2",
    subtext1 = "#d5c4a1",
    subtext0 = "#bdae93",
    overlay2 = "#a89984",
    overlay1 = "#928374",
    overlay0 = "#595959",
    surface2 = "#4d4d4d",
    surface1 = "#404040",
    surface0 = "#292929",
    base = "#1d2021",
    mantle = "#191b1c",
    crust = "#141617",
  },
}

return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 10000,
    version = false,
    name = "catppuccin",
    keys = {
      -- A user command
      { "<leader>T", "<cmd>CatppuccinTransparency<cr>", desc = "Toggle transparency" },
    },
    opts = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")
      assert(mocha, "Mocha palette not found")
      return {
        flavour = z3.styles.transparent and "mocha" or "macchiato",
        transparent_background = z3.styles.transparent,
        styles = {
          keywords = { "italic" },
          booleans = { "italic" },
          properties = { "italic" },
        },
        integrations = {
          aerial = true,
          bufferline = true,
          dap = { enabled = true, enable_ui = true },
          dashboard = true,
          cmp = true,
          flash = true,
          gitsigns = true,
          harpoon = true,
          illuminate = { enabled = true, lsp = true },
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
          semantic_tokens = true,
          telescope = { enabled = true, style = z3.styles.transparent and nil or "nvchad" },
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
        color_overrides = gruvcat,
        custom_highlights = function(colors)
          local ucolors = require("catppuccin.utils.colors")
          local lazy = {}
          local mini = {}
          local ui = {}
          local cmp = {}
          local bufferline = {}
          local tree = {}
          local telescope = {}
          lazy.LazyH1 = {
            bg = z3.styles.transparent and colors.none or colors.peach,
            fg = z3.styles.transparent and colors.lavender or colors.base,
            style = { "bold" },
          }
          lazy.LazyButton = {
            bg = colors.none,
            fg = z3.styles.transparent and colors.overlay0 or colors.subtext0,
          }
          lazy.LazyButtonActive = {
            bg = z3.styles.transparent and colors.none or colors.overlay1,
            fg = z3.styles.transparent and colors.lavender or colors.base,
            style = { " bold" },
          }
          lazy.LazySpecial = { fg = colors.sapphire }
          mini.MiniIndentscopeSymbol = { fg = colors.overlay0 }
          cmp.CmpItemAbbrDeprecated = { fg = colors.overlay1, bg = "NONE", strikethrough = true }
          cmp.CmpItemAbbrMatch = { fg = colors.blue, bg = "NONE", bold = true }
          cmp.CmpItemAbbrMatchFuzzy = { fg = colors.blue, bg = "NONE", bold = true }
          cmp.CmpItemMenu = { fg = colors.pink, bg = "NONE", italic = true }
          bufferline.BufferLineIndicatorSelected = { fg = colors.pink }
          bufferline.BufferLineIndicator = { fg = colors.base }
          tree.NeoTreeRootName = { fg = colors.pink, style = { "bold", "italic" } }
          tree.NeoTreeGitAdded = { fg = colors.green, style = { "italic" } }
          tree.NeoTreeGitConflict = { fg = colors.red, style = { "italic" } }
          tree.NeoTreeGitDeleted = { fg = colors.red, style = { "italic" } }
          tree.NeoTreeGitIgnored = { fg = colors.overlay0, style = { "italic" } }
          tree.NeoTreeGitModified = { fg = colors.yellow, style = { "italic" } }
          tree.NeoTreeGitUnstaged = { fg = colors.red, style = { "italic" } }
          tree.NeoTreeGitUntracked = { fg = colors.mauve, style = { "italic" } }
          tree.NeoTreeGitStaged = { fg = colors.green, style = { "italic" } }
          telescope.TelescopeMatching = { fg = colors.green }
          if not z3.styles.transparent then
            telescope.TelescopeBorder = { fg = colors.blue }
            telescope.TelescopeSelectionCaret = { fg = colors.flamingo }
            telescope.TelescopeSelection = { fg = colors.text, bg = colors.surface0, style = { "bold" } }
            telescope.TelescopeMatching = { fg = colors.blue }
            telescope.TelescopePromptPrefix = { fg = colors.yellow, bg = colors.crust }
            telescope.TelescopePromptNormal = { bg = colors.crust }
            telescope.TelescopeResultsNormal = { bg = colors.mantle }
            telescope.TelescopePreviewNormal = { bg = colors.crust }
            telescope.TelescopePromptBorder = { bg = colors.crust, fg = colors.crust }
            telescope.TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle }
            telescope.TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust }
            telescope.TelescopePromptTitle = { fg = colors.crust, bg = colors.mauve }
            telescope.TelescopeResultsTitle = { fg = colors.crust, bg = colors.mauve }
            telescope.TelescopePreviewTitle = { fg = colors.crust, bg = colors.mauve }
            ui.LspInlayHint = { bg = colors.mantle }
          end
          ui.FloatBorder = {
            fg = z3.styles.transparent and colors.blue or colors.mantle,
            bg = z3.styles.transparent and colors.none or colors.mantle,
          }
          ui.FloatTitle = {
            fg = z3.styles.transparent and colors.lavender or colors.base,
            bg = z3.styles.transparent and colors.none or colors.lavender,
          }
          ui.PanelHeading = {
            fg = colors.lavender,
            bg = z3.styles.transparent and colors.none or colors.crust,
            style = { "bold", "italic" },
          }
          ui.TabLineSel = { bg = colors.pink }
          ui.Folded = { bg = colors.mantle }
          ui.CursorLine = { bg = colors.mantle }
          ui.Visual = { bg = ucolors.darken("#9745be", 0.25, mocha.mantle), style = { "italic" } }
          ui.MatchParen = { fg = colors.base, bg = ucolors.darken(colors.red, 0.65, mocha.rosewater) }
          ui["@function.builtin"] = { fg = colors.flamingo }
          ui.Pmenu = { bg = z3.styles.transparent and colors.none or colors.mantle }
          ui.PmenuSel =
            { fg = colors.base, bg = z3.styles.transparent and colors.none or colors.maroon, style = { "bold" } }
          return vim.tbl_extend("force", lazy, mini, ui, cmp, bufferline, tree, telescope)
        end,
      }
    end,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
      vim.cmd.highlight({ "Comment", "cterm=italic", "gui=italic" })
      z3.styles.palettes = require("catppuccin.palettes").get_palette()
    end,
  },
}
