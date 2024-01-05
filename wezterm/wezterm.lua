local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Gruvbox dark, pale (base16)"

config.font = wezterm.font("JetBrains Mono")
config.font_size = 13.0

config.enable_tab_bar = false

config.front_end = "WebGpu"
config.max_fps = 120
config.webgpu_power_preference = "HighPerformance"

config.window_background_opacity = 0.875
config.macos_window_background_blur = 10
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.set_environment_variables = {
  TERM = "wezterm",
  PATH = os.getenv("PATH"),
  EDITOR = "nvim",
  VISUAL = "nvim",
  PAGER = "less",
  MANPAGER = "nvim +Man!",
  CLICOLOR = "1",
  LSCOLORS = "ExFxBxDxCxegedabagacad",
  XDG_CONFIG_HOME = wezterm.home_dir .. "/.config",
  XDG_CACHE_HOME = wezterm.home_dir .. "/.cache",
  XDG_DATA_HOME = wezterm.home_dir .. "/.local/share",
}

config.term = "wezterm"

config.audible_bell = "Disabled"
config.initial_cols = 300
config.initial_rows = 100

config.default_prog = { "bash", "-lic", "tmux new -As0" }
config.window_close_confirmation = "NeverPrompt"

config.keys = {
  { key = "0", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[48;5u" }) },
  { key = "1", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[49;5u" }) },
  { key = "2", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[50;5u" }) },
  { key = "3", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[51;5u" }) },
  { key = "4", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[52;5u" }) },
  { key = "5", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[53;5u" }) },
  { key = "6", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[54;5u" }) },
  { key = "7", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[55;5u" }) },
  { key = "8", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[56;5u" }) },
  { key = "9", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[57;5u" }) },
  { key = "Return", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[13;5u" }) },
}

return config
