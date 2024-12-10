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
}
