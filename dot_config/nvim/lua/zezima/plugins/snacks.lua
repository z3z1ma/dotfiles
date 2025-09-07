vim.pack.add({
  {
    src = "https://github.com/folke/snacks.nvim",
    version = "bc0630e43be5699bb94dadc302c0d21615421d93",
  },
})

local Z = require("zezima.utils")

local day_ascii = {
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

local snacks = require("snacks")

-- NOTE: copied from chezmoi plugin
local pick_chezmoi = function()
  local results = require("chezmoi.commands").list({
    args = {
      "--path-style",
      "absolute",
      "--include",
      "files",
      "--exclude",
      "externals",
    },
  })
  local items = {}

  for _, czFile in ipairs(results) do
    table.insert(items, {
      text = czFile,
      file = czFile,
    })
  end

  ---@type snacks.picker.Config
  local opts = {
    items = items,
    confirm = function(picker, item)
      picker:close()
      require("chezmoi.commands").edit({
        targets = { item.text },
        args = { "--watch" },
      })
    end,
  }
  Snacks.picker.pick(opts)
end

snacks.setup({
  dashboard = {
    enabled = true,
    sections = {
      { section = "header" },
      { section = "terminal", cmd = "quote | fold -sw 60", height = 5, ttl = 5 },
      { section = "keys", padding = 1 },
      { section = "recent_files", icon = " ", title = "Recent Files", indent = 2, padding = { 2, 2 } },
      { section = "projects", icon = " ", title = "Projects", indent = 2, padding = 2 },
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
        {
          icon = " ",
          key = "s",
          desc = "Restore Session",
          enabled = package.loaded.persistence,
          action = ":lua require('persistence').load()",
        },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
      header = day_ascii[os.date("%A")],
    },
  },
  zen = { enabled = true },
  picker = {
    sources = {
      explorer = {
        actions = {
          send_to_claude = function(picker)
            ---@type string[]
            local paths = vim.tbl_map(Snacks.picker.util.path, picker:selected({ fallback = true }))
            if #paths == 0 then
              return
            end
            for _, path in ipairs(paths) do
            end
          end,
        },
        win = {
          list = {
            keys = {
              ["O"] = "send_to_claude",
            },
          },
        },
      },
    },
  },
})

-- stylua: ignore start
vim.keymap.set("", "<leader>z", function() Snacks.zen() end, { desc = "Toggle zen mode" })
vim.keymap.set("", "<leader>Z", function() Snacks.zen.zoom() end, { desc = "Toggle zoom" })
-- tree
vim.keymap.set("", "<leader>fe", function() Snacks.explorer({ cwd = Z.get_root() }) end, { desc = "Explorer Snacks (root dir)" })
vim.keymap.set("", "<leader>fE", function() Snacks.explorer({ cwd = Z.get_root() }) end, { desc = "Explorer Snacks (root dir)" })
vim.keymap.set("", "<leader>e", function() Snacks.explorer({ cwd = Z.get_root() }) end, { desc = "Explorer Snacks (root dir)" })
vim.keymap.set("", "<leader>E", function() Snacks.explorer({ cwd = Z.get_root() }) end, { desc = "Explorer Snacks (root dir)" })
-- find
vim.keymap.set("", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("", "<leader>/", function() Snacks.picker.grep({ cwd = Z.get_root() }) end, { desc = "Grep (Root Dir)" })
vim.keymap.set("", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set( "", "<leader><space>", function() Snacks.picker.files({ cwd = Z.get_root() }) end, { desc = "Find Files (Root Dir)" })
vim.keymap.set("", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
vim.keymap.set("", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("", "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, { desc = "Buffers (all)" })
vim.keymap.set("", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })
vim.keymap.set("", "<leader>ff", function() Snacks.picker.files({ cwd = Z.get_root() }) end, { desc = "Find Files (Root Dir)" })
vim.keymap.set("", "<leader>fF", function() Snacks.picker.files({ root = false }) end, { desc = "Find Files (cwd)" })
vim.keymap.set("", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Files (git-files)" })
vim.keymap.set("", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
vim.keymap.set("", "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true } }) end, { desc = "Recent (cwd)" })
vim.keymap.set("", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
-- git
vim.keymap.set("", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (hunks)" })
vim.keymap.set("", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
vim.keymap.set("", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
-- grep
vim.keymap.set("", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
vim.keymap.set("", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
vim.keymap.set("", "<leader>sg", function() Snacks.picker.grep({ cwd = Z.get_root() }) end, { desc = "Grep (Root Dir)" })
vim.keymap.set("", "<leader>sG", function() Snacks.picker.grep({ root = false }) end, { desc = "Grep (cwd)" })
vim.keymap.set("", "<leader>sp", function() Snacks.picker.lazy() end, { desc = "Search for Plugin Spec" })
vim.keymap.set({"n", "x"}, "<leader>sw", function() Snacks.picker.grep_word({ cwd = Z.get_root() }) end, { desc = "Visual selection or word (Root Dir)" })
vim.keymap.set({"n", "x"}, "<leader>sW", function() Snacks.picker.grep_word({ root = false }) end, { desc = "Visual selection or word (cwd)" })
-- search
vim.keymap.set("", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
vim.keymap.set("", "<leader>s/", function() Snacks.picker.search_history() end, { desc = "Search History" })
vim.keymap.set("", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
vim.keymap.set("", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
vim.keymap.set("", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
vim.keymap.set("", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
vim.keymap.set("", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
vim.keymap.set("", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
vim.keymap.set("", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
vim.keymap.set("", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set("", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
vim.keymap.set("", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
vim.keymap.set("", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
vim.keymap.set("", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
vim.keymap.set("", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
vim.keymap.set("", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undotree" })
-- ui
vim.keymap.set("", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
-- stylua: ignore end

Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle
  .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" })
  :map("<leader>uc")
Snacks.toggle
  .option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
  :map("<leader>uA")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.profiler():map("<leader>dpp")
Snacks.toggle.profiler_highlights():map("<leader>dph")
