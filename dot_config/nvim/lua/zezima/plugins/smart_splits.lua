vim.pack.add({
  {
    src = "https://github.com/mrjones2014/smart-splits.nvim",
    version = "v2.0.5",
  },
})

local smart_splits = require("smart-splits")

smart_splits.setup({
  ignored_filetypes = { "Neotree", "Outline", "MiniStarter" },
  at_edge = "split",
  multiplexer_integration = "tmux",
})

if not vim.g.vscode then
  -- Move to window using the <ctrl> hjkl keys (with Tmux support)
  vim.keymap.set("n", "<A-h>", function()
    require("smart-splits").resize_left()
  end)
  vim.keymap.set("n", "<A-j>", function()
    require("smart-splits").resize_down()
  end)
  vim.keymap.set("n", "<A-k>", function()
    require("smart-splits").resize_up()
  end)
  vim.keymap.set("n", "<A-l>", function()
    require("smart-splits").resize_right()
  end)
  -- moving between splits
  vim.keymap.set("n", "<C-h>", function()
    require("smart-splits").move_cursor_left()
  end)
  vim.keymap.set("n", "<C-j>", function()
    require("smart-splits").move_cursor_down()
  end)
  vim.keymap.set("n", "<C-k>", function()
    require("smart-splits").move_cursor_up()
  end)
  vim.keymap.set("n", "<C-l>", function()
    require("smart-splits").move_cursor_right()
  end)
  -- swapping buffers between windows
  vim.keymap.set("n", "<leader><C-h>", function()
    require("smart-splits").swap_buf_left()
  end)
  vim.keymap.set("n", "<leader><C-j>", function()
    require("smart-splits").swap_buf_down()
  end)
  vim.keymap.set("n", "<leader><C-k>", function()
    require("smart-splits").swap_buf_up()
  end)
  vim.keymap.set("n", "<leader><C-l>", function()
    require("smart-splits").swap_buf_right()
  end)
end
