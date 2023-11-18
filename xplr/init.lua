version = "0.21.3" ---@diagnostic disable-line: lowercase-global

local home = os.getenv("HOME")
package.path = home .. "/.config/xplr/plugins/?/init.lua;" .. home .. "/.config/xplr/plugins/?.lua;" .. package.path

require("icons").setup()

require("fzf").setup({
  mode = "default",
  key = "ctrl-f",
  bin = "fzf",
  args = "--preview 'pistol {}'",
  recursive = false, -- If true, search all files under $PWD
  enter_dir = false, -- Enter if the result is directory
})

require("tri-pane").setup({
  layout_key = "T", -- In switch_layout mode
  as_default_layout = true,
  left_pane_width = { Percentage = 20 },
  middle_pane_width = { Percentage = 50 },
  right_pane_width = { Percentage = 30 },
})

local map = require("map")
map.setup({
  mode = "default", -- or `xplr.config.modes.builtin.default`
  key = "M",
  editor = os.getenv("EDITOR") or "vim",
  editor_key = "ctrl-o",
  prefer_multi_map = false,
  placeholder = "{}",
  spacer = "{_}",
  custom_placeholders = map.placeholders,
})

xplr.config.modes.builtin.default.key_bindings.on_key["e"] = {
  help = "Edit in Neovim",
  messages = {
    {
      BashExec = 'if [ -d "$XPLR_FOCUS_PATH" ]; then nvim; elif [ -f "$XPLR_FOCUS_PATH" ]; then nvim "$XPLR_FOCUS_PATH"; fi',
    },
  },
}
