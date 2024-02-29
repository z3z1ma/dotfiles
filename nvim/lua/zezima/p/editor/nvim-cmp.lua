-- Repo: https://github.com/hrsh7th/nvim-cmp
-- Description: A completion plugin for neovim coded in Lua.

return {
  ---@diagnostic disable: missing-fields
  {
    "z3z1ma/nvim-cmp",
    version = false, -- Latest commit
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      "FelipeLema/cmp-async-path",
      { "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } },
      {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua" },
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require("copilot_cmp")
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          require("zezima.utils").lsp.on_attach(function(client)
            if client.name == "copilot" then
              copilot_cmp._on_insert_enter({})
            end
          end)
        end,
      },
    },
    init = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    end,
    opts = function()
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()

      -- Prioritize copilot suggestions
      defaults.sorting.priority_weight = 2
      table.insert(defaults.sorting.comparators, 1, require("copilot_cmp.comparators").prioritize)

      return {
        completion = {
          completeopt = "menu,menuone,noselect,preview",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            if cmp.visible() then
              cmp.abort()
            else
              fallback()
            end
          end,
        }),
        sources = {
          { name = "copilot", group_index = 2, priority = 100 },
          { name = "nvim_lsp", group_index = 2, keyword_length = 2 },
          { name = "buffer", keyword_length = 3, group_index = 2 },
          { name = "luasnip", group_index = 2 },
          { name = "async_path", group_index = 2 },
          { name = "emoji", group_index = 2 },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
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
    config = function(_, opts)
      local cmp = require("cmp")
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end

      -- Editor completion
      cmp.setup(opts)

      -- Search completion
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      -- Command-line completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } } },
          { { name = "async_path" } }
        ),
      })

      -- Autopairs on completion confirm
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
