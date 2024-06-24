-- Repo: https://github.com/hrsh7th/nvim-cmp
-- Description: A completion plugin for neovim coded in Lua.
return {
  ---@diagnostic disable: missing-fields
  {
    "hrsh7th/nvim-cmp",
    version = false, -- Latest commit
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      { "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } },
    },
    init = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    end,
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local icons = require("zezima.constants").icons
      local winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None"
      return {
        preselect = cmp.PreselectMode.None,
        completion = {
          completeopt = "menu,menuone,noselect,preview",
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(_, vim_item)
            local MAX_ABBR_WIDTH, MAX_MENU_WIDTH = 25, 30
            local ellipsis = icons.misc.dots
            -- Add the icon.
            if vim_item.kind == nil then
              vim_item.kind = ""
            end

            vim_item.kind = (icons.kinds[vim_item.kind] or icons.kinds.Text) .. " " .. vim_item.kind
            -- Truncate the label.
            if vim.api.nvim_strwidth(vim_item.abbr) > MAX_ABBR_WIDTH then
              vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, MAX_ABBR_WIDTH) .. ellipsis
            end
            -- Truncate the description part.
            if vim.api.nvim_strwidth(vim_item.menu or "") > MAX_MENU_WIDTH then
              vim_item.menu = vim.fn.strcharpart(vim_item.menu, 0, MAX_MENU_WIDTH) .. ellipsis
            end
            return vim_item
          end,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            border = "rounded",
            winhighlight = winhighlight,
            scrollbar = true,
          },
          documentation = {
            border = "rounded",
            winhighlight = winhighlight,
            max_height = math.floor(vim.o.lines * 0.5),
            max_width = math.floor(vim.o.columns * 0.4),
          },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
          ["/"] = cmp.mapping.close(),
          -- Overload tab to accept Copilot suggestions.
          ["<Tab>"] = cmp.mapping(function(fallback)
            local copilot = require("copilot.suggestion")
            -- Accept the suggestion if it's visible.
            if copilot.is_visible() then
              copilot.accept()
            elseif cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.expand_or_locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        -- Show ghost text for the completion item.
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        -- Configure the sources.
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer", keyword_length = 4 },
        }),
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      -- Inside a snippet, use backspace to remove the placeholder.
      vim.keymap.set("s", "<BS>", "<C-O>s")
      -- Set up the completion plugin.
      cmp.setup(opts)
      -- Autopairs integration.
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
