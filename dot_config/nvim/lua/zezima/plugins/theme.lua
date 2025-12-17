vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
    version = "main",
  },
  {
    src = "https://github.com/rebelot/kanagawa.nvim",
    version = "master",
  },
  {
    src = "https://github.com/nyoom-engineering/oxocarbon.nvim",
    version = "main",
  },
  {
    src = "https://github.com/p00f/alabaster.nvim",
    version = "main",
  },
  {
    src = "https://github.com/rasulomaroff/reactive.nvim",
    version = "e0a22a42811ca1e7aa7531f931c55619aad68b5d",
  },
})

local catppuccin = require("catppuccin")
local C = require("catppuccin.palettes").get_palette()

---@diagnostic disable-next-line: missing-fields
catppuccin.setup({
  term_colors = true,
  transparent_background = true,
  custom_highlights = {
    MiniTrailspace = { bg = C.maroon },
  },
  integrations = {
    -- Kept enabled despite telescope not being installed - highlight groups are referenced by other plugins
    telescope = true,
    dashboard = true,
    blink_cmp = true,
    gitsigns = true,
    grug_far = true,
    harpoon = true,
    harpoon2 = true,
    leap = true,
    markdown = true,
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
    rainbow_delimiters = true,
    semantic_tokens = false,
    snacks = true,
    treesitter = true,
    treesitter_context = true,
  },
})

local function set_common_hl_groups()
  vim.api.nvim_set_hl(0, "@keyword", { italic = true })
  vim.api.nvim_set_hl(0, "@keyword.function", { italic = true })
end

local function setup_catppuccin()
  local reactive = require("reactive")
  reactive.setup({
    load = { "catppuccin-mocha-cursorline" },
  })

  vim.g.loaded_reactive = true

  require("reactive.commands"):init()

  vim.api.nvim_create_user_command("CatppuccinTransparency", function()
    catppuccin.options.transparent_background = not catppuccin.options.transparent_background
    catppuccin.compile()
    vim.cmd.colorscheme(vim.g.colors_name)
  end, { desc = "Toggle transparency" })

  vim.cmd.colorscheme("catppuccin-mocha")

  set_common_hl_groups()
end

local function setup_oxocarbon()
  vim.opt.background = "dark"
  vim.cmd.colorscheme("oxocarbon")

  vim.api.nvim_create_user_command("OxocarbonTransparency", function()
    -- TODO: verify background color
    local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
    if normal_bg == nil then
      vim.api.nvim_set_hl(0, "Normal", { bg = "#161616" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#161616" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "#161616" })
    else
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    end
  end, { desc = "Toggle transparency" })

  set_common_hl_groups()
end

local function setup_kanagawa()
  vim.cmd.colorscheme("kanagawa")
  set_common_hl_groups()
end

local function setup_alabaster()
  vim.opt.background = "dark"
  vim.cmd.colorscheme("alabaster")
  set_common_hl_groups()
end

setup_catppuccin()

return {
  catppuccin = setup_catppuccin,
  oxocarbon = setup_oxocarbon,
  kanagawa = setup_kanagawa,
  alabaster = setup_alabaster,
}
