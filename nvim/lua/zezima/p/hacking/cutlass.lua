-- Repo: https://github.com/gbprod/cutlass.nvim
-- Description: Plugin that adds a 'cut' operation separate from 'delete'
return {
  "gbprod/cutlass.nvim",
  opts = {
    cut_key = "c",
    exclude = { "ns", "nS" },
  },
}
