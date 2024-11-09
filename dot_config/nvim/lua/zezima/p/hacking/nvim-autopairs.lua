-- Repo: https://github.com/windwp/nvim-autopairs
-- Description: autopairs for neovim written by lua
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup({
      disable_filetype = { "scheme" },
    })
    local Rule = require("nvim-autopairs.rule")
    npairs.add_rule(Rule("$$", "$$", "sql"))
    npairs.add_rule(Rule("`", "`", "sql"))
  end,
}
