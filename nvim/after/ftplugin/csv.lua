vim.keymap.set("n", "<leader>C", function()
  require("zezima.utils").vim.float_term({ "vd", vim.fn.expand("%") }, {
    ft = "visidata",
    size = { width = 0.9, height = 0.9 },
  })
end, { desc = "Open visidata" })
