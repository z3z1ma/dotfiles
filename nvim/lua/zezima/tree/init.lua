local Z = require("zezima.utils")
local Icons = require("zezima.constants").icons

local config = {
  close_if_last_window = true,
  open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
  sources = {
    "filesystem",
    "buffers",
    "git_status",
    "diagnostics",
  },
  use_popups_for_input = false,
  popup_border_style = "single",
  source_selector = {
    winbar = true, -- toggle to show selector on winbar
    content_layout = "start",
    tabs_layout = "center",
    sources = {
      { source = "filesystem", display_name = "󰉓 Tree" },
      { source = "buffers", display_name = "󰈙 Bufs" },
      { source = "git_status", display_name = " Git" },
      { source = "diagnostics", display_name = "󰒡 LSP" },
    },
    highlight_tab = "NeoTreeTabInactive",
    highlight_tab_active = "NeoTreeTabActive",
    highlight_background = "NeoTreeTabInactive",
    highlight_separator = "NeoTreeTabInactive",
    highlight_separator_active = "NeoTreeTabActive",
  },
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      with_expanders = true,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      folder_empty_open = "",
      default = " ",
    },
    modified = { symbol = "" },
    git_status = { symbols = Icons.git },
    diagnostics = { symbols = Icons.diagnostics },
  },
  window = {
    width = 40,
    mappings = {
      ["<1-LeftMouse>"] = "open",
      ["l"] = "open",
      ["h"] = "close_node",
    },
  },
  filesystem = {
    bind_to_cwd = true,
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        [","] = "toggle_hidden",
        ["."] = "set_root",
        ["/"] = "fuzzy_finder",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["a"] = { "add", config = { show_path = "relative" } }, -- "none", "relative", "absolute"
      },
    },
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    follow_current_file = {
      enabled = true,
    },
    group_empty_dirs = true,
  },
  async_directory_scan = "always",
}

config.filesystem.components = require("zezima.tree.sources.filesystem.components")

return config
