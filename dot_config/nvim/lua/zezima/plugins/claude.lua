vim.pack.add({
  {
    src = "https://github.com/coder/claudecode.nvim",
    version = "main",
  },
})

local claude = require("claudecode")

claude.setup({
  opts = {
    focus_after_send = true,
    terminal = {
      provider = "none", -- no UI actions; server + tools remain available
    },
  },
})

-- NOTE: we are using tmux...
-- vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })

vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
vim.keymap.set("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
vim.keymap.set("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select Claude model" })
vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer" })
vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })
vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", { desc = "Add file" }) -- NOTE: verify this works in snack picker tree
-- Diff management
vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })

local _t = require("claudecode.terminal")
_t.open = function() end ---@diagnostic disable-line: duplicate-set-field
_t.ensure_visible = function() end ---@diagnostic disable-line: duplicate-set-field
