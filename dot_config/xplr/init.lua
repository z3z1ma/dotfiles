version = "0.21.3" ---@diagnostic disable-line: lowercase-global

local home = os.getenv("HOME")
package.path = home
  .. "/.config/xplr/plugins/?/init.lua;"
  .. home
  .. "/.config/xplr/plugins/?.lua;"
  .. home
  .. "/.config/xplr/plugins/xpm/?.lua;"
  .. package.path

require("xpm").setup({
  plugins = {
    "dtomvan/xpm.xplr",
    "Junker/nuke.xplr",
    {
      "sayanarijit/fzf.xplr",
      setup = function()
        require("fzf").setup({
          mode = "default",
          key = "ctrl-f",
          bin = "fzf",
          args = "--preview 'pistol {}'",
          recursive = true, -- If true, search all files under $PWD
          enter_dir = true, -- Enter if the result is directory
        })
      end,
    },
    {
      "sayanarijit/tri-pane.xplr",
      setup = function()
        require("tri-pane").setup({
          layout_key = "T", -- In switch_layout mode
          as_default_layout = true,
          left_pane_width = { Percentage = 20 },
          middle_pane_width = { Percentage = 50 },
          right_pane_width = { Percentage = 30 },
        })
      end,
      after = function()
        local render_right_pane = xplr.fn.custom.tri_pane.render_right_pane
        xplr.fn.custom.tri_pane.render_right_pane = function(ctx)
          local n = ctx.app.focused_node
          if n and n.is_file then
            return xplr.util.shell_execute("pistol", { n.absolute_path }).stdout
          end
          return render_right_pane(ctx)
        end
      end,
    },
    {
      "sayanarijit/map.xplr",
      setup = function()
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
      end,
    },
    "gitlab:hartan/web-devicons.xplr",
  },
  auto_install = true,
  auto_cleanup = true,
})

xplr.config.modes.builtin.default.key_bindings.on_key["e"] = {
  help = "Edit in Neovim",
  messages = {
    {
      BashExec = 'if [ -d "$XPLR_FOCUS_PATH" ]; then nvim; elif [ -f "$XPLR_FOCUS_PATH" ]; then nvim "$XPLR_FOCUS_PATH"; fi',
    },
  },
}
