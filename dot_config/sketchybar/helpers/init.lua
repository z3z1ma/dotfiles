local home = os.getenv("HOME")
local config_dir = os.getenv("CONFIG_DIR") or (home .. "/.config/sketchybar")

-- Add the sketchybar module to the package cpath
package.cpath = package.cpath .. ";" .. home .. "/.local/share/sketchybar_lua/?.so"

os.execute("(cd \"" .. config_dir .. "/helpers\" && make)")
