-- Repo: https://github.com/mfussenegger/nvim-dap
-- Description: Debug Adapter Protocol client implementation for Neovim
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- Repo: https://github.com/rcarriga/nvim-dap-ui
    -- Description: A UI for nvim-dap
    {
      "rcarriga/nvim-dap-ui",
      keys = {
        { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
      },
      opts = {},
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },
    -- Repo: https://github.com/theHamsta/nvim-dap-virtual-text
    -- Description: This plugin adds virtual text support to nvim-dap. nvim-treesitter is used to find variable definitions.
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    -- WhichKey
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        defaults = {
          ["<leader>d"] = { name = "+debug" },
          ["<leader>da"] = { name = "+adapters" },
        },
      },
    },
    -- Repo: https://github.com/jay-babu/mason-nvim-dap.nvim
    -- Description: Provide extra convenience APIs such as the :DapInstall command, allow you to (i) automatically install, and (ii) automatically set up a predefined list of adapters, translate between dap adapter names and mason.nvim package names (e.g. python <-> debugpy)
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          "python"
        },
      },
    },
  },
  keys = {
    {
      "<leader>dB",
      function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
      desc = "Breakpoint Condition"
    },
    {
      "<leader>db",
      function() require("dap").toggle_breakpoint() end,
      desc = "Toggle Breakpoint"
    },
    {
      "<leader>dc",
      function() require("dap").continue() end,
      desc = "Continue"
    },
    {
      "<leader>dC",
      function() require("dap").run_to_cursor() end,
      desc = "Run to Cursor"
    },
    {
      "<leader>dg",
      function() require("dap").goto_() end,
      desc = "Go to line (no execute)"
    },
    {
      "<leader>di",
      function() require("dap").step_into() end,
      desc = "Step Into"
    },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end,   desc = "Up" },
    {
      "<leader>dl",
      function() require("dap").run_last() end,
      desc = "Run Last"
    },
    {
      "<leader>do",
      function() require("dap").step_out() end,
      desc = "Step Out"
    },
    {
      "<leader>dO",
      function() require("dap").step_over() end,
      desc = "Step Over"
    },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    {
      "<leader>dr",
      function() require("dap").repl.toggle() end,
      desc = "Toggle REPL"
    },
    {
      "<leader>ds",
      function() require("dap").session() end,
      desc = "Session"
    },
    {
      "<leader>dt",
      function() require("dap").terminate() end,
      desc = "Terminate"
    },
    {
      "<leader>dw",
      function() require("dap.ui.widgets").hover() end,
      desc = "Widgets"
    },
  },
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
}
