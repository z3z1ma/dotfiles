-- Repo: https://github.com/catppuccin/nvim
-- Description: 🍨 Soothing pastel theme for (Neo)vim
local gruvboxify = false
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
      {
        "<leader>uG",
        function()
          gruvboxify = not gruvboxify
        end,
        desc = "Toggle gruvboxify",
      },
    },
    opts = function()
      -- local ucolors = require("catppuccin.utils.colors")
      local mocha = require("catppuccin.palettes").get_palette("mocha")
      local include = {}
      if gruvboxify or os.getenv("GRUVCAT") then
        include.color_overrides = {
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
      end
      return vim.tbl_extend("force", include, {
        flavour = z3.styles.transparent and "mocha" or "macchiato",
        transparent_background = z3.styles.transparent,
        styles = {
          keywords = { "italic" },
          variables = { "italic" },
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
        custom_highlights = function(colors)
          local ucolors = require("catppuccin.utils.colors")
          local telescope_results = colors.base
          local telescope_prompt = "#302D41" -- black3 from original palette
          local fg = colors.surface2
          local inject = {}
          if z3.styles.transparent then
            inject = {
              TelescopePromptCounter = { fg = fg },
              TelescopePromptPrefix = { fg = colors.green, bg = telescope_prompt },
              TelescopePromptTitle = { fg = telescope_prompt, bg = colors.green },
              TelescopePreviewTitle = { fg = telescope_prompt, bg = colors.maroon },
              TelescopeResultsTitle = { fg = telescope_results, bg = telescope_results },
              TelescopeMatching = { fg = colors.green },
            }
          else
            inject = {
              TelescopeBorder = { fg = colors.blue },
              TelescopeSelectionCaret = { fg = colors.flamingo },
              TelescopeSelection = { fg = colors.text, bg = colors.surface0, style = { "bold" } },
              TelescopeMatching = { fg = colors.blue },
              TelescopePromptPrefix = { fg = colors.yellow, bg = colors.crust },
              TelescopePromptNormal = { bg = colors.crust },
              TelescopeResultsNormal = { bg = colors.mantle },
              TelescopePreviewNormal = { bg = colors.crust },
              TelescopePromptBorder = { bg = colors.crust, fg = colors.crust },
              TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
              TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
              TelescopePromptTitle = { fg = colors.crust, bg = colors.mauve },
              TelescopeResultsTitle = { fg = colors.crust, bg = colors.mauve },
              TelescopePreviewTitle = { fg = colors.crust, bg = colors.mauve },
              LspInlayHint = { bg = colors.mantle },
            }
          end
          return vim.tbl_extend("keep", inject, {
            PanelHeading = {
              fg = colors.lavender,
              bg = z3.styles.transparent and colors.none or colors.crust,
              style = { "bold", "italic" },
            },

            LazyH1 = {
              bg = z3.styles.transparent and colors.none or colors.peach,
              fg = z3.styles.transparent and colors.lavender or colors.base,
              style = { "bold" },
            },
            LazyButton = {
              bg = colors.none,
              fg = z3.styles.transparent and colors.overlay0 or colors.subtext0,
            },
            LazyButtonActive = {
              bg = z3.styles.transparent and colors.none or colors.overlay1,
              fg = z3.styles.transparent and colors.lavender or colors.base,
              style = { " bold" },
            },
            LazySpecial = { fg = colors.sapphire },

            MiniIndentscopeSymbol = { fg = colors.overlay0 },

            FloatBorder = {
              fg = z3.styles.transparent and colors.blue or colors.mantle,
              bg = z3.styles.transparent and colors.none or colors.mantle,
            },
            FloatTitle = {
              fg = z3.styles.transparent and colors.lavender or colors.base,
              bg = z3.styles.transparent and colors.none or colors.lavender,
            },

            ["@function.builtin"] = { fg = colors.flamingo },

            Pmenu = { bg = z3.styles.transparent and colors.none or colors.mantle },
            PmenuSel = {
              fg = colors.base,
              bg = z3.styles.transparent and colors.none or colors.maroon,
              style = { "bold" },
            },

            CmpItemAbbrDeprecated = { fg = colors.overlay1, bg = "NONE", strikethrough = true },
            CmpItemAbbrMatch = { fg = colors.blue, bg = "NONE", bold = true },
            CmpItemAbbrMatchFuzzy = { fg = colors.blue, bg = "NONE", bold = true },
            CmpItemMenu = { fg = colors.pink, bg = "NONE", italic = true },

            BufferLineIndicatorSelected = { fg = colors.pink },
            BufferLineIndicator = { fg = colors.base },
            TabLineSel = { bg = colors.pink },
            CursorLine = { bg = colors.mantle },
            Folded = { bg = colors.mantle },

            MatchParen = { fg = colors.base, bg = ucolors.darken(colors.red, 0.65, mocha.rosewater) },

            NeoTreeRootName = { fg = colors.pink, style = { "bold", "italic" } },
            NeoTreeGitAdded = { fg = colors.green, style = { "italic" } },
            NeoTreeGitConflict = { fg = colors.red, style = { "italic" } },
            NeoTreeGitDeleted = { fg = colors.red, style = { "italic" } },
            NeoTreeGitIgnored = { fg = colors.overlay0, style = { "italic" } },
            NeoTreeGitModified = { fg = colors.yellow, style = { "italic" } },
            NeoTreeGitUnstaged = { fg = colors.red, style = { "italic" } },
            NeoTreeGitUntracked = { fg = colors.mauve, style = { "italic" } },
            NeoTreeGitStaged = { fg = colors.green, style = { "italic" } },

            Visual = { bg = ucolors.darken("#9745be", 0.25, mocha.mantle), style = { "italic" } },
          })
        end,
      })
    end,
    cond = true,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
      vim.cmd.highlight({ "Comment", "cterm=italic", "gui=italic" })
      z3.styles.palettes = require("catppuccin.palettes").get_palette()
    end,
  },
}

