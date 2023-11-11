-- Repo: https://github.com/mfussenegger/nvim-dap
-- Description: Debug Adapter Protocol client implementation for Neovim
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Repo: https://github.com/theHamsta/nvim-dap-virtual-text
      -- Description: This plugin adds virtual text support to nvim-dap. nvim-treesitter is used to find variable definitions.
      "theHamsta/nvim-dap-virtual-text",

      -- Repo: https://github.com/jay-babu/mason-nvim-dap.nvim
      -- Description: Provide extra convenience APIs such as the :DapInstall command, allow you to (i) automatically install, and (ii) automatically set up a predefined list of adapters, translate between dap adapter names and mason.nvim package names (e.g. python <-> debugpy)
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
          "mfussenegger/nvim-dap",
          "williamboman/mason.nvim",
        },
        opts = {
          automatic_installation = true,
          handlers = nil,
          ensure_installed = {
            "python",
          },
        },
      },

      -- Repo: https://github.com/mfussenegger/nvim-dap-python
      -- Description: An extension for nvim-dap, providing default configurations for python and methods to debug individual test methods or classes.
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
          local venv_path = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
          require("dap-python").setup(debugpy_path, {
            include_configs = true,
            pythonPath = venv_path and (venv_path .. "/bin/python") or nil, -- defer to dap-python if no venv
          })
        end,
      },
    },
    -- stylua: ignore start
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ") end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
    -- stylua: ignore end
    config = function()
      local Config = require("zezima.constants")
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        ---@cast sign table<string>
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
    end,
  },
  -- Add which-key hints for dap
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>d"] = { name = "+debug" },
        ["<leader>da"] = { name = "+adapters" },
      },
    },
  },
}
