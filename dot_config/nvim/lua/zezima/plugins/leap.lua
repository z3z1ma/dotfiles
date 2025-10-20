vim.pack.add({
  {
    src = "https://github.com/ggandor/leap.nvim",
    version = "7068a0576694efb72798696de65155d503bcb0ef",
  },
})

require("zezima.plugins.mini") -- Dependency: use mini.clue to set key descriptions

local leap = require("leap")
leap.add_default_mappings(true)
vim.keymap.del({ "x", "o" }, "x")
vim.keymap.del({ "x", "o" }, "X")

local labeled_modes = "v"

local function as_ft(key_specific_args)
  local mode = vim.fn.mode(1)
  local safe_labels = nil
  if
    mode:match("n") and not labeled_modes:match("n")
    or mode:match("^[vV]$") and not labeled_modes:match("[vx]")
    or mode:match("o") and not labeled_modes:match("o")
  then
    safe_labels = ""
  end

  local common_args = {
    inputlen = 1,
    inclusive = true,
    pattern = nil,
    opts = {
      labels = "",
      safe_labels = safe_labels,
      case_sensitive = true,
    },
  }

  return vim.tbl_deep_extend("keep", common_args, key_specific_args)
end

local clever = require("leap.user").with_traversal_keys

local clever_f = clever("f", "F")
local clever_t = clever("t", "T")

for key, args in pairs({
  ["f"] = { opts = clever_f },
  ["F"] = { backward = true, opts = clever_f },
  ["t"] = { offset = -1, opts = clever_t },
  ["T"] = { backward = true, offset = 1, opts = clever_t },
}) do
  vim.keymap.set({ "n", "x", "o" }, key, function()
    leap.leap(as_ft(args))
  end)
end

for _, mode in ipairs({ "n", "x", "o" }) do
  MiniClue.set_mapping_desc(mode, "s", "Leap Forward to")
  MiniClue.set_mapping_desc(mode, "S", "Leap Backward to")
  MiniClue.set_mapping_desc(mode, "gs", "Leap from Windows")
end
