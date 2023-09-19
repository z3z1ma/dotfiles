-- Metadata
-- languages: go
-- url: https://pkg.go.dev/cmd/gofmt

local fs = require("util.fs")
local formatter = fs.executable("gofmt")

return {
  formatCommand = formatter,
  formatStdin = true,
}
