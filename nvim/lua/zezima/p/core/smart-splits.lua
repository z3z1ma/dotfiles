return {
  {
    "mrjones2014/smart-splits.nvim",
    event = { "VeryLazy" },
    opts = {
      ignored_filetypes = { "Neotree", "Outline", "Starter" },
      at_edge = "split",
      multiplexer_integration = "tmux",
      resize_mode = {
        hooks = {
          on_leave = require("bufresize").register,
        },
      },
    },
  },
}
