-- Repo: https://github.com/echasnovski/mini.surround
-- Description: Neovim Lua plugin with fast and feature-rich surround actions. Part of 'mini.nvim' library.
return {
  -- Fast and feature-rich surround actions. For text that includes
  -- surrounding characters like brackets or quotes, this allows you
  -- to select the text inside, change or modify the surrounding characters,
  -- and more.
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gza", -- add surrounding in Normal and Visual modes
        delete = "gzd", -- delete surrounding
        find = "gzf", -- find surrounding (to the right)
        find_left = "gzF", -- find surrounding (to the left)
        highlight = "gzh", -- highlight surrounding
        replace = "gzr", -- replace surrounding
        update_n_lines = "gzn", -- update `n_lines`
      },
    },
  },
}
