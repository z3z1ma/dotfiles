local jit_windows = not jit.os:find("Windows")
return {
  {
    "Saghen/blink.cmp",
    enabled = true,
  },

  -- Repo: https://github.com/Olical/conjure
  -- Description: Interactive evaluation for Neovim (Clojure, Fennel, Janet, Racket, Hy, MIT Scheme, Guile, Python and more!)
  {
    "Olical/conjure",
    ft = { "scheme" },
    dependencies = {
      {
        "PaterJason/cmp-conjure",
        config = function()
          local cmp = require("cmp")
          local config = cmp.get_config()
          table.insert(config.sources, {
            name = "buffer",
            option = {
              sources = {
                { name = "conjure" },
              },
            },
          })
          cmp.setup(config)
        end,
      },
    },
    config = function(_, opts)
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
    init = function()
      vim.g["conjure#debug"] = false
      vim.g["conjure#client#scheme#stdio#command"] = "racket -l sicp --repl"
      vim.g["conjure#client#scheme#stdio#prompt_pattern"] = '\n?["%w%-./_]*> '
    end,
  },

  -- Repo: https://github.com/echasnovski/mini.pairs
  -- Description: Neovim Lua plugin to automatically manage character pairs. Part of 'mini.nvim' library.
  {
    "echasnovski/mini.pairs",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "scheme",
        },
        callback = function()
          vim.b.minipairs_disable = true
        end,
      })
    end,
  },

  -- Repo: https://github.com/chrisgrieser/nvim-spider
  -- Description: Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
  {
    "gpanders/nvim-parinfer",
    ft = { "scheme" },
  },

  -- Repo: https://github.com/chrisgrieser/nvim-spider
  -- Description: Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    enabled = false,
  },

  -- Repo: https://github.com/gpanders/nvim-parinfer
  -- Description: parinfer for Neovim
  {
    "gpanders/nvim-parinfer",
    ft = { "scheme" },
  },

  -- Repo: https://github.com/gbprod/yanky.nvim
  -- Description: Improved Yank and Put functionalities for Neovim
  {
    "gbprod/yanky.nvim",
    lazy = true,
    dependencies = { { "kkharji/sqlite.lua", enabled = jit_windows } },
    opts = {
      highlight = { timer = 250 },
      ring = { storage = jit_windows and "shada" or "sqlite" },
    },
  },

  -- FIX: remove the init from dadbod completion since it hardcodes nvim-cmp in a weird way
  {
    "kristijanhusak/vim-dadbod-completion",
    init = function() end,
  },
}
