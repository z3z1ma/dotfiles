-- Repo: https://github.com/michaelb/sniprun
-- Description: A neovim plugin to run lines/blocs of code (independently of the rest of the file), supporting multiples languages
return {
  {
    "michaelb/sniprun",
    version = "*",
    build = "sh install.sh",
    cmd = { "SnipRun" },
    config = function()
      require("sniprun").setup({
        display = { "Terminal" },
      })
    end,
  }
}
