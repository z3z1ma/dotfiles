-- Metadata
-- languages: python
-- url: https://github.com/ambv/black

local fs = require("util.fs")

local formatter = "sqlfmt"
local command = string.format("%s --no-color -q -l 120 -", fs.executable(formatter))

return {
  formatCommand = command,
  formatStdin = true,
}
