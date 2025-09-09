vim.pack.add({
  {
    src = "https://github.com/ggandor/leap.nvim",
    version = "c4a215acef90749851d85ddba08bc282867b50eb",
  },
  {
    src = "https://github.com/ggandor/flit.nvim",
    version = "513e38abe61237c53a9e983e45595b1d2e7d5391",
  },
})

require("zezima.plugins.mini") -- Dependency: use mini.clue to set key descriptions

local leap = require("leap")
leap.add_default_mappings(true)
vim.keymap.del({ "x", "o" }, "x")
vim.keymap.del({ "x", "o" }, "X")

local flit = require("flit")
flit.setup({})

for _, mode in ipairs({ "n", "x", "o" }) do
  MiniClue.set_mapping_desc(mode, "s", "Leap Forward to")
  MiniClue.set_mapping_desc(mode, "S", "Leap Backward to")
  MiniClue.set_mapping_desc(mode, "gs", "Leap from Windows")
end
