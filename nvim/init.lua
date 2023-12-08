-- Leader
vim.g.mapleader = " " -- Change leader key to space
vim.g.maplocalleader = "\\" -- Change local leader key to backslash

-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local namespace = {
  styles = {
    transparent = false,
    icons = {
      git = {
        git = "",
        added = "",
        modified = "",
        deleted = "",
        renamed = "",
        ignored = "",
        untracked = "",
        unstaged = "",
        staged = "",
        megred = "",
        conflict = "",
        branch = "",
      },
      dap = {
        debug = "",
        signs = {
          breakpoint = "󰄛", -- md
          stopped = "󰋇", -- md
        },
        controls = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          restart = "",
          stop = "",
          disconnect = "",
        },
      },
      diagnostics = {
        error = "",
        warn = "",
        info = "",
        hint = "",
      },
      documents = {
        collapsed = "",
        expanded = "",
        new_file = "",
        file = "",
        files = "",
        file_symlink = "",
        folder = "󰉋", -- md
        folder_open = "󰝰", -- md
        root_folder = "",
        folder_symlink = "",
        empty_folder = "󰉖", -- md
        empty_folder_open = "󰷏", -- md
        modified = "",
        close = "",
      },
      todo = {
        fix = "",
        todo = "",
        hack = "",
        warn = "",
        perf = "",
        note = "",
        test = "",
      },
      indent = {
        dash = "┊",
        solid = "│",
        last = "└",
      },
      plugin = {
        plugin = "",
        installed = "",
        uninstalled = "",
        pedding = "",
      },
      navigation = {
        indicator = "▎",
        breadcrumb = "",
        triangle_left = "",
        triangle_right = "",
        arrows = "",
        left_half_circle_thick = "",
        right_half_circle_thick = "",
      },
      misc = {
        flash = "󰉂",
        code = "",
        buffer = "",
        treesitter = "",
        telescope = "",
        fish = "󰈺", -- md
        creation = "󰙴", --md
        search = "",
        star = "",
        history = "",
        vim = "",
        exit = "",
        ellipsis = "",
        snow = "",
        palette = "",
        pulse = "",
        lazy = "󰒲 ",
        milestone = "",
        terminal = "",
        key = "",
        setting = "",
        task = "",
        markdown = "",
        clock = "",
        option = "󰘵",
        spinners = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" },
        scrollbar = {
          "██",
          "▇▇",
          "▆▆",
          "▅▅",
          "▄▄",
          "▃▃",
          "▂▂",
          "▁▁",
          "  ",
        },
      },
      lsp = {
        lsp = "",
        kinds = {
          text = "",
          method = "",
          ["function"] = "",
          constructor = "",
          field = "",
          variable = "",
          class = "",
          interface = "",
          module = "", --
          property = "",
          unit = "", --
          value = "", --
          enum = "",
          keyword = "",
          snippet = "",
          color = "",
          file = "", --
          reference = "",
          folder = "", --
          enummember = "",
          constant = "",
          struct = "",
          event = "",
          operator = "",
          typeparameter = "",
          namespace = "",
          package = "?",
          string = "",
          number = "",
          boolean = "",
          array = "",
          object = "?",
          key = "?",
          null = "?",
          codeium = "󰘦",
        },
      },
    },
    palettes = {},
  },
}

_G.z3 = z3 or namespace
z3.styles.border = z3.styles.transparent and "rounded" or "none"

-- Configure lazy
require("lazy").setup({
  { import = "zezima.p.ui" },
  { import = "zezima.p.ai" },
  { import = "zezima.p.git" },
  { import = "zezima.p.editor" },
  { import = "zezima.p.hacking" },
  { import = "zezima.p.testing" },
  { import = "zezima.p.core" },
  { import = "zezima.p.theme" },
  { import = "zezima.p.productivity" },
}, {
  defaults = {
    lazy = false,
    version = false,
  },
  diff = {
    cmd = "diffview.nvim",
  },
  install = { colorscheme = { "catppuccin" }, missing = true },
  checker = { enabled = true, notify = false },
  change_detection = { enabled = false },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  debug = false,
})
