-- Repo: https://github.com/dstein64/vim-startuptime
-- Description: A plugin for profiling Vim and Neovim startup time.
return {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
