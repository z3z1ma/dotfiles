vim.pack.add({
  {
    src = "https://github.com/Bekaboo/dropbar.nvim",
    version = "3460930700ca67b4590a69ac3f1d65d5f9658fb6",
  },
})

local dropbar = require("dropbar")
local dropbar_utils = require("dropbar.utils")
dropbar.setup({
  menu = {
    quick_navigation = true,
    keymaps = {
      ["H"] = function()
        local root = dropbar_utils.menu.get_current():root()
        if not root then
          return
        end
        root:close()

        local container = dropbar_utils.bar.get({
          buf = vim.api.nvim_win_get_buf(root.prev_win),
          win = root.prev_win,
        })

        if not container then
          root:toggle()
          return
        end

        local current_idx
        for idx, component in ipairs(container.components) do
          if component.menu == root then
            current_idx = idx
            break
          end
        end

        if current_idx == nil or current_idx == 0 then
          root:toggle()
          return
        end

        vim.defer_fn(function()
          container:pick(current_idx - 1)
        end, 100)
      end,

      ["L"] = function()
        local root = dropbar_utils.menu.get_current():root()
        if not root then
          return
        end
        root:close()

        local container = dropbar_utils.bar.get({
          buf = vim.api.nvim_win_get_buf(root.prev_win),
          win = root.prev_win,
        })

        if not container then
          container = require("dropbar.utils").bar.get_current()
          if not container then
            root:toggle()
            return
          end
        end

        local current_idx
        for idx, component in ipairs(container.components) do
          if component.menu == root then
            current_idx = idx
            break
          end
        end

        if current_idx == nil or current_idx == #container.components then
          root:toggle()
          return
        end

        vim.defer_fn(function()
          container:pick(current_idx + 1)
        end, 100)
      end,
    },
  },
})

local dropbar_api = require("dropbar.api")

vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
