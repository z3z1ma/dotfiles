-- Repo: https://github.com/Olical/conjure
-- Description: Interactive evaluation for Neovim (Clojure, Fennel, Janet, Racket, Hy, MIT Scheme, Guile, Python and more!)
return {
  "Olical/conjure",
  ft = { "scheme", "python" },
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
}
