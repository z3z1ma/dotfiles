-- Metadata
-- languages: python
-- url: https://github.com/ambv/black

local fs = require("util.fs")

local formatter = "black"
local command = string.format("%s --no-color -q -", fs.executable(formatter))

return {
  formatCommand = command,
  formatStdin = true,
}
