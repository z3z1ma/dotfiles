-- Repo: https://github.com/nvim-neo-tree/neo-tree.nvim
-- Description: Neovim plugin to manage the file system and other tree like structures.
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    sources = {
      "filesystem",
      "buffers",
      "git_status",
    },
    source_selector = {
      winbar = false, -- toggle to show selector on winbar
      content_layout = "start",
      tabs_layout = "center",
      sources = {
        { source = "filesystem", display_name = "󰉓 Tree" },
        { source = "buffers", display_name = "󰈙 Bufs" },
        { source = "git_status", display_name = " Git" },
      },
      highlight_tab = "NeoTreeTabInactive",
      highlight_tab_active = "NeoTreeTabActive",
      highlight_background = "NeoTreeTabInactive",
      highlight_separator = "NeoTreeTabInactive",
      highlight_separator_active = "NeoTreeTabActive",
    },
  },
}
