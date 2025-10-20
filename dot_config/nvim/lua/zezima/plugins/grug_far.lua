vim.pack.add({
  { src = "https://github.com/MagicDuck/grug-far.nvim" },
})

local grug_far = require("grug-far")

grug_far.setup({ headerMaxWidth = 80 })

vim.keymap.set({ "n", "v" }, "<leader>sr", function()
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  grug_far.open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  })
end, { desc = "Search and Replace" })
