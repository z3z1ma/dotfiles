local ls =
  "eza --color=always --icons=always --long --no-permissions --no-filesize --no-user --no-time --tree --level=2 ."
return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      sections = {
        { section = "header" },
        { section = "terminal", cmd = "quote", height = 5 },
        { section = "keys", padding = 1 },
        { section = "recent_files", icon = " ", title = "Recent Files", indent = 2, padding = { 2, 2 } },
        { section = "projects", icon = " ", title = "Projects", indent = 2, padding = 2 },
        { section = "startup" },
        { section = "terminal", icon = " ", title = "Calendar", cmd = "cal -A1", pane = 2, height = 7, padding = 2 },
        { section = "terminal", icon = " ", cmd = ls, pane = 2, height = 30, padding = 4, indent = 4 },
      },
    },
  },
}
