-- Repo: https://github.com/hrsh7th/nvim-cmp
-- Description: A completion plugin for neovim coded in Lua.
return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- Latest commit
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "saadparwaiz1/cmp_luasnip",
      { "zbirenbaum/copilot-cmp", config = true, dependencies = { "copilot.lua" } },
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require "cmp"
      local defaults = require "cmp.config.default"()
      table.insert(defaults.sorting.comparators, 1, require("copilot_cmp.comparators").prioritize)
      return {
        completion = {
          completeopt = "menu,menuone,noinsert,noselect,preview",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert {
          ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping {
            i = cmp.mapping.confirm { select = false },
            s = cmp.mapping.confirm { select = true },
            c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
          },
          ["<S-Tab>"] = cmp.mapping(cmp.mapping(function(fallback)
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if not entry then
                cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
              end
              cmp.confirm()
            else
              fallback()
            end
          end, { "i", "s", "c" })),
        }, -- this simplifies quick completions while preserving normal editor behavior for enter/tab in insert mode
        sources = cmp.config.sources {
          { name = "copilot", group_index = 2 },
          { name = "nvim_lsp", group_index = 2 },
          { name = "buffer", group_index = 2 },
          { name = "path", group_index = 2 },
          { name = "luasnip", group_index = 2 },
        },
        formatting = {
          format = function(_, item)
            local icons = require("zezima.constants").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
  },
}
