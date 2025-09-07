vim.pack.add({
  {
    src = "https://github.com/ThePrimeagen/harpoon",
    version = "ed1f853847ffd04b2b61c314865665e1dadf22c7",
  },
})

local harpoon = require("harpoon")

---@diagnostic disable-next-line: missing-fields
harpoon.setup({
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4,
  },
  settings = {
    save_on_toggle = true,
  },
})

vim.keymap.set("n", "<leader>H", function()
  harpoon:list():add()
end, { desc = "Harpoon File" })

vim.keymap.set("n", "<leader>h", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Quick Menu" })

for i = 1, 5 do
  vim.keymap.set("n", "<leader>" .. i, function()
    require("harpoon"):list():select(i)
  end, { desc = "Harpoon to File " .. i })
end

local harpoon_extensions = require("harpoon.extensions")
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
