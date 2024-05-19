-- Repo: https://github.com/zbirenbaum/copilot.lua
-- Description: Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    dependencies = { "hrsh7th/nvim-cmp" },
    opts = {
      panel = { enabled = false },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = false,
          accept_word = "<M-w>",
          accept_line = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "/",
        },
      },
      filetypes = { markdown = true },
    },
    config = function(_, opts)
      local cmp = require("cmp")
      local copilot = require("copilot.suggestion")
      local luasnip = require("luasnip")
      -- Setup Copilot with the provided options.
      require("copilot").setup(opts)
      ---@param trigger boolean
      local function set_trigger(trigger)
        if not trigger and copilot.is_visible() then
          copilot.dismiss()
        end
        vim.b.copilot_suggestion_auto_trigger = trigger
        vim.b.copilot_suggestion_hidden = not trigger
      end
      -- Hide suggestions when the completion menu is open.
      cmp.event:on("menu_opened", function()
        set_trigger(false)
      end)
      cmp.event:on("menu_closed", function()
        if not luasnip.expand_or_locally_jumpable() then
          set_trigger(true)
          require("copilot.suggestion").next()
        end
      end)
      -- Disable Copilot inside snippets.
      vim.api.nvim_create_autocmd("User", {
        desc = "Disable Copilot inside snippets",
        pattern = { "LuasnipInsertNodeEnter", "LuasnipInsertNodeLeave" },
        callback = function()
          set_trigger(not luasnip.expand_or_locally_jumpable())
        end,
      })
    end,
  },
}
