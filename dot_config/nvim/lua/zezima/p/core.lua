local ls =
  "eza --color=always --icons=always --long --no-permissions --no-filesize --no-user --no-time --tree --level=2 ."
local pick_chezmoi = function()
  if LazyVim.pick.picker.name == "telescope" then
    require("telescope").extensions.chezmoi.find_files()
  elseif LazyVim.pick.picker.name == "fzf" then
    local fzf_lua = require("fzf-lua")
    local results = require("chezmoi.commands").list({})
    local chezmoi = require("chezmoi.commands")
    local opts = {
      fzf_opts = {},
      fzf_colors = true,
      actions = {
        ["default"] = function(selected)
          chezmoi.edit({
            targets = { "~/" .. selected[1] },
            args = { "--watch" },
          })
        end,
      },
    }
    fzf_lua.fzf_exec(results, opts)
  end
end
local daysofweek = {
  Monday = [[
███╗   ███╗ ██████╗ ███╗   ██╗██████╗  █████╗ ██╗   ██╗
████╗ ████║██╔═══██╗████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
██╔████╔██║██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝⠀
██║╚██╔╝██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝⠀⠀
██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║⠀⠀⠀
╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
  Tuesday = [[
████████╗██╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗
╚══██╔══╝██║   ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
   ██║   ██║   ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝⠀
   ██║   ██║   ██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝⠀⠀
   ██║   ╚██████╔╝███████╗███████║██████╔╝██║  ██║   ██║⠀⠀⠀
   ╚═╝    ╚═════╝ ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
  Wednesday = [[
██╗    ██╗███████╗██████╗ ███╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗
██║    ██║██╔════╝██╔══██╗████╗  ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
██║ █╗ ██║█████╗  ██║  ██║██╔██╗ ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝⠀
██║███╗██║██╔══╝  ██║  ██║██║╚██╗██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝⠀⠀
╚███╔███╔╝███████╗██████╔╝██║ ╚████║███████╗███████║██████╔╝██║  ██║   ██║⠀⠀⠀
 ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
  Thursday = [[
████████╗██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  █████╗ ██╗   ██╗
╚══██╔══╝██║  ██║██║   ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
   ██║   ███████║██║   ██║██████╔╝███████╗██║  ██║███████║ ╚████╔╝⠀
   ██║   ██╔══██║██║   ██║██╔══██╗╚════██║██║  ██║██╔══██║  ╚██╔╝⠀⠀
   ██║   ██║  ██║╚██████╔╝██║  ██║███████║██████╔╝██║  ██║   ██║⠀⠀⠀
   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
  Friday = [[
███████╗██████╗ ██╗██████╗  █████╗ ██╗   ██╗
██╔════╝██╔══██╗██║██╔══██╗██╔══██╗╚██╗ ██╔╝
█████╗  ██████╔╝██║██║  ██║███████║ ╚████╔╝⠀
██╔══╝  ██╔══██╗██║██║  ██║██╔══██║  ╚██╔╝⠀⠀
██║     ██║  ██║██║██████╔╝██║  ██║   ██║⠀⠀⠀
╚═╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
  Saturday = [[
███████╗ █████╗ ████████╗██╗   ██╗██████╗ ██████╗  █████╗ ██╗   ██╗
██╔════╝██╔══██╗╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝
███████╗███████║   ██║   ██║   ██║██████╔╝██║  ██║███████║ ╚████╔╝⠀
╚════██║██╔══██║   ██║   ██║   ██║██╔══██╗██║  ██║██╔══██║  ╚██╔╝⠀⠀
███████║██║  ██║   ██║   ╚██████╔╝██║  ██║██████╔╝██║  ██║   ██║⠀⠀⠀
╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
  Sunday = [[
███████╗██╗   ██╗███╗   ██╗██████╗  █████╗ ██╗   ██╗
██╔════╝██║   ██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
███████╗██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝⠀
╚════██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝⠀⠀
███████║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║⠀⠀⠀
╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀
  ]],
}
return {
  -- Repo: https://github.com/folke/lazy.nvim
  -- Description: 💤 A modern plugin manager for Neovim
  {
    "folke/lazy.nvim",
    version = "*",
  },

  -- Repo: https://github.com/LazyVim/LazyVim
  -- Description: Neovim config for the lazy
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- Repo: https://github.com/epwalsh/obsidian.nvim
  -- Description: Neovim plugin for Obsidian, written in Lua
  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    version = "*",
    cmd = { "ObsidianToday", "ObsidianYesterday", "ObsidianSearch", "ObsidianWorkspace" },
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/vaults/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/vaults/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      ui = { enable = false },
      new_notes_location = "current_dir",
      notes_subdir = "notes",
      daily_notes = {
        folder = "notes/dailies",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        -- template = "day.md"
      },
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },
      open_notes_in = "current", -- "current", "hsplit" or "vsplit"
      yaml_parser = "yq", -- "native" or "yq"
      sort_by = "modified",
      sort_reversed = true,
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },
    },
  },

  {
    "mrjones2014/smart-splits.nvim",
    event = { "VeryLazy" },
    opts = {
      ignored_filetypes = { "Neotree", "Outline", "MiniStarter" },
      at_edge = "split",
      multiplexer_integration = "tmux",
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          { section = "header" },
          { section = "terminal", cmd = "quote | fold -sw 60", height = 5, ttl = 5 },
          { section = "keys", padding = 1 },
          { section = "recent_files", icon = " ", title = "Recent Files", indent = 2, padding = { 2, 2 } },
          { section = "projects", icon = " ", title = "Projects", indent = 2, padding = 2 },
          { section = "startup" },
        },
        preset = {
          ---@type fun(cmd:string, opts:table)|nil
          pick = nil,
          ---@type snacks.dashboard.Item[]|fun(items:snacks.dashboard.Item[]):snacks.dashboard.Item[]?
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = pick_chezmoi,
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = daysofweek[os.date("%A")],
        },
      },
      zen = { enabled = true },
      picker = {
        sources = {
          explorer = {
            actions = {
              avante_add_files = function(picker)
                ---@type string[]
                local paths = vim.tbl_map(Snacks.picker.util.path, picker:selected({ fallback = true }))
                if #paths == 0 then
                  return
                end
                local sidebar = require("avante").get()
                local open = sidebar:is_open()
                if not open then
                  require("avante.api").ask()
                  sidebar = require("avante").get()
                end
                for _, path in ipairs(paths) do
                  local relative_path = require("avante.utils").relative_path(path)
                  sidebar.file_selector:add_selected_file(relative_path)
                end
              end,
            },
            win = {
              list = {
                keys = {
                  ["O"] = "avante_add_files",
                },
              },
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>Z",
        function()
          Snacks.zen.zoom()
        end,
        desc = "Toggle Zoom",
      },
    },
  },
}
