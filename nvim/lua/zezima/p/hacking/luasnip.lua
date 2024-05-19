-- Repo: https://github.com/L3MON4D3/LuaSnip
-- Description: Snippet Engine for Neovim written in Lua.
return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        -- require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
      end,
    },
    opts = function()
      local types = require("luasnip.util.types")
      return {
        history = true,
        delete_check_events = "TextChanged",
        -- Display a cursor-like placeholder in unvisited nodes
        -- of the snippet.
        ext_opts = {
          [types.insertNode] = {
            unvisited = {
              virt_text = { { "|", "Conceal" } },
              virt_text_pos = "inline",
            },
          },
          [types.exitNode] = {
            unvisited = {
              virt_text = { { "|", "Conceal" } },
              virt_text_pos = "inline",
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local luasnip = require("luasnip")

      luasnip.setup(opts)

      -- Use <C-c> to select a choice in a snippet.
      vim.keymap.set({ "i", "s" }, "<C-c>", function()
        if luasnip.choice_active() then
          require("luasnip.extras.select_choice")()
        end
      end, { desc = "Select choice" })

      vim.api.nvim_create_autocmd("ModeChanged", {
        group = vim.api.nvim_create_augroup("z3z1ma/unlink_snippet", { clear = true }),
        desc = "Cancel the snippet session when leaving insert mode",
        pattern = { "s:n", "i:*" },
        callback = function(args)
          if
            luasnip.session
            and luasnip.session.current_nodes[args.buf]
            and not luasnip.session.jump_active
            and not luasnip.choice_active()
          then
            luasnip.unlink_current()
          end
        end,
      })
    end,
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<s-tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },
}
