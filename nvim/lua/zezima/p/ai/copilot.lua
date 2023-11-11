-- Repo: https://github.com/zbirenbaum/copilot.lua
-- Description: Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false, auto_refresh = true, auto_trigger = true },
      panel = { enabled = false, auto_refresh = true },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}
