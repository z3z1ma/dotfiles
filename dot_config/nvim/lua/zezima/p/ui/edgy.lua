return {
  "folke/edgy.nvim",
  opts = {
    keys = {
      -- increase width
      ["<A-l>"] = function(win)
        win:resize("width", 2)
      end,
      -- decrease width
      ["<A-h>"] = function(win)
        win:resize("width", -2)
      end,
      -- increase height
      ["<A-k>"] = function(win)
        win:resize("height", 2)
      end,
      -- decrease height
      ["<A-j>"] = function(win)
        win:resize("height", -2)
      end,
    },
  },
}
