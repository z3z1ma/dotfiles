local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Gruvbox dark, pale (base16)"

config.font = wezterm.font("JetBrains Mono")
config.font_size = 13.0

config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

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

config.term = "wezterm"

config.audible_bell = "Disabled"
config.initial_cols = 300
config.initial_rows = 100

local tmux = {}
if wezterm.target_triple == "aarch64-apple-darwin" then
  tmux = { wezterm.home_dir .. "/.nix-profile/bin/tmux", "new", "-As0" }
else
  tmux = { "tmux", "new", "-As0" }
end

config.default_prog = tmux
config.window_close_confirmation = "NeverPrompt"

return config
