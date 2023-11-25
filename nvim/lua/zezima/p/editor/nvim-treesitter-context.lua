-- Repo: https://github.com/nvim-treesitter/nvim-treesitter-context
-- Description: Show code context as a sticky header
return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { mode = "cursor", max_lines = 3 },
    keys = {
      {
        "<leader>ut",
        function()
          local tsc = require("treesitter-context")
          tsc.toggle()
          if Z.get_upvalue(tsc.toggle, "enabled") then
            Z.info("Enabled Treesitter Context", { title = "Option" })
          else
            Z.warn("Disabled Treesitter Context", { title = "Option" })
          end
        end,
        desc = "Toggle Treesitter Context",
      },
      {
        "[c",
        function()
          -- Jump to previous change when in diffview.
          if vim.wo.diff then
            return "[c"
          else
            vim.schedule(function()
              require("treesitter-context").go_to_context()
            end)
            return "<Ignore>"
          end
        end,
        desc = "Jump to upper context",
        expr = true,
      },
    },
  },
}
