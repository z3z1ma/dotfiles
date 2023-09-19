local M = {
  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false, auto_refresh = true, auto_trigger = true },
      panel = { enabled = false, auto_refresh = true },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  -- https://github.com/jackMort/ChatGPT.nvim
  -- open chatgpt interface
  {
    "jackMort/ChatGPT.nvim",
    version = false,
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = vim.fn.expand("~/.openai-key")
      })
    end,
    keys = {
      { "<leader>ac", "<cmd>ChatGPT<cr>",                       mode = "n",                     desc = "ChatGPT" },
      { "<leader>ae", "<cmd>ChatGPTEditWithInstruction<CR>",    desc = "Edit with instruction", mode = { "n", "v" } },
      { "<leader>ag", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction",    mode = { "n", "v" } },
      { "<leader>at", "<cmd>ChatGPTRun translate<CR>",          desc = "Translate",             mode = { "n", "v" } },
      { "<leader>ak", "<cmd>ChatGPTRun keywords<CR>",           desc = "Keywords",              mode = { "n", "v" } },
      { "<leader>ad", "<cmd>ChatGPTRun docstring<CR>",          desc = "Docstring",             mode = { "n", "v" } },
      { "<leader>aa", "<cmd>ChatGPTRun add_tests<CR>",          desc = "Add Tests",             mode = { "n", "v" } },
      { "<leader>ao", "<cmd>ChatGPTRun optimize_code<CR>",      desc = "Optimize Code",         mode = { "n", "v" } },
      { "<leader>as", "<cmd>ChatGPTRun summarize<CR>",          desc = "Summarize",             mode = { "n", "v" } },
      { "<leader>af", "<cmd>ChatGPTRun fix_bugs<CR>",           desc = "Fix Bugs",              mode = { "n", "v" } },
      { "<leader>ax", "<cmd>ChatGPTRun explain_code<CR>",       desc = "Explain Code",          mode = { "n", "v" } },
      { "<leader>ar", "<cmd>ChatGPTRun roxygen_edit<CR>",       desc = "Roxygen Edit",          mode = { "n", "v" } },
      {
        "<leader>al",
        "<cmd>ChatGPTRun code_readability_analysis<CR>",
        desc = "Code Readability Analysis",
        mode = { "n", "v" },
      },
    },
  },
}

return M
