vim.pack.add({
  {
    src = "https://github.com/mrjones2014/smart-splits.nvim",
    version = "1ac316e6ea719843fd80716d1105613c98632af1",
  },
})

local smart_splits = require("smart-splits")

smart_splits.setup({
  ignored_filetypes = { "Neotree", "Outline", "MiniStarter" },
  at_edge = "split",
  multiplexer_integration = "tmux",
})