-- Gruvbox Catppuccin
-- color_overrides = {
--   latte = {
--     rosewater = "#c14a4a",
--     flamingo = "#c14a4a",
--     red = "#c14a4a",
--     maroon = "#c14a4a",
--     pink = "#945e80",
--     mauve = "#945e80",
--     peach = "#c35e0a",
--     yellow = "#b47109",
--     green = "#6c782e",
--     teal = "#4c7a5d",
--     sky = "#4c7a5d",
--     sapphire = "#4c7a5d",
--     blue = "#45707a",
--     lavender = "#45707a",
--     text = "#654735",
--     subtext1 = "#73503c",
--     subtext0 = "#805942",
--     overlay2 = "#8c6249",
--     overlay1 = "#8c856d",
--     overlay0 = "#a69d81",
--     surface2 = "#bfb695",
--     surface1 = "#d1c7a3",
--     surface0 = "#e3dec3",
--     base = "#f9f5d7",
--     mantle = "#f0ebce",
--     crust = "#e8e3c8",
--   },
--   mocha = {
--     rosewater = "#ea6962",
--     flamingo = "#ea6962",
--     red = "#ea6962",
--     maroon = "#ea6962",
--     pink = "#d3869b",
--     mauve = "#d3869b",
--     peach = "#e78a4e",
--     yellow = "#d8a657",
--     green = "#a9b665",
--     teal = "#89b482",
--     sky = "#89b482",
--     sapphire = "#89b482",
--     blue = "#7daea3",
--     lavender = "#7daea3",
--     text = "#ebdbb2",
--     subtext1 = "#d5c4a1",
--     subtext0 = "#bdae93",
--     overlay2 = "#a89984",
--     overlay1 = "#928374",
--     overlay0 = "#595959",
--     surface2 = "#4d4d4d",
--     surface1 = "#404040",
--     surface0 = "#292929",
--     base = "#1d2021",
--     mantle = "#191b1c",
--     crust = "#141617",
--   },
-- },
