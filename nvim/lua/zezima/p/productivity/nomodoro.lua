-- Repo: https://github.com/dbinagi/nomodoro
-- Description: Pomodoro time tracker for NeoVim written entirely in LUA
return {
  {
    "dbinagi/nomodoro",
    keys = {
      { "<leader>ps", "<Cmd>NomoWork<CR>", desc = "Start Pomodoro Focus" },
      { "<leader>pb", "<Cmd>NomoBreak<CR>", desc = "Start Pomodoro Break" },
      { "<leader>pe", "<Cmd>NomoStop<CR>", desc = "Stop Pomodoro" },
    },
    opts = {
      work_time = 25,
      break_time = 5,
      menu_available = true,
      texts = {
        on_break_complete = "TIME IS UP!",
        on_work_complete = "TIME IS UP!",
        status_icon = "🍅 ",
        timer_format = "!%0M:%0S", -- To include hours: '!%0H:%0M:%0S'
      },
      on_work_complete = function() end,
      on_break_complete = function() end,
    },
  },
  -- Add which-key support for chatgpt
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>p"] = { name = "+pomodoro" },
      },
    },
  },
}
