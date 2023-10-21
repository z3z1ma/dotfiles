-- Metadata
-- languages: nix
-- url: https://github.com/serokell/nixfmt

local fs = require("zezima.fs")

local formatter = "nixfmt"
local command = string.format("%s", fs.executable(formatter))
return {
  formatCommand = command,
  formatStdin = true,
  rootMarkers = {
    "flake.nix",
    "shell.nix",
    "default.nix",
  },
}
